#!/usr/bin/env python3
"""
Converts utool's old (3.1-era) XML redundancy-elimination equivalence format
(<equivalences><equivalencegroup><quantifier label=.. hole=../>...</equivalencegroup>
<permutesWithEverything label=.. hole=../></equivalences>)
into the plaintext rewrite-system syntax understood by utool 3.2+'s
RewritingSystemParser (the -f/--filter option), which replaced the old
-e/--equivalences mechanism without anyone porting this file.

Semantics of the old format (utool 3.1 manual, Sec. 3.7.1):
  <quantifier label="L" hole="H"/> entries within one <equivalencegroup> can
  all be permuted with each other: if a group member L1's H1-th child is
  another group member L2 (with L2 itself listed at hole H2), then L1 and L2
  may swap places.

  <permutesWithEverything label="L" hole="H"/>: L's H-th child may swap
  outward past ANY other node, regardless of that node's label/hole.

General pairwise swap rule (derived and verified against utool's own
hand-written test cases, e.g. eqSystemFol's 1-1/1-0/0-0 rules for `a`):

  Let outer = L1(x0,x1), with its H1-th arg being inner = L2(y0,y1)
  (so before the swap: x[H1] = L2(y0,y1), and A = x[1-H1] is the outer's
  other, untouched arg).

  After the swap, L2 becomes the new outer:
     new-arg[H2] of L2  = L1( arg[H1] = y[H2], arg[1-H1] = A )
     new-arg[1-H2] of L2 = y[1-H2]   (unchanged)

For self-pairs (L1 == L2), the (H1=0,H2=1) and (H1=1,H2=0) cases produce the
same equation up to variable renaming, so only one of them is emitted.
"""
import itertools
import sys
import xml.etree.ElementTree as ET

def swap_rule(l1, h1, l2, h2, idx1, idx2):
    """Return (lhs_str, rhs_str) for outer=l1 (nest hole h1) / inner=l2 (target hole h2)."""
    A = "A"
    Y = ["Y0", "Y1"]

    outer_args = [None, None]
    outer_args[h1] = f"{l2}#{idx2}({Y[0]},{Y[1]})"
    outer_args[1 - h1] = A
    lhs = f"{l1}#{idx1}({outer_args[0]},{outer_args[1]})"

    inner_l1_args = [None, None]
    inner_l1_args[h1] = Y[h2]
    inner_l1_args[1 - h1] = A
    l1_term = f"{l1}#{idx1}({inner_l1_args[0]},{inner_l1_args[1]})"

    new_l2_args = [None, None]
    new_l2_args[h2] = l1_term
    new_l2_args[1 - h2] = Y[1 - h2]
    rhs = f"{l2}#{idx2}({new_l2_args[0]},{new_l2_args[1]})"

    return lhs, rhs


def pairwise_rules(entries):
    """entries: list of (label, hole). Yields (lhs, rhs) equivalence rule strings."""
    seen = set()
    for (l1, h1), (l2, h2) in itertools.product(entries, entries):
        # Canonicalize to avoid emitting the redundant mirror for self-pairs
        # (l1,h1,l2,h2) vs (l2,h2,l1,h1) when l1==l2: these are the same
        # equation up to variable renaming (verified by hand above).
        if l1 == l2:
            key = (l1, frozenset((h1, h2)))
            if h1 != h2:
                if key in seen:
                    continue
                seen.add(key)
        lhs, rhs = swap_rule(l1, h1, l2, h2, 1, 2)
        yield lhs, rhs


def main():
    infile, outfile = sys.argv[1], sys.argv[2]
    tree = ET.parse(infile)
    root = tree.getroot()

    lines = []
    lines.append("// Auto-converted from the utool 3.1-era XML equivalence format")
    lines.append(f"// (source: {infile}) to the utool 3.2+ RewritingSystemParser syntax.")
    lines.append("")
    lines.append("start annotation: +")
    lines.append("neutral annotation: 0")
    lines.append("")

    n_group_rules = 0
    n_wildcard_rules = 0

    for group in root.findall("equivalencegroup"):
        entries = []
        for q in group.findall("quantifier"):
            entries.append((q.attrib["label"], int(q.attrib["hole"])))

        lines.append(f"// equivalencegroup: {', '.join(f'{l}#{h}' for l, h in entries)}")
        for lhs, rhs in pairwise_rules(entries):
            lines.append(f"{lhs} = {rhs}")
            n_group_rules += 1
        lines.append("")

    for pwe in root.findall("permutesWithEverything"):
        label = pwe.attrib["label"]
        hole = int(pwe.attrib["hole"])
        other = "A" if hole == 1 else "A"  # the label's own untouched arg
        if hole == 1:
            lhs = f"{label}(A,*[Y])"
            rhs = f"*[{label}(A,Y)]"
        else:
            lhs = f"{label}(*[Y],A)"
            rhs = f"*[{label}(Y,A)]"
        lines.append(f"// permutesWithEverything: {label}#{hole}")
        lines.append(f"{lhs} = {rhs}")
        n_wildcard_rules += 1
        lines.append("")

    with open(outfile, "w") as f:
        f.write("\n".join(lines) + "\n")

    print(f"Wrote {outfile}: {n_group_rules} group-permutation rules, "
          f"{n_wildcard_rules} permutes-with-everything rules.", file=sys.stderr)


if __name__ == "__main__":
    main()
