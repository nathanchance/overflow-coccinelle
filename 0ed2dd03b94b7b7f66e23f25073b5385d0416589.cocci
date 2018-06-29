// Direct reference to struct field.
@@
identifier alloc =~ "devm_kmalloc|devm_kzalloc|sock_kmalloc|f2fs_kmalloc|f2fs_kzalloc";
expression HANDLE;
expression GFP;
identifier VAR, ELEMENT;
expression COUNT;
@@

- alloc(HANDLE, sizeof(*VAR) + COUNT * sizeof(*VAR->ELEMENT), GFP)
+ alloc(HANDLE, struct_size(VAR, ELEMENT, COUNT), GFP)

// mr = kzalloc(sizeof(*mr) + m * sizeof(mr->map[0]), GFP_KERNEL);
@@
identifier alloc =~ "devm_kmalloc|devm_kzalloc|sock_kmalloc|f2fs_kmalloc|f2fs_kzalloc";
expression HANDLE;
expression GFP;
identifier VAR, ELEMENT;
expression COUNT;
@@

- alloc(HANDLE, sizeof(*VAR) + COUNT * sizeof(VAR->ELEMENT[0]), GFP)
+ alloc(HANDLE, struct_size(VAR, ELEMENT, COUNT), GFP)

// Same pattern, but can't trivially locate the trailing element name,
// or variable name.
@@
identifier alloc =~ "devm_kmalloc|devm_kzalloc|sock_kmalloc|f2fs_kmalloc|f2fs_kzalloc";
expression HANDLE;
expression GFP;
expression SOMETHING, COUNT, ELEMENT;
@@

- alloc(HANDLE, sizeof(SOMETHING) + COUNT * sizeof(ELEMENT), GFP)
+ alloc(HANDLE, CHECKME_struct_size(&SOMETHING, ELEMENT, COUNT), GFP)
