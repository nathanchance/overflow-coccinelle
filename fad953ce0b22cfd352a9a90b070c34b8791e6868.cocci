// Fix redundant parens around sizeof().
@@
type TYPE;
expression THING, E;
@@

(
  vzalloc(
-	(sizeof(TYPE)) * E
+	sizeof(TYPE) * E
  , ...)
|
  vzalloc(
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
  vzalloc(
-	sizeof(u8) * (COUNT)
+	COUNT
  , ...)
|
  vzalloc(
-	sizeof(__u8) * (COUNT)
+	COUNT
  , ...)
|
  vzalloc(
-	sizeof(char) * (COUNT)
+	COUNT
  , ...)
|
  vzalloc(
-	sizeof(unsigned char) * (COUNT)
+	COUNT
  , ...)
|
  vzalloc(
-	sizeof(u8) * COUNT
+	COUNT
  , ...)
|
  vzalloc(
-	sizeof(__u8) * COUNT
+	COUNT
  , ...)
|
  vzalloc(
-	sizeof(char) * COUNT
+	COUNT
  , ...)
|
  vzalloc(
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
  vzalloc(
-	sizeof(TYPE) * (COUNT_ID)
+	array_size(COUNT_ID, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(TYPE) * COUNT_ID
+	array_size(COUNT_ID, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(TYPE) * (COUNT_CONST)
+	array_size(COUNT_CONST, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(TYPE) * COUNT_CONST
+	array_size(COUNT_CONST, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(THING) * (COUNT_ID)
+	array_size(COUNT_ID, sizeof(THING))
  , ...)
|
  vzalloc(
-	sizeof(THING) * COUNT_ID
+	array_size(COUNT_ID, sizeof(THING))
  , ...)
|
  vzalloc(
-	sizeof(THING) * (COUNT_CONST)
+	array_size(COUNT_CONST, sizeof(THING))
  , ...)
|
  vzalloc(
-	sizeof(THING) * COUNT_CONST
+	array_size(COUNT_CONST, sizeof(THING))
  , ...)
)

// 2-factor product, only identifiers.
@@
identifier SIZE, COUNT;
@@

  vzalloc(
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
  vzalloc(
-	sizeof(TYPE) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(TYPE) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(TYPE) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(TYPE) * COUNT * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  vzalloc(
-	sizeof(THING) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  vzalloc(
-	sizeof(THING) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  vzalloc(
-	sizeof(THING) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  vzalloc(
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
  vzalloc(
-	sizeof(TYPE1) * sizeof(TYPE2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  vzalloc(
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  vzalloc(
-	sizeof(THING1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  vzalloc(
-	sizeof(THING1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  vzalloc(
-	sizeof(TYPE1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
|
  vzalloc(
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
)

// 3-factor product, only identifiers, with redundant parens removed.
@@
identifier STRIDE, SIZE, COUNT;
@@

(
  vzalloc(
-	(COUNT) * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  vzalloc(
-	COUNT * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  vzalloc(
-	COUNT * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  vzalloc(
-	(COUNT) * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  vzalloc(
-	COUNT * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  vzalloc(
-	(COUNT) * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  vzalloc(
-	(COUNT) * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  vzalloc(
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
  vzalloc(C1 * C2 * C3, ...)
|
  vzalloc(
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
  vzalloc(C1 * C2, ...)
|
  vzalloc(
-	E1 * E2
+	array_size(E1, E2)
  , ...)
)
