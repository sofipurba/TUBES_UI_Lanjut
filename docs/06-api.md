# 06 · Integrasi API

## Arsitektur

```
Komponen/halaman → composable (useProjects, useMembers, useMessages, useRequest)
                 → services/api.js (fetch, header JSON, cek response.ok, timeout, pesan galat)
                 → REST API (MockAPI di produksi / json-server di lokal)
```

Alamat server hanya ada di `.env`:

```
VITE_API_URL=https://<kode-akun-1>.mockapi.io/api/v1           # members, projects
VITE_MESSAGES_API_URL=https://<kode-akun-2>.mockapi.io/api/v1  # messages
```

**Kenapa dua akun MockAPI?** Paket gratis MockAPI dibatasi 1 project dan sedikit resource per project; beberapa sumber menyebut 2 resource. Web ini butuh 3 resource, jadi `messages` diletakkan di akun anggota kedua. Ini juga membuktikan service layer kami mendukung lebih dari satu base URL. Jika akun kalian ternyata mengizinkan 3 resource atau lebih, kosongkan `VITE_MESSAGES_API_URL`.

## Endpoint

| Method | Endpoint | Dipakai di | Respons sukses |
|---|---|---|---|
| GET | `/members` | Lobi (denah), Ruang Tim, filter arsip | `200` array anggota |
| GET | `/members/:id` | Meja anggota | `200` objek anggota, `404` bila tidak ada |
| GET | `/projects` | Lobi, arsip, meja anggota, admin | `200` array proyek |
| GET | `/projects/:id` | Detail proyek | `200` objek proyek, `404` bila tidak ada |
| POST | `/projects` | Admin: tambah proyek | `201` objek proyek baru (dengan `id`) |
| DELETE | `/projects/:id` | Admin: hapus proyek | `200` objek yang dihapus |
| GET | `/messages` | Admin: kotak masuk | `200` array pesan |
| POST | `/messages` | Resepsionis: kirim pesan | `201` objek pesan baru |
| DELETE | `/messages/:id` | Admin: hapus pesan | `200` |

### Contoh request–response

```http
POST /messages
Content-Type: application/json

{ "name": "Budi", "email": "budi@mail.com", "topic": "Kolaborasi proyek",
  "message": "Halo, saya tertarik berkolaborasi.", "refNo": "KBK/2026/8189",
  "createdAt": "2026-11-17T13:13:00.000Z" }
```

```json
{ "id": "2", "name": "Budi", "email": "budi@mail.com", "topic": "Kolaborasi proyek",
  "message": "Halo, saya tertarik berkolaborasi.", "refNo": "KBK/2026/8189",
  "createdAt": "2026-11-17T13:13:00.000Z" }
```

## Skema data

**members:** `id, name, fullName, role, desk, bio, skills[], focus, deskItems[], quote, email, github, linkedin, accent, isDummy`

- `deskItems` menentukan benda di meja. Nilai yang dikenali: `kopi`, `teh`, `tanaman`, `buku`, `headphone`, `sticky-note`.
- `accent` adalah warna meja dan sampul proyek (hex).

**projects:** `id, memberId, title, summary, category, tech[], year, context, background, goals[], features[], contribution, learnings[], outcome, gallery[], demoUrl, repoUrl, featured, isDummy`

**messages:** `id, refNo, name, email, topic, message, createdAt`

## Menyiapkan MockAPI (langkah sama seperti Modul 6)

1. **Akun 1 (mis. milik Sofi):** buat project `kubikel-api` dengan prefix `/api/v1`.
2. Buat resource `members` dan `projects`. Di skema, ganti field bawaan Faker dengan field di atas. Field array (`skills`, `tech`, `goals`, …) pakai tipe **Array**, `featured`/`isDummy` tipe **Boolean**, `year` tipe **Number**.
3. Klik **Data** pada tiap resource, lalu tempel array `members` dan `projects` dari `mock/db.json`. Klik **Update**.
4. **Akun 2 (mis. milik Erliza):** buat project, lalu resource `messages`. Data awal boleh `[]` untuk menguji empty state.
5. Salin kedua URL ke `.env` dan ke *Environment Variables* di Vercel/Netlify saat deploy.

## Bukti penanganan kondisi

| Kondisi | Cara memicunya untuk demo | Yang tampil |
|---|---|---|
| Loading | DevTools → Network → **Slow 4G**, atau `npm run api` (sudah ada `--delay 700`) | Skeleton shimmer, teks "Memuat arsip dari server…", tombol dengan spinner |
| Error | DevTools → Network → **Offline**, atau matikan json-server | Kartu merah "Koneksi gagal" + tombol **Coba lagi** |
| Empty | Kosongkan resource / cari kata `zzz` di arsip / kotak masuk kosong | Ilustrasi map kosong + pesan + tombol aksi |
| 404 | Buka `/proyek/999` atau `/tim/99` | "Dokumen tidak ditemukan di arsip" / "Meja ini kosong" |
| Success | Normal | Data tampil |

Untuk bukti di laporan, ambil screenshot tab Network (request, status code, dan response) pada GET, POST, dan DELETE.
