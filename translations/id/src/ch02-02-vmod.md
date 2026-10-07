# v.mod

File `v.mod` mendeskripsikan proyek Anda:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Field

| Field | Deskripsi |
|-------|-------------|
| `name` | Nama proyek (harus sama dengan nama direktori) |
| `description` | Deskripsi singkat |
| `version` | Versi semantik |
| `license` | Identifikasi lisensi |
| `dependencies` | Daftar nama paket VPM |

## Berikutnya

[Memformat dengan v fmt](ch02-03-formatting.md)
