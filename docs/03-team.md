# 03 · Tim, tanggung jawab, dan status update

## Pembagian tanggung jawab

Pembagian dibuat **per alur fitur (vertical slice)**, bukan "satu desain, satu koding". Dengan begitu kedua anggota sama-sama mengerjakan desain, komponen, state, API, dan testing, dan masing-masing bisa menjelaskan semua materi modul saat presentasi.

| Area | Sofi | Erliza |
|---|---|---|
| Peran tambahan | Penjaga konsistensi desain & arah produk; pemilik repo & board; fasilitator meeting sprint | Penjaga kualitas (QA) & integrasi API; reviewer utama |
| Modul 1: struktur & navigasi | Router, PublicLayout, Navbar, Breadcrumb, 404 | `scrollBehavior`, navigasi programatik di arsip/detail |
| Modul 2: layout & hierarki | Token desain `main.css`, lobi (Z-pattern, the fold), AdminLayout (rail & pane) | Grid adaptif arsip, detail proyek (F-pattern, asimetris 2fr/1fr, sticky pane) |
| Modul 3: komponen | AppButton, AppCard, AppBadge, DeskStation, OfficeFloor, MemberIdCard | ProjectCard/Row/Cover, SearchBar, FilterChips, ViewToggle (dynamic component), AppModal, State* |
| Modul 4: state | `useTheme` (watch → localStorage), dashboard admin (computed), kotak masuk | Composable terpusat, filter (computed), tabs admin, modal konfirmasi hapus |
| Modul 5: user flow | Alur lobi → meja anggota → detail | Alur kontak: validasi, cegah kehilangan isian, modal sukses |
| Modul 6: API | MockAPI akun 1 (resource `members` & `projects`), deploy Vercel | MockAPI akun 2 (resource `messages`), `services/api.js`, `useRequest`, `useMembers`, `useProjects`, `useMessages` |
| Testing | Evaluasi heuristik Nielsen, SUS, uji responsif | Unit test (Vitest), black box test, Lighthouse |
| Presentasi | Bagian 1, 3, 5, 8 deck | Bagian 2, 4, 6, 7 deck |

Kedua anggota wajib bisa menjawab pertanyaan tentang bagian anggota lain, karena dosen bisa menunjuk siapa saja. Setiap review PR dipakai juga sebagai sesi belajar.

## Alur kerja Git

1. Ambil issue di board, set **Assignee**, lalu pindahkan ke **In Progress**.
2. Buat branch dari `main`: `feat/<no-issue>-<nama-singkat>`, contoh `feat/12-search-filter`.
3. Commit kecil dan sering dengan pesan jelas, contoh `feat(arsip): tambah filter kategori (#12)`.
4. Push, buka Pull Request memakai template, tulis `Closes #12`, minta review anggota lain, lalu pindahkan issue ke **In Review**.
5. Reviewer mengecek kriteria penerimaan dan menjalankan `npm run test:run`, lalu approve dan merge. Issue otomatis pindah ke **Done**.
6. Jangan push langsung ke `main` (aktifkan *branch protection*: wajib PR + 1 approval).

## Status board

`Backlog` → `To Do (sprint ini)` → `In Progress` → `In Review` → `Done` (+ `Blocked` bila tertahan).

Atribut wajib per issue: **Assignee (PIC), Priority (P0/P1/P2), Size (S/M/L), Iteration (sprint), Status, Milestone**, dan tautan ke ID requirement.

## Template status update mingguan (ditulis di GitHub Project → Status update)

```
Tanggal     : 
Sprint      : 
Kontributor : Sofi, Erliza

Progress (selesai):
- Sofi   : 
- Erliza : 

Plan (berikutnya):
- Sofi   : 
- Erliza : 

Problem (hambatan):
- 

Decision (keputusan diskusi):
- 

Target penyelesaian: 
```

## Tabel kontribusi (diisi di akhir, untuk presentasi)

| Pekerjaan | Sofi | Erliza | Bukti |
|---|---|---|---|
| Project brief & requirement | | | README, docs/01 |
| Desain & token visual | | | PR # |
| Komponen | | | PR # |
| State management | | | PR # |
| Integrasi API | | | PR # |
| Unit & black box test | | | docs/07, PR # |
| Evaluasi heuristik & SUS | | | docs/07 |
| Pitch deck | | | link |
| **Jumlah commit / PR / issue selesai** | | | GitHub Insights |
