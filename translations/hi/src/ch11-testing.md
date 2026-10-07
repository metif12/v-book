# अध्याय 11: टेस्टिंग

V में एक बिल्ट-इन टेस्टिंग फ्रेमवर्क है।

## टेस्ट फ़ाइलें

`_test.v` पर समाप्त होने वाली एक फ़ाइल बनाएं:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## टेस्ट चलाना

```bash
v test .
```

## टेस्ट ऑर्गनाइज़ेशन

```v
fn add(a int, b int) int {
    return a + b
}

fn sub(a int, b int) int {
    return a - b
}

fn mul(a int, b int) int {
    return a * b
}

fn test_add() {
    assert add(2, 3) == 5
}

fn test_sub() {
    assert sub(5, 3) == 2
}

fn test_mul() {
    assert mul(2, 3) == 6
}
```

## टेबल-ड्रिवन टेस्ट

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    tests := [
        [2, 3, 5],
        [-1, 1, 0],
        [0, 0, 0],
    ]
    for t in tests {
        assert add(t[0], t[1]) == t[2]
    }
}
```

## सारांश

इस अध्याय में, आपने V के टेस्टिंग फ्रेमवर्क के बारे में सीखा। अगले अध्याय में, हम एक कमांड-लाइन टूल बनाएंगे।
