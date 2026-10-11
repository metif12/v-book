# Chapter 7: Modules and Packages

## Module System

V organizes code into modules. A module is a directory with `.v` files:

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v`:

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v`:

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## Visibility

- `pub` — public, accessible from other modules
- (no modifier) — private, module-only

## VPM

Community packages live in the VPM registry, and `v install` puts them into `~/.vmodules`. Search first — what is available changes:

```bash
v install markdown
```

The next chapter looks at the module system in detail.

## Summary

In this chapter, you learned about modules, visibility, and VPM. In the next chapter, we'll explore collections.
