# 04 · User flow

Diagram ditulis dengan Mermaid sehingga langsung tampil di GitHub. Untuk pitch deck, render di <https://mermaid.live> lalu ekspor sebagai PNG/SVG.

## Peta situs

```mermaid
flowchart TD
  L[Lobi /] --> T[Ruang Tim /tim]
  L --> P[Arsip Proyek /proyek]
  L --> K[Resepsionis /kontak]
  L -. denah: klik meja .-> M[Meja Anggota /tim/:id]
  T --> M
  M --> D[Dokumen Proyek /proyek/:id]
  P --> D
  D --> M
  L -. rak server .-> A[Ruang Server /admin]
  A --> A1[Kelola Proyek /admin/proyek]
  A --> A2[Kotak Masuk /admin/pesan]
```

## Alur utama: "kenalan dulu dengan Sofi atau Erliza"

Tujuan pengguna: rekruter ingin tahu kemampuan satu anggota beserta bukti karyanya.

```mermaid
flowchart TD
  S([Buka web]) --> L[Lobi: denah kantor]
  L --> Q{Pilih meja siapa?}
  Q -->|Meja A| MS[Meja Sofi]
  Q -->|Meja B| ME[Meja Erliza]
  MS --> LD{Data anggota?}
  ME --> LD
  LD -->|memuat| SK[Skeleton]
  LD -->|gagal| ER[Pesan galat + Coba lagi] --> LD
  LD -->|404| NF[Meja ini kosong → kembali ke ruang tim]
  LD -->|berhasil| PR[Profil + isi laci proyek]
  PR --> PC{Tertarik proyek?}
  PC -->|ya| DT[Dokumen proyek]
  PC -->|lihat anggota lain| Q
  DT --> NX{Lanjut?}
  NX -->|proyek berikutnya| DT
  NX -->|hubungi| K[Resepsionis]
  NX -->|kembali| PR
  K --> E([Pesan terkirim + nomor surat])
```

## Alur kontak (interaction flow)

| Aksi pengguna | Respons sistem | State yang berubah |
|---|---|---|
| Membuka `/kontak` | Form kosong dengan petunjuk jumlah karakter | `form` (reactive) kosong |
| Klik **Kirim pesan** dengan isian salah | Kolom bermasalah diberi garis merah + pesan spesifik; fokus pindah ke kolom pertama yang salah; isian benar tetap ada | `submitted = true`, `errors` terisi |
| Memperbaiki kolom | Galat kolom itu hilang saat mengetik (validasi langsung setelah percobaan pertama) | `errors[field]` dihapus |
| Klik **Kirim pesan** dengan isian benar | Tombol berubah "Mengirim pesan…" + spinner, tidak bisa diklik ulang | `sending = true` |
| Server gagal | Kotak galat merah muncul; isian tetap; tombol aktif lagi | `serverError`, `sending = false` |
| Server sukses | Modal "Pesan terkirim" berisi nomor surat; form dikosongkan | `sentMessage`, `form` direset |
| Klik **Batal** saat form terisi | Modal "Buang pesan yang sudah ditulis?" | `confirmDiscard = true` |
| Klik **Batal** saat form kosong | Langsung kembali ke lobi | — |

## Alur admin: hapus proyek

```mermaid
flowchart LR
  A[Daftar proyek] --> B[Klik Hapus] --> C{Modal konfirmasi}
  C -->|Batal / Esc / klik latar| A
  C -->|Ya, hapus| D[DELETE /projects/:id, tombol loading]
  D -->|200| E[Hilang dari daftar + notifikasi hijau]
  D -->|gagal| F[Notifikasi merah, data tetap]
```
