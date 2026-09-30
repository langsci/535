#!/usr/bin/env python3
"""Convert the signature-only TDL subset used by the textbook grammars to ALE declarations.

Supports named supertypes and flat feature/type appropriateness declarations.
Rejects other TDL constructs instead of silently dropping constraints. TRALE
completes multiple inheritance with ale_flag(msl,_,off).
"""
import argparse
from pathlib import Path
import re


def parse(text):
    text = re.sub(r';[^\n]*', '', text)
    token = re.compile(r'\s+|:=|:<|[&\[\],.]|[^\W\d][\w-]*', re.UNICODE)
    tokens = []
    pos = 0
    while pos < len(text):
        match = token.match(text, pos)
        if not match:
            raise ValueError(f'Unsupported TDL at line {text[:pos].count(chr(10)) + 1}: {text[pos:pos+40]!r}')
        if not match.group().isspace():
            tokens.append(match.group().lower())
        pos = match.end()
    pos = 0

    def take(expected=None):
        nonlocal pos
        if pos == len(tokens):
            raise ValueError('Unexpected end of TDL')
        value = tokens[pos]
        pos += 1
        if expected is not None and value != expected:
            raise ValueError(f'Expected {expected!r}, got {value!r} at token {pos}')
        return value

    def name():
        value = take()
        if not re.fullmatch(r'[^\W\d][\w-]*', value):
            raise ValueError(f'Expected a type or feature name, got {value!r}')
        return value

    parents = {'bot': []}
    features = {'bot': {}}
    while pos < len(tokens):
        typ = name()
        if typ in parents:
            raise ValueError(f'Duplicate or reserved type: {typ}')
        operator = take()
        if operator not in (':=', ':<'):
            raise ValueError(f'Expected := or :<, got {operator!r}')
        supers, feats = [], {}
        while True:
            if tokens[pos] == '[':
                take('[')
                while True:
                    feature, value = name(), name()
                    if feature in feats:
                        raise ValueError(f'Duplicate feature {typ}.{feature}')
                    feats[feature] = value
                    if tokens[pos] != ',':
                        break
                    take(',')
                take(']')
            else:
                supers.append(name())
            if tokens[pos] != '&':
                break
            take('&')
        take('.')
        if not supers:
            raise ValueError(f'No supertype for {typ}')
        parents[typ], features[typ] = supers, feats
    for typ in parents:
        for reference in parents[typ] + list(features[typ].values()):
            if reference not in parents:
                raise ValueError(f'Unknown type {reference} in {typ}')
    return parents, features


def direct_children(parents):
    ancestors = {}

    def visit(typ, path):
        if typ in path:
            raise ValueError(f'Inheritance cycle at {typ}')
        if typ not in ancestors:
            result = {typ}
            for parent in parents[typ]:
                result.update(visit(parent, path | {typ}))
            ancestors[typ] = result
        return ancestors[typ]

    for typ in parents:
        visit(typ, set())
    children = {typ: [] for typ in parents}
    for typ, supers in parents.items():
        for parent in sorted(set(supers)):
            # Omit redundant links but preserve all multiple inheritance.
            if not any(parent != other and parent in ancestors[other]
                       for other in supers):
                children[parent].append(typ)
    return {typ: sorted(subtypes) for typ, subtypes in children.items()}


def atom(value):
    # Ordinary lowercase identifiers, including Unicode, are Prolog atoms.
    if value[0].islower() and re.fullmatch(r"\w+", value):
        return value
    return "'" + value.replace("'", "''") + "'"


def restriction(value):
    # Match lkb2signature.lsp: TDL string-valued features hold Prolog atoms,
    # e.g. the NAME of named_rel. The named type string itself is retained.
    return '(a_ _)' if value in ('string', '(a_ _)') else atom(value)


def parse_signature(text):
    """Read the indentation format of older chapters without types.tdl."""
    parents, features, stack = {}, {}, []
    started = ended = False
    for number, raw in enumerate(text.splitlines(), 1):
        raw = raw.split('%', 1)[0].rstrip()
        line = raw.strip()
        if not line:
            continue
        if line == 'type_hierarchy' and not started:
            started = True
            continue
        if line == '.' and started:
            ended = True
            continue
        if not started or ended:
            raise ValueError(f'Unexpected signature content at line {number}')
        depth = len(raw) - len(raw.lstrip())
        typ, *rest = line.split(maxsplit=1)
        typ = typ.lstrip('&')
        if not re.fullmatch(r'[^\W\d][\w-]*', typ):
            raise ValueError(f'Unsupported type at line {number}: {typ}')
        parents.setdefault(typ, [])
        feats = features.setdefault(typ, {})
        tail = rest[0] if rest else ''
        while tail:
            match = re.match(r'([^\W\d][\w-]*):\s*(\(a_ _\)|[^\W\d][\w-]*)\s*', tail)
            if not match:
                raise ValueError(f'Unsupported feature at line {number}: {tail}')
            feature, value = match.groups()
            if feature in feats and feats[feature] != value:
                raise ValueError(f'Conflicting feature {typ}.{feature}')
            feats[feature] = value
            tail = tail[match.end():]
        while stack and stack[-1][0] >= depth:
            stack.pop()
        if stack:
            parents[typ].append(stack[-1][1])
        elif typ != 'bot':
            raise ValueError(f'Unexpected root at line {number}')
        stack.append((depth, typ))
    if not ended or 'bot' not in parents:
        raise ValueError('Incomplete signature')
    for typ, feats in features.items():
        for value in feats.values():
            if value != '(a_ _)' and value not in parents:
                raise ValueError(f'Unknown value type {value} in {typ}')
    return parents, features


def convert(text, source_format='tdl'):
    if source_format == 'tdl':
        parents, features = parse(text)
        source = 'lkb/types.tdl'
    elif source_format == 'signature':
        parents, features = parse_signature(text)
        source = 'signature'
    else:
        raise ValueError(f'Unsupported source format: {source_format}')
    children = direct_children(parents)
    lines = ["% -*- coding:utf-8; mode:trale-prolog -*-",
             f"% Generated from {source} by ../Gemeinsames/tdl_to_signature.py.",
             f"% Do not edit: regenerate after changes to {source}.",
             "% Load with ale_flag(subintro,_,grammar) and ale_flag(msl,_,off).",
             ""]
    # Display the hierarchy depth-first, declaring multiply inherited types
    # only once. All parent links remain present in the sub lists.
    seen = set()

    def emit(typ, depth):
        if typ in seen:
            return
        seen.add(typ)
        label = '  ' * depth + atom(typ) + ' '
        line = label + f'sub [{", ".join(map(atom, children[typ]))}]'
        if features.get(typ):
            lines.append(line)
            pairs = [f'{atom(f)}:{restriction(v)}'
                     for f, v in features[typ].items()]
            prefix = ' ' * len(label) + 'intro ['
            lines.append(prefix + (',\n' + ' ' * len(prefix)).join(pairs) + '].')
        else:
            lines.append(line + '.')
        for child in children[typ]:
            emit(child, depth + 1)

    emit('bot', 0)
    return '\n'.join(lines) + '\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--format', choices=('tdl', 'signature'), default='tdl')
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    try:
        result = convert(args.source.read_text(encoding='utf-8'), args.format)
    except (ValueError, IndexError) as error:
        parser.error(str(error))
    args.output.write_text(result, encoding='utf-8')


if __name__ == '__main__':
    main()
