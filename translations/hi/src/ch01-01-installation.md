# इंस्टॉलेशन

## Windows

### इंस्टॉलर

[vlang.io/install](https://vlang.io/install.html) से नवीनतम इंस्टॉलर डाउनलोड करें और इसे चलाएं।

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### मैनुअल

1. [GitHub releases](https://github.com/vlang/v/releases) से नवीनतम रिलीज़ डाउनलोड करें।
2. zip फ़ाइल को एक्सट्रैक्ट करें।
3. `v` डायरेक्टरी को अपने PATH में जोड़ें।

## macOS

### Homebrew

```bash
brew install vlang
```

### इंस्टॉलर स्क्रिप्ट

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### इंस्टॉलर स्क्रिप्ट

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## सोर्स से

V को सोर्स से बिल्ड करने के लिए, आपको एक C कंपाइलर (gcc या clang) चाहिए:

```bash
git clone https://github.com/vlang/v
cd v
make
```

Windows पर, `make` के बजाय `win.bat` का उपयोग करें।

## सत्यापन

```bash
v version
```

## अगला

[Hello, World!](ch01-02-hello-world.md)
