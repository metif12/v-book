# अध्याय 1: शुरुआत करना

आइए अपनी V यात्रा शुरू करें! सीखने के लिए बहुत कुछ है, लेकिन हर यात्रा एक छोटे कदम से शुरू होती है। इस अध्याय में, आप सीखेंगे कि कैसे:

- अपने सिस्टम पर V इंस्टॉल करें
- एक "Hello, World!" प्रोग्राम लिखें
- V कंपाइलर और उसके कमांड का उपयोग करें
- एक V प्रोजेक्ट बनाएं

## इंस्टॉलेशन

V को Windows, macOS, और Linux पर इंस्टॉल किया जा सकता है। सबसे आसान तरीका इंस्टॉलर स्क्रिप्ट का उपयोग करना है:

### Windows

[vlang.io/install](https://vlang.io/install.html) से इंस्टॉलर डाउनलोड करें और चलाएं, या PowerShell का उपयोग करें:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

या इंस्टॉलर स्क्रिप्ट का उपयोग करें:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### सोर्स से

V को सोर्स से बिल्ड करने के लिए:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## इंस्टॉलेशन सत्यापित करना

इंस्टॉलेशन के बाद, V के काम करने की पुष्टि करें:

```bash
v version
```

आपको ऐसा आउटपुट दिखना चाहिए:

```
V 0.5.2
```

## Hello, World!

अब आइए अपना पहला V प्रोग्राम लिखें। `main.v` नामक एक फ़ाइल बनाएं:

```v
fn main() {
    println('Hello, World!')
}
```

इसे चलाएं:

```bash
v run main.v
```

आपको यह दिखना चाहिए:

```
Hello, World!
```

बधाई हो! आपने अपना पहला V प्रोग्राम लिखा और चलाया।

## Hello, V!

आइए एक थोड़ा अधिक रोचक उदाहरण देखें:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

इसे चलाएं:

```bash
v run main.v
```

आउटपुट:

```
Hello, V!
V is a great language.
```

## V कंपाइलर

V कंपाइलर `v` कमांड से चलाया जाता है। सामान्य कमांड:

| कमांड | विवरण |
|---------|-------------|
| `v run file.v` | V फ़ाइल को कंपाइल और चलाएं |
| `v file.v` | V फ़ाइल को एक्सीक्यूटेबल में कंपाइल करें |
| `v fmt file.v` | V फ़ाइल को फॉर्मेट करें |
| `v test .` | वर्तमान डायरेक्टरी में टेस्ट चलाएं |
| `v doc .` | डॉक्यूमेंटेशन जेनरेट करें |
| `v doctor` | अपने V इंस्टॉलेशन का निदान करें |

## सारांश

इस अध्याय में, आपने सीखा कि V कैसे इंस्टॉल करें, "Hello, World!" प्रोग्राम कैसे लिखें, और V कंपाइलर का उपयोग कैसे करें। अगले अध्याय में, हम देखेंगे कि V प्रोजेक्ट को कैसे संरचित किया जाता है।
