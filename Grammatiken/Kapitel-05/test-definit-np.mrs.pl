psoa(h1,e2,
[
 rel('def_q',h3,
     [ attrval('ARG0',x4),
       attrval('RSTR',h5),
       attrval('BODY',h6)]),
 rel('affe_rel',h7,
     [ attrval('ARG0',x4)]),
 rel('def_q',h8,
     [ attrval('ARG0',x9),
       attrval('RSTR',h10),
       attrval('BODY',h11)]),
 rel('buch_rel',h12,
     [ attrval('ARG0',x9)]),
 rel('kennen_rel',h13,
     [ attrval('ARG0',e2),
       attrval('ARG1',x4),
       attrval('ARG2',x9)])],
 hcons([
 qeq(h5,h7),
 qeq(h10,h12)
 ]))