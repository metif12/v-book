# Array

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## Operazioni sugli array

```v
fn main() {
    mut a := [1, 2, 3]
    a << 4
    a << [5, 6]
    println(a)
    println(a[1..3])
}
```

## Avanti

[Mappe](ch08-02-maps.md)
