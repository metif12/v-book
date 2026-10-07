# باب ۱: آغاز

آئیے آپ کا V سفر شروع کرتے ہیں! سیکھنے کے لیے بہت کچھ ہے، لیکن ہر سفر ایک چھوٹے قدم سے شروع ہوتا ہے۔ اس باب میں، آپ سیکھیں گے کہ کیسے:

- اپنے سسٹم پر V انسٹال کریں
- ایک "ہیلو، ورلڈ!" پروگرام لکھیں
- V کمپائلر اور اس کے کمانڈز کو استعمال کریں
- ایک V پروجیکٹ بنائیں

## انسٹالیشن

V کو Windows، macOS،اور Linux پر انسٹال کیا جا سکتا ہے۔ سب سے آسان طریقہ انسٹالر اسکرپٹ کو استعمال کرنا ہے:

### Windows

[vlang.io/install](https://vlang.io/install.html) سے انسٹالر ڈاؤن لوڈ کریں اور چلائیں، یا PowerShell استعمال کریں:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

یا انسٹالر اسکرپٹ استعمال کریں:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### ماخذ سے

ماخذ سے V بنانے کے لیے:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## انسٹالیشن کی تصدیق

انسٹالیشن کے بعد، V کے کام کرنے کی تصدیق کریں:

```bash
v version
```

آپ کو ایسا آؤٹ پٹ نظر آنا چاہیے:

```
V 0.5.2
```

## ہیلو، ورلڈ!

اب ہم اپنا پہلا V پروگرام لکھتے ہیں۔ `main.v` نامی فائل بنائیں:

```v
fn main() {
    println('Hello, World!')
}
```

اسے چلائیں:

```bash
v run main.v
```

آپ کو نظر آنا چاہیے:

```
Hello, World!
```

مبارک ہو! آپ نے اپنا پہلا V پروگرام لکھا اور چلایا۔

## ہیلو، V!

آئیے ایک قدراً دلچسپ مثال دیکھتے ہیں:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

اسے چلائیں:

```bash
v run main.v
```

آؤٹ پٹ:

```
Hello, V!
V is a great language.
```

## V کمپائلر

V کمپائلر `v` کمانڈ سے چلایا جاتا ہے۔ عام کمانڈز:

| کمانڈ | تفصیل |
|---------|-------------|
| `v run file.v` | V فائل کو کمپائل اور چلائیں |
| `v file.v` | V فائل کو ایکزیکٹیبل میں کمپائل کریں |
| `v fmt file.v` | V فائل کو فارمیٹ کریں |
| `v test .` | موجودہ ڈائریکٹری میں ٹیسٹ چلائیں |
| `v doc .` | دستاویزات تیار کریں |
| `v doctor` | اپنی V انسٹالیشن کا تشخیص کریں |

## خلاصہ

اس باب میں، آپ نے سیکھا کہ V کو کیسے انسٹال کریں، "ہیلو، ورلڈ!" پروگرام کیسے لکھیں، اور V کمپائلر کو کیسے استعمال کریں۔ اگلے باب میں، ہم دیکھیں گے کہ V پروجیکٹ کا ڈھانچہ کیسے بنائیں۔
