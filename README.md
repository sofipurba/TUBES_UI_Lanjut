# Kubikel: Portofolio Tim

> Tugas Besar Pengembangan UI Lanjut 2026
> Anggota: **Sofi** dan **Erliza**

Kubikel adalah website portofolio tim bertema **kantor IT**. Pengunjung masuk lewat lobi, melihat denah kantor, lalu memilih meja anggota yang ingin dikenal lebih dulu. Setiap meja berisi profil dan proyek pemiliknya. Lemari arsip menyimpan semua proyek, resepsionis menerima pesan, dan ruang server menjadi panel admin untuk mengelola konten.

---

## 1. Project brief

| Aspek | Isi |
|---|---|
| **Target pengguna** | Calon pemberi kerja/rekruter, dosen, dan calon kolaborator yang ingin cepat memahami kemampuan setiap anggota beserta bukti karyanya. |
| **Kebutuhan pengguna** | Mengenali siapa anggota tim; melihat proyek yang relevan beserta konteks, kontribusi, dan hasilnya; menghubungi tim dengan mudah. |
| **Goals** | Membantu pengunjung mengenali tim dan menemukan karya yang relevan dalam waktu singkat, dengan pengalaman menjelajah yang menyenangkan dan khas (tema kantor IT). |
| **Indikator keberhasilan** | (1) Setiap anggota punya profil lengkap dan minimal 3 proyek dengan halaman detail. (2) Pengunjung bisa memilih anggota langsung dari lobi dalam 1 klik. (3) Proyek bisa dicari dan disaring berdasarkan anggota dan kategori. (4) Form kontak mengirim data ke API dan memberi nomor bukti. (5) Semua data diambil dari REST API dengan state loading, error, dan empty. (6) Tampilan rapi di desktop (≥1024 px) dan ponsel (≥360 px). (7) Unit test lulus 100% dan skor evaluasi heuristik/SUS terdokumentasi. |
| **Luaran** | Web (SPA Vue 3) yang ter-deploy, repositori GitHub, board GitHub Projects, pitch deck, dan dokumentasi (requirement, user flow, komponen, API, testing, kontribusi). |
| **Platform** | Web responsif untuk desktop dan mobile, di browser modern (Chrome, Edge, Firefox, Safari). |
| **Scope (dikerjakan)** | Lobi, Ruang Tim, Meja Anggota, Arsip Proyek, Detail Proyek, Resepsionis (kontak), Ruang Server (admin: ringkasan, tambah/hapus proyek, kotak masuk), mode lampu (gelap/terang). |
| **Di luar scope** | Login/autentikasi admin, upload gambar ke server, transaksi/pembayaran, multi-bahasa. |

## 2. Stack dan alasan memilihnya

| Pilihan | Alasan |
|---|---|
| **Vue 3 + Vite** (Composition API, `<script setup>`) | Framework yang dipelajari di Modul 0–6, sehingga semua materi bisa diterapkan dan dijelaskan langsung. |
| **Vue Router** | Peta situs dengan nested route, breadcrumb, navigasi programatik, dan `scrollBehavior` (Modul 1 & 5). |
| **Composable singleton** (`useProjects`, `useMembers`, `useMessages`) | Pola single source of truth seperti `useEvents.js` di Modul 4–6, tanpa menambah library baru. |
| **MockAPI** (produksi) / **json-server** (lokal) | Modul 6 memakai MockAPI. json-server dipakai saat pengembangan agar bisa offline dan bisa memperlambat respons (`--delay`) untuk menguji loading state. |
| **Vitest + Vue Test Utils** | Unit test yang terintegrasi dengan Vite. |
| **GitHub Projects** | Satu tempat dengan repo, issue terhubung ke PR, dan tools ini yang didemokan di pertemuan 9. |

## 3. Menjalankan proyek

```bash
npm install
cp .env.example .env      # isi VITE_API_URL
npm run api               # terminal 1: REST API lokal di http://localhost:3001 (json-server)
npm run dev               # terminal 2: web di http://localhost:5173
npm run test:run          # menjalankan unit test
npm run build             # build produksi ke folder dist/
```

Untuk memakai MockAPI, ikuti `docs/06-api.md`, lalu isi `VITE_API_URL` (dan `VITE_MESSAGES_API_URL`) di `.env`.

## 4. Struktur folder

```
src/
├─ config/site.js            identitas tim (nama, tagline, deskripsi, email)
├─ router/index.js           peta situs + scrollBehavior + judul halaman
├─ services/api.js           lapisan REST API (fetch, status HTTP, pesan galat)
├─ composables/              state terpusat & logika (useProjects, useMembers, useMessages,
│                            useRequest, useTheme, useClock, useBreadcrumb)
├─ utils/                    fungsi murni yang diuji: filterProjects, validation, format
├─ layouts/                  PublicLayout (navbar+breadcrumb+footer), AdminLayout (rail & pane)
├─ components/
│  ├─ app/                   AppNavbar, AppBreadcrumb, AppFooter, LampSwitch
│  ├─ ui/                    AppButton, AppCard, AppBadge, AppModal, AppTabs, StateError, StateEmpty
│  ├─ office/                OfficeFloor (denah), DeskStation (meja)
│  ├─ project/               ProjectCard, ProjectRow, ProjectGrid, ProjectList, ProjectCover,
│  │                         SearchBar, FilterChips, ViewToggle, ProjectCardSkeleton
│  ├─ member/                MemberIdCard
│  ├─ contact/               ContactForm, ContactReceipt
│  └─ admin/                 ProjectForm
└─ views/                    Home, Team, Member, Projects, ProjectDetail, Contact, NotFound, admin/*
mock/db.json                 data awal (juga dipakai sebagai seed MockAPI)
tests/unit/                  27 unit test
docs/                        requirement, sprint, tim, user flow, komponen, API, testing
```

## 5. Dokumentasi

- [01 Requirement](docs/01-requirements.md)
- [02 Milestone & sprint](docs/02-milestone-sprint.md)
- [03 Tim, tanggung jawab, koordinasi & status update](docs/03-team.md)
- [04 User flow](docs/04-user-flow.md)
- [05 Arsitektur komponen](docs/05-components.md)
- [06 Integrasi API](docs/06-api.md)
- [07 Testing & evaluasi](docs/07-testing.md)
- [Backlog issue](docs/backlog.md)
- [Deklarasi penggunaan AI](docs/ai-declaration.md)

## 6. Dipakai sebagai template portofolio pribadi

1. Ubah `src/config/site.js` (nama, tagline, deskripsi, email).
2. Di MockAPI, sisakan satu anggota di resource `members` dan isi proyek pribadimu lewat panel **Ruang Server**.
3. Denah otomatis menampilkan satu meja saja, dan semua halaman lain tetap berjalan tanpa mengubah kode.
