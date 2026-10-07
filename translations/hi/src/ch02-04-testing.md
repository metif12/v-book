# v test के साथ टेस्टिंग

V में एक बिल्ट-इन टेस्टिंग फ्रेमवर्क है। `_test.v` पर समाप्त होने वाली एक फ़ाइल बनाएं:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

टेस्ट चलाएं:

```bash
v test .
```

## टेस्ट फ़ंक्शन

टेस्ट फंक्शन `test_` से शुरू होते हैं और कोई आर्ग्यूमेंट नहीं लेते:

```v
fn test_something() {
    assert true
}
```

## असर्शन

शर्तों की जांच के लिए `assert` का उपयोग करें:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## अगला

[अध्याय 3: सामान्य अवधारणाएँ](ch03-common-concepts.md)
