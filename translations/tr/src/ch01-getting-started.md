# Bölüm 1: Başlangıç

V yolculuğunuza başlayalım! Öğrenilecek çok şey var ama her yolculuk küçük bir adımla başlar. Bu bölümde şunları öğreneceksiniz:

- Sisteminize V kurma
- "Merhaba, Dünya!" programı yazma
- V derleyicisini ve komutlarını kullanma
- Bir V projesi oluşturma

## Kurulum

V, Windows, macOS ve Linux'a kurulabilir. En kolay yol, kurulum betiğini kullanmaktır:

### Windows

[vlang.io/install](https://vlang.io/install.html) adresinden indirip çalıştırın veya PowerShell kullanın:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

Veya kurulum betiğini kullanın:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Kaynak koddan

V'yi kaynak koddan derlemek için:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Kurulumu doğrulama

Kurulumdan sonra V'nin çalıştığını doğrulayın:

```bash
v version
```

Şöyle bir çıktı görmelisiniz:

```
V 0.5.2
```

## Merhaba, Dünya!

Şimdi ilk V programımızı yazalım. `main.v` adında bir dosya oluşturun:

```v
fn main() {
    println('Hello, World!')
}
```

Çalıştırın:

```bash
v run main.v
```

Şöyle görmelisiniz:

```
Hello, World!
```

Tebrikler! İlk V programınızı yazdınız ve çalıştırdınız.

## Merhaba, V!

Biraz daha ilginç bir örneğe bakalım:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Çalıştırın:

```bash
v run main.v
```

Çıktı:

```
Hello, V!
V is a great language.
```

## V derleyicisi

V derleyicisi `v` komutuyla çağrılır. Yaygın komutlar:

| Komut | Açıklama |
|---------|-------------|
| `v run file.v` | Bir V dosyasını derler ve çalıştırır |
| `v file.v` | Bir V dosyasını çalıştırılabilir dosyaya derler |
| `v fmt file.v` | Bir V dosyasını biçimlendirir |
| `v test .` | Mevcut dizindeki testleri çalıştırır |
| `v doc .` | Dokümantasyon oluşturur |
| `v doctor` | V kurulumunuzu teşhis eder |

## Özet

Bu bölümde V'yi kurmayı, "Merhaba, Dünya!" programı yazmayı ve V derleyicisini kullanmayı öğrendiniz. Sonraki bölümde bir V projesinin nasıl yapılandırılacağına bakacağız.
