#!/usr/bin/env bash
# Membuat label, milestone (Sprint 1–5), dan 30 issue backlog Kubikel di GitHub,
# lalu (opsional) memasukkannya ke GitHub Project.
# Prasyarat : GitHub CLI terpasang & login  ->  gh auth login
#             untuk memasukkan ke Project    ->  gh auth refresh -s project
# Jalankan  : dari dalam folder repo  ->  bash scripts/create-issues.sh
set -euo pipefail

# ====== ISI DULU ======
SOFI_GH="username-github-sofi"
ERLIZA_GH="username-github-erliza"
PROJECT_TITLE="Kubikel Board"   # kosongkan ("") jika tidak ingin otomatis masuk ke Project
# ======================

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "Repo: $REPO"

label() { gh label create "$1" --color "$2" --description "$3" --force >/dev/null && echo "label $1"; }
label "P0" "C8443B" "Wajib untuk syarat minimum"
label "P1" "F6D55C" "Penting"
label "P2" "9AA6B5" "Tambahan"
label "size:S" "DCF1E6" "Setengah hari atau kurang"
label "size:M" "9BD1B4" "1–2 hari"
label "size:L" "2E9E6A" "3 hari atau lebih, sebaiknya dipecah"
label "bug" "D73A4A" "Temuan dari pengujian"
for m in PM 0 1 2 3 4 5 6 Testing Presentasi; do label "modul:$m" "5B7C8D" "Penerapan materi $m"; done

milestone() { # judul tanggal-jatuh-tempo deskripsi
  gh api "repos/$REPO/milestones" -f title="$1" -f due_on="$2T16:59:59Z" -f description="$3" >/dev/null 2>&1 \
    && echo "milestone $1" || echo "milestone $1 sudah ada, dilewati"
}
milestone 'Sprint 1' '2026-11-22' 'Minggu 10: Workspace, dokumen fondasi, project Vue siap'
milestone 'Sprint 2' '2026-11-29' 'Minggu 11: Token desain, layout, UI kit, service API, state terpusat'
milestone 'Sprint 3' '2026-12-06' 'Minggu 12: Alur Lobi → Meja anggota → Arsip bisa dijalankan'
milestone 'Sprint 4' '2026-12-13' 'Minggu 13: Detail proyek, kontak, panel admin, deploy'
milestone 'Sprint 5' '2026-12-20' 'Minggu 14: Testing, evaluasi, perbaikan, konten asli, pitch deck'

issue() { # judul pic labels sprint body
  local assignee; [ "$2" = "Sofi" ] && assignee="$SOFI_GH" || assignee="$ERLIZA_GH"
  local args=(--title "$1" --body "$5" --assignee "$assignee" --label "$3" --milestone "$4")
  [ -n "$PROJECT_TITLE" ] && args+=(--project "$PROJECT_TITLE")
  gh issue create "${args[@]}"
}

issue 'Setup repo, ruleset main & GitHub Project board' 'Sofi' 'P0,size:S,modul:PM' 'Sprint 1' '## Tujuan
Menyiapkan tempat kerja bersama agar semua pekerjaan tercatat dan bisa dipantau berdua.

## Requirement terkait
—

## Ruang lingkup
- Undang Erliza sebagai kolaborator repo
- Ruleset `lindungi-main` (wajib PR + 1 approval)
- Project `Kubikel Board`: field Status, Priority, Size, Sprint; view Semua task, Board, Sprint ini; workflows

## Kriteria penerimaan (definition of done)
- [ ] Erliza bisa membuka repo dan project dari akunnya
- [ ] Push langsung ke `main` ditolak / disepakati tidak dilakukan
- [ ] Board menampilkan semua issue dengan kolom Status lengkap
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Tulis project brief, README project & dokumen requirement' 'Sofi' 'P0,size:M,modul:PM' 'Sprint 1' '## Tujuan
Menyepakati arah proyek (goals, user, indikator, scope) sebelum mulai mengerjakan.

## Requirement terkait
Semua FR/NFR

## Ruang lingkup
- README project di GitHub Project
- `README.md` repo
- `docs/01-requirements.md`, `docs/02-milestone-sprint.md`, `docs/03-team.md`

## Kriteria penerimaan (definition of done)
- [ ] README project berisi brief, milestone, tanggung jawab, jadwal koordinasi
- [ ] Requirement ber-ID beserta kriteria penerimaan
- [ ] Erliza sudah membaca dan menyetujui (komentar '\''setuju'\'' di issue)
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Inisialisasi project Vue 3 + Vite + Router + Prettier' 'Erliza' 'P0,size:S,modul:0,modul:1' 'Sprint 1' '## Tujuan
Menyiapkan kerangka aplikasi agar kedua anggota bisa mulai mengerjakan fitur.

## Requirement terkait
NFR-05

## Ruang lingkup
- `npm create vue@latest` (Router: Yes, Prettier: Yes) atau salin `package.json` + `vite.config.js` dari zip
- Alias `@` ke `src/`
- Struktur folder: `components/{app,ui,office,project,member,contact,admin}`, `composables`, `services`, `utils`, `views`, `layouts`

## Kriteria penerimaan (definition of done)
- [ ] `npm install` lalu `npm run dev` berjalan tanpa error
- [ ] Struktur folder sesuai README
- [ ] `.env` masuk `.gitignore`, `.env.example` di-commit
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Token desain global & tema lampu (main.css, useTheme)' 'Sofi' 'P0,size:M,modul:2,modul:4' 'Sprint 2' '## Tujuan
Satu sumber warna, jarak, dan tipografi agar tampilan konsisten; mode gelap sebagai "lampu kantor".

## Requirement terkait
NFR-02, FR-13

## Ruang lingkup
- `src/assets/main.css` (variabel warna, skala tipe, spacing, radius, skeleton, form)
- `src/composables/useTheme.js` (watch → localStorage + `data-theme`)
- `src/components/app/LampSwitch.vue`
- Font Archivo + IBM Plex via @fontsource

## Kriteria penerimaan (definition of done)
- [ ] Tidak ada warna/jarak hardcode di komponen baru
- [ ] Klik lampu mengganti tema dan tetap setelah reload
- [ ] `box-sizing: border-box` global, tidak ada horizontal scroll
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Router, PublicLayout, Navbar responsif, Breadcrumb & 404' 'Sofi' 'P0,size:M,modul:1' 'Sprint 2' '## Tujuan
Pengunjung selalu tahu sedang di mana dan bisa berpindah ruangan dengan mudah.

## Requirement terkait
FR-12, NFR-01

## Ruang lingkup
- `src/router/index.js` (rute publik + admin, `scrollBehavior`, judul tab)
- `src/layouts/PublicLayout.vue` (skip link)
- `AppNavbar.vue` (menu aktif, hamburger, jam)
- `AppBreadcrumb.vue`, `useBreadcrumb.js`, `AppFooter.vue`, `NotFoundView.vue`

## Kriteria penerimaan (definition of done)
- [ ] Menu aktif ditandai garis kuning
- [ ] Menu menjadi hamburger di ≤ 820 px
- [ ] Breadcrumb tampil di semua halaman kecuali lobi
- [ ] URL ngawur menampilkan halaman 404
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'UI kit dasar: AppButton, AppCard, AppBadge' 'Sofi' 'P0,size:S,modul:3' 'Sprint 2' '## Tujuan
Komponen dasar yang dipakai ulang di seluruh halaman agar konsisten.

## Requirement terkait
NFR-02

## Ruang lingkup
- `AppButton.vue` (props variant, size, to, href, loading, disabled, block; dynamic component)
- `AppCard.vue` (slot header/default/footer, tone paper/note/plain)
- `AppBadge.vue` (tone)

## Kriteria penerimaan (definition of done)
- [ ] AppButton bisa menjadi RouterLink, a, atau button
- [ ] Saat `loading` tombol menampilkan spinner dan tidak bisa diklik
- [ ] Unit test AppButton lulus
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'UI kit status & dialog: AppModal, AppTabs, StateError, StateEmpty' 'Erliza' 'P0,size:M,modul:3,modul:4' 'Sprint 2' '## Tujuan
Komponen untuk konfirmasi, tab, dan kondisi error/kosong yang dipakai semua halaman data.

## Requirement terkait
FR-18, FR-09

## Ruang lingkup
- `AppModal.vue` (Teleport, backdrop blur, Esc, klik latar, named slot footer, kembalikan fokus)
- `AppTabs.vue` (v-model, navigasi panah keyboard)
- `StateError.vue` (emit retry)
- `StateEmpty.vue` (slot actions)

## Kriteria penerimaan (definition of done)
- [ ] Modal tertutup dengan Esc / klik latar / tombol
- [ ] Slot footer bisa mengganti tombol bawaan
- [ ] Unit test StateError lulus
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Service layer API & useRequest' 'Erliza' 'P0,size:M,modul:6' 'Sprint 2' '## Tujuan
Memisahkan urusan HTTP dari tampilan; semua request lewat satu pintu.

## Requirement terkait
FR-18, NFR-05

## Ruang lingkup
- `src/services/api.js` (fetch, header JSON, cek `response.ok`, timeout 10 s, pesan galat ramah, 2 base URL)
- `src/composables/useRequest.js`
- `.env.example`

## Kriteria penerimaan (definition of done)
- [ ] Alamat API hanya ada di `.env`
- [ ] 404 / 5xx / offline menjadi pesan berbahasa Indonesia
- [ ] Unit test `api.spec.js` & `useRequest.spec.js` lulus
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'MockAPI akun 1: resource members & projects + seed data' 'Sofi' 'P0,size:S,modul:6' 'Sprint 2' '## Tujuan
Menyediakan REST API sungguhan untuk data anggota dan proyek.

## Requirement terkait
FR-04, FR-05

## Ruang lingkup
- Project MockAPI `kubikel-api`, prefix `/api/v1`
- Resource `members` & `projects` sesuai skema `docs/06-api.md`
- Data awal dari `mock/db.json`

## Kriteria penerimaan (definition of done)
- [ ] `GET /members` dan `GET /projects` mengembalikan data seed di browser
- [ ] URL disimpan di `.env` dan dibagikan ke Erliza (jangan di-commit)
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Composable useMembers & useProjects (state terpusat)' 'Erliza' 'P0,size:M,modul:4,modul:6' 'Sprint 2' '## Tujuan
Satu sumber kebenaran data agar lobi, arsip, dan admin selalu sinkron.

## Requirement terkait
FR-05

## Ruang lingkup
- `useMembers.js` (members, loading, error, loaded, getMemberById)
- `useProjects.js` (featuredProjects, categories, countByMember, projectsOf, createProject, deleteProject)
- `src/utils/filterProjects.js`

## Kriteria penerimaan (definition of done)
- [ ] State dideklarasikan di luar fungsi (singleton)
- [ ] Derived state memakai `computed`
- [ ] Unit test `filterProjects.spec.js` lulus
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Lobi: hero Z-pattern + denah kantor (OfficeFloor, DeskStation)' 'Sofi' 'P0,size:L,modul:2,modul:3,modul:5' 'Sprint 3' '## Tujuan
Pengunjung langsung memilih mau kenalan dengan Sofi atau Erliza lewat denah kantor.

## Requirement terkait
FR-01, FR-02

## Ruang lingkup
- `HomeView.vue` (hero, papan sticky note, proyek pilihan, alur kerja, CTA)
- `OfficeFloor.vue` (lemari arsip, papan tulis, rak server, pintu resepsionis)
- `DeskStation.vue` (props member & projectCount, emit select)

## Kriteria penerimaan (definition of done)
- [ ] Judul + 2 tombol terlihat di atas fold pada 1366×768
- [ ] Klik / Enter pada meja membuka `/tim/:id`
- [ ] Denah tersusun ulang di ≤ 720 px
- [ ] Loading skeleton & error + Coba lagi tampil
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Arsip proyek: ProjectCard, SearchBar, FilterChips, grid adaptif' 'Erliza' 'P0,size:L,modul:2,modul:3,modul:4' 'Sprint 3' '## Tujuan
Pengunjung bisa menemukan proyek yang relevan dengan cepat.

## Requirement terkait
FR-05, FR-06

## Ruang lingkup
- `ProjectsView.vue`
- `ProjectCard.vue`, `ProjectCover.vue`, `ProjectGrid.vue`, `ProjectCardSkeleton.vue`
- `SearchBar.vue` (v-model)
- `FilterChips.vue` (dipakai untuk pemilik & kategori)

## Kriteria penerimaan (definition of done)
- [ ] Pencarian tidak peka huruf besar/kecil
- [ ] Filter pemilik + kategori bisa dikombinasikan
- [ ] Teks "Menampilkan X dari Y proyek" + tombol hapus filter
- [ ] Empty state saat tidak ada hasil
- [ ] `?anggota=2` di URL mengisi filter pemilik
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Ruang Tim: MemberIdCard & daftar anggota' 'Sofi' 'P1,size:M,modul:3' 'Sprint 3' '## Tujuan
Menampilkan semua anggota dalam bentuk kartu ID karyawan.

## Requirement terkait
FR-03

## Ruang lingkup
- `TeamView.vue`
- `MemberIdCard.vue` (lanyard, foto inisial, peran, fokus, jumlah proyek)

## Kriteria penerimaan (definition of done)
- [ ] Kartu ID tiap anggota tampil dari API
- [ ] Tombol "Masuk ke meja" membuka `/tim/:id`
- [ ] Responsif 1 kolom di ≤ 760 px
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Meja anggota /tim/:id (GET by id, isi laci, pindah meja)' 'Sofi' 'P0,size:M,modul:4,modul:5,modul:6' 'Sprint 3' '## Tujuan
Pengunjung melihat profil lengkap satu anggota beserta proyeknya.

## Requirement terkait
FR-04

## Ruang lingkup
- `MemberView.vue` (memakai `useRequest(api.getMember)`)
- Kartu ID sticky di kiri, bio, kutipan, keahlian, proyek milik anggota
- Tombol pindah ke meja anggota lain, tautan ke arsip terfilter

## Kriteria penerimaan (definition of done)
- [ ] `/tim/99` menampilkan "Meja ini kosong"
- [ ] Breadcrumb menampilkan "Meja <nama>"
- [ ] Pindah meja tidak me-reload halaman
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Toggle tampilan map/daftar (dynamic component) & urutkan' 'Erliza' 'P1,size:S,modul:3' 'Sprint 3' '## Tujuan
Memberi pengunjung pilihan cara melihat arsip.

## Requirement terkait
FR-07

## Ruang lingkup
- `ViewToggle.vue`
- `ProjectRow.vue`, `ProjectList.vue`
- `<component :is>` di `ProjectsView.vue`, dropdown urutkan (terbaru, terlama, judul)

## Kriteria penerimaan (definition of done)
- [ ] Ganti tampilan tanpa memuat ulang data
- [ ] Urutan berubah sesuai pilihan
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Detail proyek: dokumen F-pattern, lembar disposisi sticky, galeri modal' 'Erliza' 'P0,size:L,modul:2,modul:4,modul:5' 'Sprint 4' '## Tujuan
Pengunjung membaca cerita lengkap satu proyek seperti membaca dokumen kantor.

## Requirement terkait
FR-08, FR-09

## Ruang lingkup
- `ProjectDetailView.vue` (`useRequest(api.getProject)`)
- Kolom kiri 2fr: latar belakang, tujuan, fitur, kontribusi, hasil, pembelajaran, galeri
- Kolom kanan 1fr sticky: pemilik, kategori, tahun, konteks, teknologi, tautan
- Navigasi proyek sebelumnya/berikutnya

## Kriteria penerimaan (definition of done)
- [ ] `/proyek/999` menampilkan "Dokumen tidak ditemukan"
- [ ] Klik galeri membuka modal
- [ ] Breadcrumb memakai judul proyek
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'MockAPI akun 2: resource messages + useMessages' 'Erliza' 'P0,size:S,modul:6' 'Sprint 4' '## Tujuan
Menyediakan tempat menyimpan pesan dari form kontak.

## Requirement terkait
FR-10, FR-17

## Ruang lingkup
- Project MockAPI di akun kedua, resource `messages`
- `VITE_MESSAGES_API_URL` di `.env`
- `src/composables/useMessages.js`, `src/utils/format.js` (nomor surat)

## Kriteria penerimaan (definition of done)
- [ ] POST dan GET `/messages` berjalan dari web
- [ ] Nomor surat berformat `KBK/2026/xxxx`
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Resepsionis: form kontak, validasi, cegah kehilangan isian, modal sukses' 'Erliza' 'P0,size:L,modul:4,modul:5,modul:6' 'Sprint 4' '## Tujuan
Pengunjung bisa menghubungi tim dengan form yang ramah dan aman dari salah isi.

## Requirement terkait
FR-10, FR-11

## Ruang lingkup
- `ContactView.vue`, `ContactForm.vue`, `ContactReceipt.vue`
- `src/utils/validation.js` (`validateContact`)
- Konfirmasi buang isian (isFormDirty) dengan AppModal

## Kriteria penerimaan (definition of done)
- [ ] Galat per kolom + fokus ke kolom pertama yang salah
- [ ] Isian benar tidak hilang saat ada galat / server gagal
- [ ] Tombol "Mengirim pesan…" + spinner
- [ ] Modal sukses berisi nomor surat
- [ ] Unit test validasi & ContactForm lulus
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Ruang server: AdminLayout rail & pane + dashboard ringkasan' 'Sofi' 'P1,size:M,modul:2,modul:4' 'Sprint 4' '## Tujuan
Tim bisa memantau isi portofolio dari satu layar.

## Requirement terkait
FR-14

## Ruang lingkup
- `AdminLayout.vue` (rail kiri diam, pane kanan bergulir)
- `AdminDashboardView.vue` (metrik computed, grafik proyek per anggota, tabel terbaru)

## Kriteria penerimaan (definition of done)
- [ ] Metrik berubah otomatis setelah tambah/hapus proyek
- [ ] Rail menjadi baris atas di ≤ 760 px
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Admin kelola proyek: tab, tambah (POST), hapus dengan konfirmasi (DELETE)' 'Erliza' 'P0,size:L,modul:4,modul:6' 'Sprint 4' '## Tujuan
Konten portofolio bisa diubah tanpa menyentuh kode (syarat template).

## Requirement terkait
FR-15, FR-16

## Ruang lingkup
- `AdminProjectsView.vue` (AppTabs: Daftar / Tambah)
- `ProjectForm.vue` (`validateProject`)
- Modal konfirmasi hapus + notifikasi hijau/merah

## Kriteria penerimaan (definition of done)
- [ ] Proyek baru langsung muncul di arsip publik
- [ ] Hapus hanya terjadi setelah konfirmasi; tombol menampilkan loading
- [ ] Form kosong menampilkan galat
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Admin kotak masuk: daftar, buka, hapus pesan' 'Sofi' 'P2,size:S,modul:4,modul:6' 'Sprint 4' '## Tujuan
Tim bisa membaca pesan dari pengunjung.

## Requirement terkait
FR-17

## Ruang lingkup
- `AdminInboxView.vue`

## Kriteria penerimaan (definition of done)
- [ ] Pesan terbaru di atas
- [ ] Pesan bisa dibuka-tutup, dibalas lewat email, dihapus dengan konfirmasi
- [ ] Empty state saat kosong
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Deploy ke Vercel/Netlify + environment MockAPI' 'Sofi' 'P1,size:S,modul:6' 'Sprint 4' '## Tujuan
Web bisa diakses dosen dan pengunjung lewat link publik.

## Requirement terkait
—

## Ruang lingkup
- Hubungkan repo ke Vercel (atau Netlify)
- Isi Environment Variables `VITE_API_URL` & `VITE_MESSAGES_API_URL`
- `vercel.json` / `public/_redirects` untuk SPA

## Kriteria penerimaan (definition of done)
- [ ] Link publik bisa dibuka
- [ ] Refresh di `/proyek/1` tidak 404
- [ ] Link ditulis di README repo & README project
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Unit test (Vitest) untuk utils, service, dan komponen' 'Erliza' 'P0,size:M,modul:Testing' 'Sprint 5' '## Tujuan
Memastikan logika penting tidak rusak setiap ada perubahan.

## Requirement terkait
NFR-06

## Ruang lingkup
- `tests/unit/*.spec.js` (filter, validasi, api, useRequest, komponen)
- Tambah test untuk komponen baru bila ada

## Kriteria penerimaan (definition of done)
- [ ] Minimal 25 test, semuanya lulus
- [ ] Screenshot hasil `npm run test:run` di `docs/07-testing.md`
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Black box test 25 skenario + dokumentasi hasil' 'Erliza' 'P0,size:M,modul:Testing' 'Sprint 5' '## Tujuan
Menguji setiap requirement dari sudut pandang pengguna.

## Requirement terkait
NFR-06

## Ruang lingkup
- Tabel BB-01 s.d. BB-25 di `docs/07-testing.md`
- Uji di 1366×768 dan 390×844, termasuk Slow 4G & Offline

## Kriteria penerimaan (definition of done)
- [ ] Kolom hasil aktual & status terisi semua
- [ ] Setiap skenario gagal dibuatkan issue bug
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Evaluasi heuristik Nielsen (2 evaluator)' 'Sofi' 'P0,size:M,modul:Testing' 'Sprint 5' '## Tujuan
Mengaudit desain interaksi terhadap 10 heuristik sebelum diuji ke pengguna.

## Requirement terkait
NFR-03

## Ruang lingkup
- Sofi & Erliza menilai terpisah, lalu digabung di `docs/07-testing.md`

## Kriteria penerimaan (definition of done)
- [ ] Temuan + severity (0–4) per heuristik
- [ ] Setiap temuan severity ≥ 2 punya rencana perbaikan
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Uji SUS 5 responden + rekap skor' 'Sofi' 'P1,size:M,modul:Testing' 'Sprint 5' '## Tujuan
Mengukur kemudahan penggunaan dan kesan tema kantor dari pengguna nyata.

## Requirement terkait
NFR-08

## Ruang lingkup
- Google Form berisi 10 butir SUS + 2 butir tema
- 3 skenario tugas sebelum mengisi kuesioner

## Kriteria penerimaan (definition of done)
- [ ] Skor SUS per responden + rata-rata terhitung
- [ ] Catatan temuan dari responden
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Lighthouse + perbaikan aksesibilitas & performa' 'Erliza' 'P1,size:S,modul:Testing' 'Sprint 5' '## Tujuan
Memastikan web cepat dan bisa diakses semua orang.

## Requirement terkait
NFR-03, NFR-04

## Ruang lingkup
- Lighthouse di Lobi, Arsip, Detail (desktop & mobile) pada URL deploy

## Kriteria penerimaan (definition of done)
- [ ] Accessibility ≥ 90, Performance ≥ 85 (desktop)
- [ ] Skor dicatat di `docs/07-testing.md`
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'
issue 'Perbaikan temuan pengujian' 'Sofi' 'P1,size:M' 'Sprint 5' '## Tujuan
Menindaklanjuti hasil black box, heuristik, SUS, dan Lighthouse.

## Requirement terkait
—

## Ruang lingkup
- Satu issue bug per temuan, ditautkan ke issue ini

## Kriteria penerimaan (definition of done)
- [ ] Semua temuan severity ≥ 2 sudah diperbaiki atau diberi alasan
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Ganti data contoh dengan profil & proyek asli' 'Sofi' 'P0,size:S' 'Sprint 5' '## Tujuan
Portofolio menampilkan karya asli tiap anggota.

## Requirement terkait
—

## Ruang lingkup
- Data `members` (nama lengkap, foto/inisial, bio, keahlian, kontak)
- Minimal 1 proyek asli per anggota, sisanya boleh contoh
- Hapus `isDummy` pada data asli

## Kriteria penerimaan (definition of done)
- [ ] Tidak ada lagi badge "Contoh" di proyek asli
- [ ] Tautan demo/repo terisi jika ada
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Sofi'
issue 'Pitch deck 8 bagian + latihan presentasi silang' 'Erliza' 'P0,size:M,modul:Presentasi' 'Sprint 5' '## Tujuan
Menyiapkan presentasi minggu 15 sesuai struktur panduan.

## Requirement terkait
—

## Ruang lingkup
- 8 bagian: overview & tim, masalah & solusi, desain & prinsip, arsitektur komponen, user flow & state, API, testing, tim & manajemen
- Tabel kontribusi

## Kriteria penerimaan (definition of done)
- [ ] Deck selesai
- [ ] Sofi bisa menjelaskan bagian Erliza dan sebaliknya (latihan tanya jawab silang)
- [ ] PR di-review dan di-approve anggota lain

**PIC:** Erliza'

echo "Selesai. Isi field Priority, Size, dan Sprint di board sesuai tabel di panduan."
