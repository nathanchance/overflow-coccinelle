// Fix redundant parens around sizeof().
@@
expression HANDLE;
type TYPE;
expression THING, E;
@@

(
  devm_kzalloc(HANDLE,
-	(sizeof(TYPE)) * E
+	sizeof(TYPE) * E
  , ...)
|
  devm_kzalloc(HANDLE,
-	(sizeof(THING)) * E
+	sizeof(THING) * E
  , ...)
)

// Drop single-byte sizes and redundant parens.
@@
expression HANDLE;
expression COUNT;
typedef u8;
typedef __u8;
@@

(
  devm_kzalloc(HANDLE,
-	sizeof(u8) * (COUNT)
+	COUNT
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(__u8) * (COUNT)
+	COUNT
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(char) * (COUNT)
+	COUNT
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(unsigned char) * (COUNT)
+	COUNT
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(u8) * COUNT
+	COUNT
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(__u8) * COUNT
+	COUNT
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(char) * COUNT
+	COUNT
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(unsigned char) * COUNT
+	COUNT
  , ...)
)

// 2-factor product with sizeof(type/expression) and identifier or constant.
@@
expression HANDLE;
type TYPE;
expression THING;
identifier COUNT_ID;
constant COUNT_CONST;
@@

(
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(TYPE) * (COUNT_ID)
+	COUNT_ID, sizeof(TYPE)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(TYPE) * COUNT_ID
+	COUNT_ID, sizeof(TYPE)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(TYPE) * (COUNT_CONST)
+	COUNT_CONST, sizeof(TYPE)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(TYPE) * COUNT_CONST
+	COUNT_CONST, sizeof(TYPE)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(THING) * (COUNT_ID)
+	COUNT_ID, sizeof(THING)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(THING) * COUNT_ID
+	COUNT_ID, sizeof(THING)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(THING) * (COUNT_CONST)
+	COUNT_CONST, sizeof(THING)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(THING) * COUNT_CONST
+	COUNT_CONST, sizeof(THING)
  , ...)
)

// 2-factor product, only identifiers.
@@
expression HANDLE;
identifier SIZE, COUNT;
@@

- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	SIZE * COUNT
+	COUNT, SIZE
  , ...)

// 3-factor product with 1 sizeof(type) or sizeof(expression), with
// redundant parens removed.
@@
expression HANDLE;
expression THING;
identifier STRIDE, COUNT;
type TYPE;
@@

(
  devm_kzalloc(HANDLE,
-	sizeof(TYPE) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(TYPE) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(TYPE) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(TYPE) * COUNT * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(THING) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(THING) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(THING) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(THING) * COUNT * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
)

// 3-factor product with 2 sizeof(variable), with redundant parens removed.
@@
expression HANDLE;
expression THING1, THING2;
identifier COUNT;
type TYPE1, TYPE2;
@@

(
  devm_kzalloc(HANDLE,
-	sizeof(TYPE1) * sizeof(TYPE2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(THING1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(THING1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(TYPE1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
|
  devm_kzalloc(HANDLE,
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
)

// 3-factor product, only identifiers, with redundant parens removed.
@@
expression HANDLE;
identifier STRIDE, SIZE, COUNT;
@@

(
  devm_kzalloc(HANDLE,
-	(COUNT) * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  devm_kzalloc(HANDLE,
-	COUNT * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  devm_kzalloc(HANDLE,
-	COUNT * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  devm_kzalloc(HANDLE,
-	(COUNT) * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  devm_kzalloc(HANDLE,
-	COUNT * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  devm_kzalloc(HANDLE,
-	(COUNT) * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  devm_kzalloc(HANDLE,
-	(COUNT) * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  devm_kzalloc(HANDLE,
-	COUNT * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
)

// Any remaining multi-factor products, first at least 3-factor products,
// when they're not all constants...
@@
expression HANDLE;
expression E1, E2, E3;
constant C1, C2, C3;
@@

(
  devm_kzalloc(HANDLE, C1 * C2 * C3, ...)
|
  devm_kzalloc(HANDLE,
-	(E1) * E2 * E3
+	array3_size(E1, E2, E3)
  , ...)
|
  devm_kzalloc(HANDLE,
-	(E1) * (E2) * E3
+	array3_size(E1, E2, E3)
  , ...)
|
  devm_kzalloc(HANDLE,
-	(E1) * (E2) * (E3)
+	array3_size(E1, E2, E3)
  , ...)
|
  devm_kzalloc(HANDLE,
-	E1 * E2 * E3
+	array3_size(E1, E2, E3)
  , ...)
)

// And then all remaining 2 factors products when they're not all constants,
// keeping sizeof() as the second factor argument.
@@
expression HANDLE;
expression THING, E1, E2;
type TYPE;
constant C1, C2, C3;
@@

(
  devm_kzalloc(HANDLE, sizeof(THING) * C2, ...)
|
  devm_kzalloc(HANDLE, sizeof(TYPE) * C2, ...)
|
  devm_kzalloc(HANDLE, C1 * C2 * C3, ...)
|
  devm_kzalloc(HANDLE, C1 * C2, ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(TYPE) * (E2)
+	E2, sizeof(TYPE)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(TYPE) * E2
+	E2, sizeof(TYPE)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(THING) * (E2)
+	E2, sizeof(THING)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	sizeof(THING) * E2
+	E2, sizeof(THING)
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	(E1) * E2
+	E1, E2
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	(E1) * (E2)
+	E1, E2
  , ...)
|
- devm_kzalloc
+ devm_kcalloc
  (HANDLE,
-	E1 * E2
+	E1, E2
  , ...)
)
