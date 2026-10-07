# Bab 19: Tooling

## v fmt

Memformat kode sumber V sesuai dengan style guide resmi. Gunakan `-w` untuk menulis perubahan secara langsung.

```bash
v fmt -w .
```

### Memformat file tunggal

```bash
v fmt -w main.v
```

### Memeriksa format tanpa menulis

```bash
v fmt -check .
```

## v doc

Menghasilkan dokumentasi dari file sumber V. Output HTML secara default.

```bash
v doc .
```

### Mendokumentasikan modul spesifik

```bash
v doc -o docs/ .
```

## v profiler

Memprofil eksekusi program untuk mengidentifikasi bottleneck performa.

```bash
v -profile profile.txt run main.v
```

### Menganalisis output profil

```bash
v profile profile.txt
```

## v test

Menjalankan unit test di direktori saat ini atau file yang ditentukan.

```bash
v test .
```

### Menjalankan test spesifik

```bash
v test -run TestName .
```

### Menjalankan test dengan coverage

```bash
v test -cover .
```

## v check

Melakukan analisis statis pada kode V, memeriksa error, peringatan, dan masalah gaya.

```bash
v check .
```

### Memeriksa file tunggal

```bash
v check main.v
```

## Cross-compilation

V dapat mengompilasi kode untuk sistem operasi dan arsitektur yang berbeda dari satu mesin.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Menentukan arsitektur

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Cross-compile untuk target embedded

```bash
v -os embedded -arch arm main.v
```

## v doctor

Menampilkan informasi diagnostik tentang instalasi V, termasuk versi kompiler, OS, dan konfigurasi.

```bash
v doctor
```

## v up

Memperbarui kompiler V ke versi terbaru.

```bash
v up
```

### Memperbarui ke versi spesifik

```bash
v up --version 0.5.2
```

## Ringkasan

Dalam bab ini, Anda telah belajar tentang ekosistem tooling V: `v fmt` untuk formatting, `v doc` untuk dokumentasi, `v profiler` untuk analisis performa, `v test` untuk testing, `v check` untuk analisis statis, cross-compilation, `v doctor` untuk diagnostik, dan `v up` untuk pembaruan mandiri. Di bab berikutnya, kita akan membangun proyek akhir.
