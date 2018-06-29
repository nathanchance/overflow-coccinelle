// Fix redundant parens around sizeof().
@@
type TYPE;
expression THING, E;
@@

(
  kvzalloc_node(
-	(sizeof(TYPE)) * E
+	sizeof(TYPE) * E
  , ...)
|
  kvzalloc_node(
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
  kvzalloc_node(
-	sizeof(u8) * (COUNT)
+	COUNT
  , ...)
|
  kvzalloc_node(
-	sizeof(__u8) * (COUNT)
+	COUNT
  , ...)
|
  kvzalloc_node(
-	sizeof(char) * (COUNT)
+	COUNT
  , ...)
|
  kvzalloc_node(
-	sizeof(unsigned char) * (COUNT)
+	COUNT
  , ...)
|
  kvzalloc_node(
-	sizeof(u8) * COUNT
+	COUNT
  , ...)
|
  kvzalloc_node(
-	sizeof(__u8) * COUNT
+	COUNT
  , ...)
|
  kvzalloc_node(
-	sizeof(char) * COUNT
+	COUNT
  , ...)
|
  kvzalloc_node(
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
  kvzalloc_node(
-	sizeof(TYPE) * (COUNT_ID)
+	array_size(COUNT_ID, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE) * COUNT_ID
+	array_size(COUNT_ID, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE) * (COUNT_CONST)
+	array_size(COUNT_CONST, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE) * COUNT_CONST
+	array_size(COUNT_CONST, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING) * (COUNT_ID)
+	array_size(COUNT_ID, sizeof(THING))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING) * COUNT_ID
+	array_size(COUNT_ID, sizeof(THING))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING) * (COUNT_CONST)
+	array_size(COUNT_CONST, sizeof(THING))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING) * COUNT_CONST
+	array_size(COUNT_CONST, sizeof(THING))
  , ...)
)

// 2-factor product, only identifiers.
@@
identifier SIZE, COUNT;
@@

  kvzalloc_node(
-	SIZE * COUNT
+	array_size(COUNT, SIZE)
  , ...)

// 3-factor product with 1 sizeof(type) or sizeof(expression), with
// redundant parens removed.
@@
expression THING;
identifier STRIDE, COUNT;
type TYPE;
@@

(
  kvzalloc_node(
-	sizeof(TYPE) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE) * COUNT * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  kvzalloc_node(
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
  kvzalloc_node(
-	sizeof(TYPE1) * sizeof(TYPE2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  kvzalloc_node(
-	sizeof(THING1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
|
  kvzalloc_node(
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
)

// 3-factor product, only identifiers, with redundant parens removed.
@@
identifier STRIDE, SIZE, COUNT;
@@

(
  kvzalloc_node(
-	(COUNT) * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kvzalloc_node(
-	COUNT * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kvzalloc_node(
-	COUNT * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kvzalloc_node(
-	(COUNT) * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kvzalloc_node(
-	COUNT * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kvzalloc_node(
-	(COUNT) * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kvzalloc_node(
-	(COUNT) * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  kvzalloc_node(
-	COUNT * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
)

// Any remaining multi-factor products, first at least 3-factor products
// when they're not all constants...
@@
expression E1, E2, E3;
constant C1, C2, C3;
@@

(
  kvzalloc_node(C1 * C2 * C3, ...)
|
  kvzalloc_node(
-	E1 * E2 * E3
+	array3_size(E1, E2, E3)
  , ...)
)

// And then all remaining 2 factors products when they're not all constants.
@@
expression E1, E2;
constant C1, C2;
@@

(
  kvzalloc_node(C1 * C2, ...)
|
  kvzalloc_node(
-	E1 * E2
+	array_size(E1, E2)
  , ...)
)
