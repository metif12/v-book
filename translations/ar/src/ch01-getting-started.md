# الفصل 1: البداية

لنبدأ رحلتك مع V! هناك الكثير لتعلمه، لكن كل رحلة تبدأ بخطوة صغيرة. في هذا الفصل، ستتعلم كيف:

- تثبّت V على نظامك
- تكتب برنامج "مرحباً، عالم!"
- تستخدم مُصرِّف V وأوامره
- تنشئ مشروع V

## التثبيت

يمكن تثبيت V على Windows و macOS و Linux. أسهل طريقة هي استخدام سكربت التثبيت:

### Windows

حمّل وشغّل المُثبِّت من [vlang.io/install](https://vlang.io/install.html)، أو استخدم PowerShell:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

أو استخدم سكربت التثبيت:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### من المصدر

لبناء V من المصدر:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## التحقق من التثبيت

بعد التثبيت، تحقق من أن V يعمل:

```bash
v version
```

يجب أن ترى ناتجاً مثل:

```
V 0.5.2
```

## مرحباً، عالم!

الآن لنكتب أول برنامج V. أنشئ ملفاً باسم `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

شغّله:

```bash
v run main.v
```

يجب أن ترى:

```
Hello, World!
```

تهانينا! لقد كتبت وشغّلت أول برنامج V لك.

## مرحباً، V!

لننظر إلى مثال أكثر إثارة للاهتمام:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

شغّله:

```bash
v run main.v
```

الناتج:

```
Hello, V!
V is a great language.
```

## مُصرِّف V

يُستدعى مُصرِّف V بالأمر `v`. الأوامر الشائعة:

| الأمر | الوصف |
|---------|-------------|
| `v run file.v` | يُصرّف ويُشغّل ملف V |
| `v file.v` | يُصرّف ملف V إلى ملف تنفيذي |
| `v fmt file.v` | يُنسّق ملف V |
| `v test .` | يُشغّل الاختبارات في المجلد الحالي |
| `v doc .` | يُولّد التوثيق |
| `v doctor` | يشخّص تثبيت V لديك |

## الملخص

في هذا الفصل، تعلمت كيف تثبّت V، وتكتب برنامج "مرحباً، عالم!"، وتستخدم مُصرِّف V. في الفصل التالي، سننظر في كيفية بناء مشروع V.
