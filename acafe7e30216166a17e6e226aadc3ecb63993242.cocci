// pkey_cache = kmalloc(sizeof *pkey_cache + tprops->pkey_tbl_len *
//                      sizeof *pkey_cache->table, GFP_KERNEL);
@@
identifier alloc =~ "kmalloc|kzalloc|kvmalloc|kvzalloc";
expression GFP;
identifier VAR, ELEMENT;
expression COUNT;
@@

- alloc(sizeof(*VAR) + COUNT * sizeof(*VAR->ELEMENT), GFP)
+ alloc(struct_size(VAR, ELEMENT, COUNT), GFP)

// mr = kzalloc(sizeof(*mr) + m * sizeof(mr->map[0]), GFP_KERNEL);
@@
identifier alloc =~ "kmalloc|kzalloc|kvmalloc|kvzalloc";
expression GFP;
identifier VAR, ELEMENT;
expression COUNT;
@@

- alloc(sizeof(*VAR) + COUNT * sizeof(VAR->ELEMENT[0]), GFP)
+ alloc(struct_size(VAR, ELEMENT, COUNT), GFP)

// Same pattern, but can't trivially locate the trailing element name,
// or variable name.
@@
identifier alloc =~ "kmalloc|kzalloc|kvmalloc|kvzalloc";
expression GFP;
expression SOMETHING, COUNT, ELEMENT;
@@

- alloc(sizeof(SOMETHING) + COUNT * sizeof(ELEMENT), GFP)
+ alloc(CHECKME_struct_size(&SOMETHING, ELEMENT, COUNT), GFP)
