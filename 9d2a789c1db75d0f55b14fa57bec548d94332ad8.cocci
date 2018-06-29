// Fix redundant parens around sizeof().
@@
expression HANDLE;
type TYPE;
expression THING, E;
@@

(
  f2fs_kvzalloc(HANDLE,
-	(sizeof(TYPE)) * E
+	sizeof(TYPE) * E
  , ...)
|
  f2fs_kvzalloc(HANDLE,
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
  f2fs_kvzalloc(HANDLE,
-	sizeof(u8) * (COUNT)
+	COUNT
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(__u8) * (COUNT)
+	COUNT
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(char) * (COUNT)
+	COUNT
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(unsigned char) * (COUNT)
+	COUNT
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(u8) * COUNT
+	COUNT
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(__u8) * COUNT
+	COUNT
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(char) * COUNT
+	COUNT
  , ...)
|
  f2fs_kvzalloc(HANDLE,
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
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * (COUNT_ID)
+	array_size(COUNT_ID, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * COUNT_ID
+	array_size(COUNT_ID, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * (COUNT_CONST)
+	array_size(COUNT_CONST, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * COUNT_CONST
+	array_size(COUNT_CONST, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING) * (COUNT_ID)
+	array_size(COUNT_ID, sizeof(THING))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING) * COUNT_ID
+	array_size(COUNT_ID, sizeof(THING))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING) * (COUNT_CONST)
+	array_size(COUNT_CONST, sizeof(THING))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING) * COUNT_CONST
+	array_size(COUNT_CONST, sizeof(THING))
  , ...)
)

// 2-factor product, only identifiers.
@@
expression HANDLE;
identifier SIZE, COUNT;
@@

  f2fs_kvzalloc(HANDLE,
-	SIZE * COUNT
+	array_size(COUNT, SIZE)
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
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE) * COUNT * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(TYPE))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING) * (COUNT) * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING) * (COUNT) * STRIDE
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING) * COUNT * (STRIDE)
+	array3_size(COUNT, STRIDE, sizeof(THING))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
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
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE1) * sizeof(TYPE2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(TYPE1), sizeof(TYPE2))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(THING1) * sizeof(THING2) * (COUNT)
+	array3_size(COUNT, sizeof(THING1), sizeof(THING2))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	sizeof(TYPE1) * sizeof(THING2) * COUNT
+	array3_size(COUNT, sizeof(TYPE1), sizeof(THING2))
  , ...)
|
  f2fs_kvzalloc(HANDLE,
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
  f2fs_kvzalloc(HANDLE,
-	(COUNT) * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	COUNT * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	COUNT * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	(COUNT) * (STRIDE) * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	COUNT * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	(COUNT) * STRIDE * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	(COUNT) * (STRIDE) * (SIZE)
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
|
  f2fs_kvzalloc(HANDLE,
-	COUNT * STRIDE * SIZE
+	array3_size(COUNT, STRIDE, SIZE)
  , ...)
)

// Any remaining multi-factor products, first at least 3-factor products
// when they're not all constants...
@@
expression HANDLE;
expression E1, E2, E3;
constant C1, C2, C3;
@@

(
  f2fs_kvzalloc(HANDLE, C1 * C2 * C3, ...)
|
  f2fs_kvzalloc(HANDLE,
-	E1 * E2 * E3
+	array3_size(E1, E2, E3)
  , ...)
)

// And then all remaining 2 factors products when they're not all constants.
@@
expression HANDLE;
expression E1, E2;
constant C1, C2;
@@

(
  f2fs_kvzalloc(HANDLE, C1 * C2, ...)
|
  f2fs_kvzalloc(HANDLE,
-	E1 * E2
+	array_size(E1, E2)
  , ...)
)
