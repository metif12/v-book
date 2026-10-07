# अध्याय 13: फ़ंक्शनल फ़ीचर्स

V क्लोज़र और हायर-ऑर्डर फ़ंक्शन को सपोर्ट करता है।

## क्लोज़र

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## हायर-ऑर्डर फ़ंक्शन

```v
fn apply(f fn (int) int, x int) int {
    return f(x)
}

fn main() {
    double := fn (x int) int {
        return x * 2
    }
    println(apply(double, 5))
}
```

## अनोनिमस फ़ंक्शन

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## सारांश

इस अध्याय में, आपने क्लोज़र और हायर-ऑर्डर फ़ंक्शन के बारे में सीखा। अगले अध्याय में, हम कॉनकरेंसी का पता लगाएंगे।
