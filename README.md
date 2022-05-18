Crimson is an "object notation" language, similar in respect to JSON.
It intends to build an object notation for a typed language.
Heavily inspired by Ron 'Rust object notation'.

Maintenance/usage: This isn't a finished project, or a project under active sustained development.
It's something I work on from time to time between other projects... 

Expect it to change incompatibly from it's current state.

* Goals:
    * Typed(?)
    * Type inference
    * Differentiate between Ordered and unordered collections.
    * Natural support for graph-like data.
    * Allow type definitions and pure constructors.
    * Allow enum constants and user defined structs.
    * Ranges as first class types.
    * Constants
    * Efficient support for collections of data with fixed size children.

* Non-Goals:
    * Easily edited (If we run out of brackets, we may use ones from unicode)

+ Array:  `[a, b, c]`,
+ Set:    `{a, b, c}`,
+ Map:    `{A=a, B=b}`.
+ Range:  `start..end`,
+ Char:   `'c'`,
+ String: `"foo"`,
+ N-tuple `(a, b, c)`

Types go first and are enclosed in `<>`

Types:  <Array(<String({Len=3})>, {Len=2})>{"wor", "hel"}

Crimson allows user declared types, in a type header, subsequent values can then refer to these by name:

```
struct Foo {
  foo: String
}
```

```
#[repr(u8)]
enum Bar {
  A = 0,
  B,
  C,
}
```
