# 01 · Requirement

Requirement disusun **setelah** goals, milestone, dan pembagian tanggung jawab disepakati, sesuai arahan pertemuan 9. Setiap requirement punya ID agar bisa ditelusuri dari issue → PR → test case.

PIC = penanggung jawab utama. Anggota lain tetap me-review.

## Requirement fungsional (FR)

| ID | Kebutuhan | Kriteria penerimaan (definition of done) | PIC | Modul |
|---|---|---|---|---|
| FR-01 | Pengunjung melihat identitas tim di lobi | Lobi menampilkan nama tim, tagline, deskripsi singkat, dan dua tombol aksi (arsip proyek, kontak) di atas *fold* pada layar 1366×768. | Sofi | 1, 2 |
| FR-02 | Pengunjung memilih anggota yang ingin dikenal lebih dulu | Denah kantor menampilkan satu meja per anggota beserta nama dan jumlah proyek. Klik atau Enter pada meja membuka `/tim/:id`. Meja punya label yang bisa dibaca screen reader. | Sofi | 3, 5 |
| FR-03 | Pengunjung melihat profil semua anggota | `/tim` menampilkan kartu ID tiap anggota berisi nama, peran, fokus, keahlian, bio, dan tombol masuk ke meja. | Sofi | 3 |
| FR-04 | Pengunjung melihat profil dan proyek satu anggota | `/tim/:id` memuat data anggota lewat `GET /members/:id`, menampilkan proyek miliknya, tautan kontak, dan tombol pindah ke meja anggota lain. ID tidak dikenal menampilkan pesan "Meja ini kosong". | Sofi | 4, 6 |
| FR-05 | Pengunjung melihat semua proyek | `/proyek` menampilkan semua proyek dari `GET /projects` dalam bentuk kartu map: judul, ringkasan, kategori, teknologi, pemilik, dan tahun. | Erliza | 3, 6 |
| FR-06 | Pengunjung mencari dan menyaring proyek | Pencarian tidak peka huruf besar/kecil (judul, ringkasan, kategori, teknologi). Filter pemilik dan kategori bisa dikombinasikan. Jumlah hasil selalu tampil. Ada tombol hapus filter. Hasil kosong menampilkan empty state. | Erliza | 3, 4 |
| FR-07 | Pengunjung mengganti tampilan arsip | Tombol tampilan map/daftar mengganti komponen dengan `<component :is>` tanpa memuat ulang data. | Erliza | 3 |
| FR-08 | Pengunjung membaca detail proyek | `/proyek/:id` memuat data lewat `GET /projects/:id` dan menampilkan latar belakang, tujuan, fitur, kontribusi anggota, hasil, pembelajaran, dokumentasi visual, serta lembar disposisi (pemilik, kategori, tahun, teknologi, tautan). Ada navigasi ke proyek sebelumnya/berikutnya dan kembali ke arsip. | Erliza | 2, 5 |
| FR-09 | Pengunjung melihat pratinjau dokumentasi visual | Klik gambar galeri membuka modal. Modal bisa ditutup dengan tombol, klik latar, atau tombol Esc. | Erliza | 4 |
| FR-10 | Pengunjung mengirim pesan ke tim | Form berisi nama, email, keperluan, dan pesan, dengan validasi per kolom dan pesan galat spesifik. Isian yang benar tidak hilang saat ada galat. Kirim memakai `POST /messages` dengan tombol loading. Sukses menampilkan modal berisi nomor surat. Gagal menampilkan pesan dan isian tetap ada. | Erliza | 4, 5, 6 |
| FR-11 | Pencegahan kehilangan isian | Menekan Batal saat form sudah terisi memunculkan dialog konfirmasi. Form yang masih kosong langsung kembali ke lobi. | Erliza | 5 |
| FR-12 | Pengunjung tahu sedang berada di mana | Navbar menandai menu aktif. Breadcrumb tampil di semua halaman selain lobi dan memakai nama data, mis. judul proyek. Judul tab browser berubah per halaman. | Sofi | 1 |
| FR-13 | Pengunjung bisa "mematikan lampu" | Tombol lampu mengganti tema terang/gelap. Pilihan disimpan di localStorage lewat `watch` dan tetap berlaku setelah halaman dimuat ulang. | Sofi | 4 |
| FR-14 | Admin melihat ringkasan konten | `/admin` menampilkan metrik turunan (total proyek, kategori, pesan, data contoh), grafik proyek per anggota, dan tabel proyek terbaru. | Sofi | 2, 4 |
| FR-15 | Admin menambah proyek | Tab "Tambah proyek" berisi form yang divalidasi lalu dikirim ke `POST /projects`. Sukses: kembali ke tab daftar dengan notifikasi hijau, dan proyek langsung muncul di arsip publik. | Erliza | 4, 6 |
| FR-16 | Admin menghapus proyek | Tombol Hapus membuka modal konfirmasi lalu menjalankan `DELETE /projects/:id`. Tombol menampilkan loading, dan proyek hilang dari state setelah server mengonfirmasi. | Erliza | 4, 6 |
| FR-17 | Admin membaca dan menghapus pesan masuk | `/admin/pesan` menampilkan pesan terbaru di atas. Pesan bisa dibuka-tutup, dibalas lewat email, dan dihapus dengan konfirmasi. | Sofi | 4, 6 |
| FR-18 | Semua data dari API menangani 4 kondisi | Setiap halaman yang memuat data punya loading (skeleton), error (pesan + tombol Coba lagi), empty, dan success. | Bersama | 6 |

## Requirement non-fungsional (NFR)

| ID | Kebutuhan | Kriteria penerimaan | PIC |
|---|---|---|---|
| NFR-01 | Responsif | Tidak ada horizontal scroll pada lebar 360, 390, 768, 1024, dan 1366 px. Menu berubah menjadi hamburger di ≤820 px. Denah berubah susunan di ≤720 px. | Sofi |
| NFR-02 | Konsisten | Warna, jarak, radius, dan tipografi hanya diambil dari token di `main.css`. Tombol, kartu, modal, dan badge selalu memakai komponen `ui/`. | Sofi |
| NFR-03 | Aksesibel | Semua aksi bisa dijalankan dengan keyboard dan fokus terlihat. Ada skip link, label form, `aria-invalid` pada kolom galat, dan `prefers-reduced-motion` dihormati. Target skor Lighthouse Accessibility ≥ 90. | Erliza |
| NFR-04 | Cepat dimuat | Halaman di-lazy-load per route. Target skor Lighthouse Performance ≥ 85 (desktop). | Erliza |
| NFR-05 | Mudah dirawat | Alamat API hanya ada di `.env` dan `services/api.js`. Logika data ada di composable, tampilan di komponen. | Bersama |
| NFR-06 | Teruji | Seluruh unit test lulus sebelum merge ke `main`. Setiap FR punya minimal satu skenario black box. | Erliza |
| NFR-07 | Bisa dijadikan template | Identitas tim cukup diganti di `src/config/site.js` dan data API, tanpa mengubah komponen. | Sofi |
| NFR-08 | Kesan "kantor IT" | Pengunjung menilai tema kantor menarik dan mudah dijelajahi (pertanyaan tambahan di kuesioner, target rata-rata ≥ 4 dari 5). | Bersama |
