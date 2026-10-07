# Bab 1: Memulai

Mari mulai perjalanan V Anda! Ada banyak hal untuk dipelajari, tetapi setiap perjalanan dimulai dengan satu langkah kecil. Dalam bab ini, Anda akan belajar cara:

- Menginstal V di sistem Anda
- Menulis program "Hello, World!"
- Menggunakan kompiler V dan perintahnya
- Membuat proyek V

## Instalasi

V dapat diinstal di Windows, macOS, dan Linux. Cara termudah adalah menggunakan skrip installer:

### Windows

Unduh dan jalankan installer dari [vlang.io/install](https://vlang.io/install.html), atau gunakan PowerShell:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

Atau gunakan skrip installer:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Dari sumber

Untuk membangun V dari sumber:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Memverifikasi instalasi

Setelah instalasi, verifikasi V berfungsi:

```bash
v version
```

Anda akan melihat output seperti:

```
V 0.5.2
```

## Hello, World!

Sekarang mari tulis program V pertama Anda. Buat file bernama `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Jalankan:

```bash
v run main.v
```

Anda akan melihat:

```
Hello, World!
```

Selamat! Anda telah menulis dan menjalankan program V pertama Anda.

## Hello, V!

Mari lihat contoh yang sedikit lebih menarik:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Jalankan:

```bash
v run main.v
```

Output:

```
Hello, V!
V is a great language.
```

## Kompiler V

Kompiler V dipanggil dengan perintah `v`. Perintah umum:

| Perintah | Deskripsi |
|---------|-------------|
| `v run file.v` | Kompilasi dan jalankan file V |
| `v file.v` | Kompilasi file V menjadi executable |
| `v fmt file.v` | Format file V |
| `v test .` | Jalankan test di direktori saat ini |
| `v doc .` | Buat dokumentasi |
| `v doctor` | Diagnosa instalasi V Anda |

## Ringkasan

Dalam bab ini, Anda telah belajar cara menginstal V, menulis program "Hello, World!", dan menggunakan kompiler V. Di bab berikutnya, kita akan melihat cara mengstruktur proyek V.
