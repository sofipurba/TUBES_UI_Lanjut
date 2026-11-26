# Backlog issue

Sumber 30 issue di GitHub Projects. Semuanya bisa dibuat sekaligus dengan `scripts/create-issues.sh`. Isi lengkap tiap issue (tujuan, ruang lingkup, kriteria penerimaan) ada di script tersebut dan di panduan GitHub Project.

Beban kerja: Sofi 16 issue (bobot 27), Erliza 14 issue (bobot 28), dengan bobot S=1, M=2, L=3.

| # | Judul | PIC | Priority | Size | Sprint | Requirement | Modul |
|---|---|---|---|---|---|---|---|
| 1 | Setup repo, ruleset main & GitHub Project board | Sofi | P0 | S | Sprint 1 | — | PM |
| 2 | Tulis project brief, README project & dokumen requirement | Sofi | P0 | M | Sprint 1 | Semua FR/NFR | PM |
| 3 | Inisialisasi project Vue 3 + Vite + Router + Prettier | Erliza | P0 | S | Sprint 1 | NFR-05 | 0, 1 |
| 4 | Token desain global & tema lampu (main.css, useTheme) | Sofi | P0 | M | Sprint 2 | NFR-02, FR-13 | 2, 4 |
| 5 | Router, PublicLayout, Navbar responsif, Breadcrumb & 404 | Sofi | P0 | M | Sprint 2 | FR-12, NFR-01 | 1 |
| 6 | UI kit dasar: AppButton, AppCard, AppBadge | Sofi | P0 | S | Sprint 2 | NFR-02 | 3 |
| 7 | UI kit status & dialog: AppModal, AppTabs, StateError, StateEmpty | Erliza | P0 | M | Sprint 2 | FR-18, FR-09 | 3, 4 |
| 8 | Service layer API & useRequest | Erliza | P0 | M | Sprint 2 | FR-18, NFR-05 | 6 |
| 9 | MockAPI akun 1: resource members & projects + seed data | Sofi | P0 | S | Sprint 2 | FR-04, FR-05 | 6 |
| 10 | Composable useMembers & useProjects (state terpusat) | Erliza | P0 | M | Sprint 2 | FR-05 | 4, 6 |
| 11 | Lobi: hero Z-pattern + denah kantor (OfficeFloor, DeskStation) | Sofi | P0 | L | Sprint 3 | FR-01, FR-02 | 2, 3, 5 |
| 12 | Arsip proyek: ProjectCard, SearchBar, FilterChips, grid adaptif | Erliza | P0 | L | Sprint 3 | FR-05, FR-06 | 2, 3, 4 |
| 13 | Ruang Tim: MemberIdCard & daftar anggota | Sofi | P1 | M | Sprint 3 | FR-03 | 3 |
| 14 | Meja anggota /tim/:id (GET by id, isi laci, pindah meja) | Sofi | P0 | M | Sprint 3 | FR-04 | 4, 5, 6 |
| 15 | Toggle tampilan map/daftar (dynamic component) & urutkan | Erliza | P1 | S | Sprint 3 | FR-07 | 3 |
| 16 | Detail proyek: dokumen F-pattern, lembar disposisi sticky, galeri modal | Erliza | P0 | L | Sprint 4 | FR-08, FR-09 | 2, 4, 5 |
| 17 | MockAPI akun 2: resource messages + useMessages | Erliza | P0 | S | Sprint 4 | FR-10, FR-17 | 6 |
| 18 | Resepsionis: form kontak, validasi, cegah kehilangan isian, modal sukses | Erliza | P0 | L | Sprint 4 | FR-10, FR-11 | 4, 5, 6 |
| 19 | Ruang server: AdminLayout rail & pane + dashboard ringkasan | Sofi | P1 | M | Sprint 4 | FR-14 | 2, 4 |
| 20 | Admin kelola proyek: tab, tambah (POST), hapus dengan konfirmasi (DELETE) | Erliza | P0 | L | Sprint 4 | FR-15, FR-16 | 4, 6 |
| 21 | Admin kotak masuk: daftar, buka, hapus pesan | Sofi | P2 | S | Sprint 4 | FR-17 | 4, 6 |
| 22 | Deploy ke Vercel/Netlify + environment MockAPI | Sofi | P1 | S | Sprint 4 | — | 6 |
| 23 | Unit test (Vitest) untuk utils, service, dan komponen | Erliza | P0 | M | Sprint 5 | NFR-06 | Testing |
| 24 | Black box test 25 skenario + dokumentasi hasil | Erliza | P0 | M | Sprint 5 | NFR-06 | Testing |
| 25 | Evaluasi heuristik Nielsen (2 evaluator) | Sofi | P0 | M | Sprint 5 | NFR-03 | Testing |
| 26 | Uji SUS 5 responden + rekap skor | Sofi | P1 | M | Sprint 5 | NFR-08 | Testing |
| 27 | Lighthouse + perbaikan aksesibilitas & performa | Erliza | P1 | S | Sprint 5 | NFR-03, NFR-04 | Testing |
| 28 | Perbaikan temuan pengujian | Sofi | P1 | M | Sprint 5 | — | — |
| 29 | Ganti data contoh dengan profil & proyek asli | Sofi | P0 | S | Sprint 5 | — | — |
| 30 | Pitch deck 8 bagian + latihan presentasi silang | Erliza | P0 | M | Sprint 5 | — | Presentasi |
