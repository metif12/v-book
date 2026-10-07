# গার্বেজ কালেকশন

V ডিফল্টভাবে গার্বেজ কালেক্টর ব্যবহার করে:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## GC নিষ্ক্রিয় করা

পারফরম্যান্স-সংবেদনশীল কোডের জন্য, আপনি GC নিষ্ক্রিয় করতে পারেন:

```bash
v -gc none main.v
```

## পরবর্তী

[অটোফ্রি](ch04-03-autofree.md)
