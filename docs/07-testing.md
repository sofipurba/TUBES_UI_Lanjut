# 07 · Testing & evaluasi

## Strategi

Pengujian dilakukan dari dua sisi, sesuai arahan dosen.

| Sisi | Metode | Alasan memilih | PIC |
|---|---|---|---|
| Kualitas teknis | **Unit test** (Vitest + Vue Test Utils) | Logika filter, validasi, service API, dan komponen reusable dipakai di banyak halaman. Jika rusak, efeknya menyebar, jadi perlu diuji otomatis setiap kali ada PR. | Erliza |
| Kualitas teknis | **Black box / functional test** | Memastikan setiap requirement (FR) berjalan dari sudut pandang pengguna, termasuk kondisi loading/error/empty yang sulit diuji otomatis. | Erliza |
| Kualitas teknis | **Lighthouse** (accessibility & performance) | Portofolio dinilai rekruter dari kesan pertama. Halaman harus cepat dan bisa diakses semua orang (NFR-03, NFR-04). | Erliza |
| Sisi pengguna | **Evaluasi heuristik** (10 heuristik Nielsen) oleh kedua anggota sebagai evaluator | Murah dan cepat, dan bisa dilakukan sebelum ada responden. Hasilnya dipakai untuk perbaikan sebelum uji pengguna. | Sofi |
| Sisi pengguna | **SUS + 2 pertanyaan tema**, 5 responden (mahasiswa SI/dosen/kenalan HR) | SUS adalah kuesioner baku yang skornya bisa dibandingkan. Riset usability Nielsen menunjukkan 5 pengguna sudah menemukan sebagian besar masalah utama. Pertanyaan tema mengukur NFR-08 (kesan kantor IT). | Sofi |

## 1. Unit test

Jalankan `npm run test:run`, lalu screenshot hasilnya untuk laporan.

| ID | File | Skenario | Hasil |
|---|---|---|---|
| UT-01–07 | `filterProjects.spec.js` | Tanpa filter, pencarian case-insensitive, cari teknologi, filter anggota (angka/string), kombinasi filter, hasil kosong, pengurutan tanpa mutasi | Lulus |
| UT-08–13 | `validation.spec.js` | Form valid, semua kosong, email salah, spasi saja (trim), pesan < 20 karakter, tahun proyek di luar rentang | Lulus |
| UT-14–17 | `api.spec.js` | Respons 200, POST mengirim header + body JSON, 404 menjadi ApiError, jaringan putus | Lulus |
| UT-18–19 | `useRequest.spec.js` | Loading true → false + data terisi; error tersimpan saat gagal | Lulus |
| UT-20–27 | `components.spec.js` | AppButton variant & loading, SearchBar v-model, FilterChips aktif + emit, ProjectCard props + emit, StateError retry, ContactForm menolak data salah tanpa menghapus isian, ContactForm mengirim data bersih | Lulus |

**Run awal: 27 dari 27 lulus.** Jalankan ulang setiap sebelum merge dan catat bila ada yang gagal.

## 2. Black box test

Lingkungan: Chrome versi terbaru, desktop 1366×768 dan mobile 390×844 (DevTools device mode).

| ID | Req | Skenario | Langkah | Hasil yang diharapkan | Hasil aktual | Status |
|---|---|---|---|---|---|---|
| BB-01 | FR-01 | Identitas di atas fold | Buka `/` di 1366×768 | Judul, deskripsi, dan 2 tombol terlihat tanpa scroll | | ☐ |
| BB-02 | FR-02 | Pilih meja dengan mouse | Klik meja Sofi | Pindah ke `/tim/1`, breadcrumb "Meja Sofi" | | ☐ |
| BB-03 | FR-02 | Pilih meja dengan keyboard | Tab ke meja Erliza, tekan Enter | Pindah ke `/tim/2` | | ☐ |
| BB-04 | FR-04 | Anggota tidak ada | Buka `/tim/99` | Pesan "Meja ini kosong" + tombol kembali | | ☐ |
| BB-05 | FR-04 | Pindah meja | Di `/tim/1` klik "Meja Erliza" | Data berganti ke Erliza tanpa reload | | ☐ |
| BB-06 | FR-06 | Cari case-insensitive | Ketik `DASHBOARD` | Muncul "Dashboard Penjualan UMKM" | | ☐ |
| BB-07 | FR-06 | Kombinasi filter | Pilih Pemilik: Sofi + Kategori: UI/UX | Hanya proyek UI/UX milik Sofi; teks jumlah hasil sesuai | | ☐ |
| BB-08 | FR-06 | Hasil kosong | Ketik `zzz` | Empty state + tombol "Hapus semua filter" mengembalikan 6 proyek | | ☐ |
| BB-09 | FR-06 | Filter dari URL | Buka `/proyek?anggota=2` | Filter Pemilik otomatis "Erliza" | | ☐ |
| BB-10 | FR-07 | Ganti tampilan | Klik ikon daftar | Kartu berubah menjadi baris tanpa skeleton/muat ulang | | ☐ |
| BB-11 | FR-08 | Detail proyek | Klik kartu "RuangRapat" | Semua bagian dokumen + lembar disposisi tampil | | ☐ |
| BB-12 | FR-08 | Proyek tidak ada | Buka `/proyek/999` | "Dokumen tidak ditemukan di arsip" | | ☐ |
| BB-13 | FR-09 | Modal galeri | Klik gambar galeri lalu tekan Esc | Modal terbuka lalu tertutup, fokus kembali ke gambar | | ☐ |
| BB-14 | FR-10 | Validasi kontak | Isi nama saja, klik Kirim | 3 pesan galat, nama tetap terisi, fokus ke kolom email | | ☐ |
| BB-15 | FR-10 | Kirim sukses | Isi semua dengan benar, klik Kirim | Tombol loading, lalu modal berisi nomor surat; form kosong | | ☐ |
| BB-16 | FR-10 | Kirim saat offline | DevTools Offline, klik Kirim | Pesan galat merah, isian tetap ada | | ☐ |
| BB-17 | FR-11 | Batal saat terisi | Ketik pesan, klik Batal | Muncul dialog konfirmasi | | ☐ |
| BB-18 | FR-12 | Breadcrumb & judul tab | Buka detail proyek | Breadcrumb "Lobi / Arsip Proyek / <judul>"; judul tab "Dokumen Proyek — Kubikel" | | ☐ |
| BB-19 | FR-13 | Lampu tersimpan | Klik lampu, reload halaman | Tema gelap tetap aktif | | ☐ |
| BB-20 | FR-15 | Tambah proyek | Admin → Tambah, isi form, Simpan | Notifikasi hijau; proyek muncul di daftar dan di `/proyek` | | ☐ |
| BB-21 | FR-15 | Validasi admin | Simpan form kosong | Galat di judul, pemilik, kategori, ringkasan | | ☐ |
| BB-22 | FR-16 | Hapus proyek | Klik Hapus → "Ya, hapus proyek" | Tombol loading; proyek hilang; notifikasi hijau | | ☐ |
| BB-23 | FR-18 | Loading state | Network: Slow 4G, buka `/proyek` | Skeleton tampil sebelum data | | ☐ |
| BB-24 | FR-18 | Error + retry | Offline, buka `/proyek`, lalu Online + Coba lagi | Kartu galat, lalu data tampil setelah coba lagi | | ☐ |
| BB-25 | NFR-01 | Responsif | Cek 360, 390, 768, 1024, 1366 px | Tidak ada horizontal scroll; menu hamburger ≤ 820 px | | ☐ |

## 3. Evaluasi heuristik (Nielsen)

Severity: 0 = bukan masalah, 1 = kosmetik, 2 = minor, 3 = mayor, 4 = katastrofik. Kedua anggota menilai terpisah, lalu hasilnya digabung.

| # | Heuristik | Penerapan saat ini | Temuan | Severity | Perbaikan |
|---|---|---|---|---|---|
| 1 | Visibility of system status | Menu aktif, breadcrumb, jumlah hasil filter, skeleton, tombol loading, jam kantor | | | |
| 2 | Match between system and real world | Metafora kantor: meja = anggota, lemari arsip = proyek, resepsionis = kontak, nomor surat = bukti pesan | | | |
| 3 | User control and freedom | Hapus filter, tombol kembali/batal, modal bisa ditutup (Esc/latar), pindah meja | | | |
| 4 | Consistency and standards | Komponen UI tunggal, token desain, label aksi sama di seluruh alur | | | |
| 5 | Error prevention | Konfirmasi hapus & buang isian, validasi sebelum kirim, tombol nonaktif saat loading | | | |
| 6 | Recognition rather than recall | Label di setiap perabot denah, opsi filter terlihat, breadcrumb | | | |
| 7 | Flexibility and efficiency | Filter lewat URL (`?anggota=`), navigasi keyboard di tab, skip link | | | |
| 8 | Aesthetic and minimalist design | Satu fokus visual per halaman (denah / dokumen), informasi sekunder di pane | | | |
| 9 | Help users recognize, diagnose, recover from errors | Pesan galat spesifik + contoh format + tombol Coba lagi | | | |
| 10 | Help and documentation | Sticky note petunjuk di lobi, hint jumlah karakter di form | | | |

## 4. SUS (System Usability Scale)

**Skenario tugas untuk responden** (dikerjakan sebelum mengisi kuesioner):

1. Cari tahu keahlian Erliza.
2. Temukan satu proyek Sofi di kategori UI/UX dan baca hasilnya.
3. Kirim pesan ke tim.

**Pernyataan** (skala 1 = sangat tidak setuju s.d. 5 = sangat setuju):

1. Saya rasa saya akan sering menggunakan website ini.
2. Website ini terasa rumit tanpa alasan.
3. Website ini mudah digunakan.
4. Saya butuh bantuan orang teknis untuk bisa menggunakan website ini.
5. Fitur-fitur di website ini terintegrasi dengan baik.
6. Ada terlalu banyak hal yang tidak konsisten di website ini.
7. Saya rasa kebanyakan orang akan cepat belajar menggunakan website ini.
8. Website ini merepotkan untuk digunakan.
9. Saya merasa percaya diri saat menggunakan website ini.
10. Saya perlu mempelajari banyak hal sebelum bisa menggunakan website ini.

**Tambahan (NFR-08):** (11) Tema kantor IT membuat website ini menarik dijelajahi. (12) Saya mudah menemukan proyek anggota yang saya pilih.

**Perhitungan:** butir ganjil → (skor − 1), butir genap → (5 − skor). Jumlahkan semua, lalu × 2,5 (rentang 0–100). Skor ≥ 68 dianggap di atas rata-rata.

| Responden | Profil | Skor SUS | Q11 | Q12 | Catatan |
|---|---|---|---|---|---|
| R1 | | | | | |
| R2 | | | | | |
| R3 | | | | | |
| R4 | | | | | |
| R5 | | | | | |
| **Rata-rata** | | | | | |

## 5. Lighthouse

Chrome DevTools → Lighthouse → mode Navigation, perangkat Desktop & Mobile, pada URL hasil deploy.

| Halaman | Performance | Accessibility | Best Practices | SEO | Catatan |
|---|---|---|---|---|---|
| Lobi | | | | | |
| Arsip | | | | | |
| Detail proyek | | | | | |
