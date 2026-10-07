# Bölüm 19: Araçlar

## v fmt

V kaynak kodunu resmi stil kılavuzuna göre biçimendirir. Değişiklikleri yerinde yazmak için `-w` kullanın.

```bash
v fmt -w .
```

### Tek dosyayı biçimlendirme

```bash
v fmt -w main.v
```

### Yazmadan biçimlendirmeyi kontrol etme

```bash
v fmt -check .
```

## v doc

V kaynak dosyalarından dokümantasyon oluşturur. Varsayılan olarak HTML çıktı verir.

```bash
v doc .
```

### Belirli bir modülü dokümantasyon

```bash
v doc -o docs/ .
```

## v profiler

Program yürütmesini profiller, performans darboğazlarını belirler.

```bash
v -profile profile.txt run main.v
```

### Profil çıktısını analiz etme

```bash
v profile profile.txt
```

## v test

Mevcut dizinde veya belirtilen dosyada birim testlerini çalıştırır.

```bash
v test .
```

### Belirli bir testi çalıştırma

```bash
v test -run TestName .
```

### Testleri coverage ile çalıştırma

```bash
v test -cover .
```

## v check

V kodunda statik analiz yapar, hataları, uyarıları ve stil sorunlarını kontrol eder.

```bash
v check .
```

### Tek dosyayı kontrol etme

```bash
v check main.v
```

## Cross-derleme

V, tek bir makineden farklı işletim sistemleri ve mimariler için kod derleyebilir.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Mimari belirtme

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Gömülü hedefler için cross-derleme

```bash
v -os embedded -arch arm main.v
```

## v doctor

V kurulumu hakkında teşhis bilgileri gösterir, derleyici sürümü, işletim sistemi ve yapılandırma dahil.

```bash
v doctor
```

## v up

V derleyicisini en son sürüme günceller.

```bash
v up
```

### Belirli bir sürüme güncelleme

```bash
v up --version 0.5.2
```

## Özet

Bu bölümde V'nin araç ekosistemi hakkında bilgi edindiniz: biçimlendirme için `v fmt`, dokümantasyon için `v doc`, performans analizi için `v profiler`, test etme için `v test`, statik analiz için `v check`, cross-derleme, teşhis için `v doctor` ve kendini güncelleme için `v up`. Sonraki bölümde bir final projesi oluşturacağız.
