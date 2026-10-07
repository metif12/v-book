# Formatting with v fmt

V has a built-in code formatter:

```bash
v fmt -w .
```

The `-w` flag writes changes back to files. Without it, the formatter prints to stdout.

## Example

Before:

```v
fn main(){
println( 'hello' )
}
```

After `v fmt`:

```v
fn main() {
    println('hello')
}
```

## Next

[Testing with v test](ch02-04-testing.md)
