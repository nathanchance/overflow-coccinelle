// Fix redundant parens around sizeof().
@@
type TYPE;
expression THING, E;
@@

(
  kzalloc_node(
-	(sizeof(TYPE)) * E
+	sizeof(TYPE) * E
  , ...)
|
  kzalloc_node(
-	(sizeof(THING)) * E
+	sizeof(THING) * E
  , ...)
)

// Drop single-byte sizes and redundant parens.
@@
expression COUNT;
typedef u8;
typedef __u8;
@@

(
  kzalloc_node(
-	sizeof(u8) * (COUNT)
+	COUNT
  , ...)
|
  kzalloc_node(
-	sizeof(__u8) * (COUNT)
+	COUNT
  , ...)
|
  kzalloc_node(
-	sizeof(char) * (COUNT)
+	COUNT
  , ...)
|
  kzalloc_node(
-	sizeof(unsigned char) * (COUNT)
+	COUNT
  , ...)
|
  kzalloc_node(
-	sizeof(u8) * COUNT
+	COUNT
  , ...)
|
  kzalloc_node(
-	sizeof(__u8) * COUNT
+	COUNT
  , ...)
|
  kzalloc_node(
-	sizeof(char) * COUNT
+	COUNT
  , ...)
|
  kzalloc_node(
-	sizeof(unsigned char) * COUNT
+	COUNT
  , ...)
)

// 2-factor product with sizeof(type/expression) and identifier or constant.
@@
type TYPE;
expression THING;
identifier COUNT_ID;
constant COUNT_CONST;
@@

(
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(TYPE) * (COUNT_ID)
+	COUNT_ID, sizeof(TYPE)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(TYPE) * COUNT_ID
+	COUNT_ID, sizeof(TYPE)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(TYPE) * (COUNT_CONST)
+	COUNT_CONST, sizeof(TYPE)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(TYPE) * COUNT_CONST
+	COUNT_CONST, sizeof(TYPE)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(THING) * (COUNT_ID)
+	COUNT_ID, sizeof(THING)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(THING) * COUNT_ID
+	COUNT_ID, sizeof(THING)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(THING) * (COUNT_CONST)
+	COUNT_CONST, sizeof(THING)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(THING) * COUNT_CONST
+	COUNT_CONST, sizeof(THING)
  , ...)
)

// 2-factor product, only identifiers.
@@
identifier SIZE, COUNT;
@@

- kzalloc_node
+ kcalloc_node
  (
-	SIZE * COUNT
+	COUNT, SIZE
  , ...)

// 3-factor product with 1 sizeof(type) or sizeof(expression), with
// redundant parens removed.
@@
expression THING;
identifier STRIDE, COUNT;
type TYPE;
@@

(
  kzalloc_node(
-	sizeof(TYPE) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kzalloc_node(
-	sizeof(TYPE) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kzalloc_node(
-	sizeof(TYPE) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kzalloc_node(
-	sizeof(TYPE) * COUNT * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kzalloc_node(
-	sizeof(THING) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  kzalloc_node(
-	sizeof(THING) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  kzalloc_node(
-	sizeof(THING) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  kzalloc_node(
-	sizeof(THING) * COUNT * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
)

// 3-factor product with 2 sizeof(variable), with redundant parens removed.
@@
expression THING1, THING2;
identifier COUNT;
type TYPE1, TYPE2;
@@

(
  kzalloc_node(
-	sizeof(TYPE1) * sizeof(TYPE2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  kzalloc_node(
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  kzalloc_node(
-	sizeof(THING1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  kzalloc_node(
-	sizeof(THING1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  kzalloc_node(
-	sizeof(TYPE1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
|
  kzalloc_node(
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
)

// 3-factor product, only identifiers, with redundant parens removed.
@@
identifier STRIDE, SIZE, COUNT;
@@

(
  kzalloc_node(
-	(COUNT) * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kzalloc_node(
-	COUNT * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kzalloc_node(
-	COUNT * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kzalloc_node(
-	(COUNT) * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kzalloc_node(
-	COUNT * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kzalloc_node(
-	(COUNT) * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kzalloc_node(
-	(COUNT) * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kzalloc_node(
-	COUNT * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
)

// Any remaining multi-factor products, first at least 3-factor products,
// when they're not all constants...
@@
expression E1, E2, E3;
constant C1, C2, C3;
@@

(
  kzalloc_node(C1 * C2 * C3, ...)
|
  kzalloc_node(
-	(E1) * E2 * E3
+	array3_size(E1, E2, E3)
  , ...)
|
  kzalloc_node(
-	(E1) * (E2) * E3
+	array3_size(E1, E2, E3)
  , ...)
|
  kzalloc_node(
-	(E1) * (E2) * (E3)
+	array3_size(E1, E2, E3)
  , ...)
|
  kzalloc_node(
-	E1 * E2 * E3
+	array3_size(E1, E2, E3)
  , ...)
)

// And then all remaining 2 factors products when they're not all constants,
// keeping sizeof() as the second factor argument.
@@
expression THING, E1, E2;
type TYPE;
constant C1, C2, C3;
@@

(
  kzalloc_node(sizeof(THING) * C2, ...)
|
  kzalloc_node(sizeof(TYPE) * C2, ...)
|
  kzalloc_node(C1 * C2 * C3, ...)
|
  kzalloc_node(C1 * C2, ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(TYPE) * (E2)
+	E2, sizeof(TYPE)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(TYPE) * E2
+	E2, sizeof(TYPE)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(THING) * (E2)
+	E2, sizeof(THING)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	sizeof(THING) * E2
+	E2, sizeof(THING)
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	(E1) * E2
+	E1, E2
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	(E1) * (E2)
+	E1, E2
  , ...)
|
- kzalloc_node
+ kcalloc_node
  (
-	E1 * E2
+	E1, E2
  , ...)
)
