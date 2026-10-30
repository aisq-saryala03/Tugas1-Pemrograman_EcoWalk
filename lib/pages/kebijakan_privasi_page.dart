
import 'package:flutter/material.dart';
import '../utils/konstanta.dart';

class KebijakanPrivasiPage extends StatelessWidget {
  const KebijakanPrivasiPage({super.key});

  // ============================================================
  // 1. HEADER HIJAU
  // ============================================================
  Widget header(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: hijau,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Kebijakan Privasi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 2. KOMPONEN TEKS
  // ============================================================
  Widget teks(
    String isi, {
    double ukuran = 10,
    bool tebal = false,
    bool miring = false,
    double tinggiBaris = 1.8,
    Color warna = Colors.black,
  }) {
    return Text(
      isi,
      style: TextStyle(
        fontSize: ukuran,
        fontWeight: tebal ? FontWeight.w800 : FontWeight.normal,
        fontStyle: miring ? FontStyle.italic : FontStyle.normal,
        height: tinggiBaris,
        color: warna,
      ),
    );
  }

  // ============================================================
  // 3. KOMPONEN POIN KEBIJAKAN
  // ============================================================
  Widget poin(String isi, {double ukuran = 10}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          teks('•', ukuran: ukuran + 2,
          tebal: true,),
          const SizedBox(width: 5),
          Expanded(
            child: teks(isi, ukuran: ukuran),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 4. ISI KEBIJAKAN PRIVASI
  // ============================================================
  Widget isiKebijakan() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO ECOWALK
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 2,
                bottom: 22,
              ),
              child: Image.asset(
                'lib/images/logo_ecowalk_hijau.png',
                width: 75,
                height: 20,
                fit: BoxFit.contain,
                alignment: Alignment.centerRight,
              ),
            ),
          ),

          // JUDUL DOKUMEN
          teks(
            'KEBIJAKAN PRIVASI APLIKASI ECOWALK',
            ukuran: 13,
            tebal: true,
            tinggiBaris: 1.2,
          ),

          const SizedBox(height: 3),

          teks(
            'Diperbaharui tanggal 16 Februari 2024',
            ukuran: 11,
            miring: true,
            warna: Colors.black54,
            tinggiBaris: 1.2,
          ),

          const SizedBox(height: 24),

          // PEMBUKA
          teks(
            'Kami menghargai privasi pengguna. Kebijakan ini '
            'menjelaskan bagaimana ECOWALK mengumpulkan, menggunakan, '
            'dan melindungi data Anda.',
            ukuran: 13,
          ),

          const SizedBox(height: 18),

          // BAGIAN 1
          teks(
            '1. Data yang Kami Kumpulkan',
            ukuran: 13,
          ),

          teks(
            'Kami dapat mengumpulkan data berikut:',
            ukuran: 13,
          ),

          poin(
            'Data Pribadi: Nama, email, dan informasi akun.',
            ukuran: 13,
          ),

          poin(
            'Data Lokasi: Untuk memberikan rekomendasi wisata '
            'dan perhitungan jarak.',
            ukuran: 13,
          ),

          poin(
            'Ulasan dan Foto: Jika Anda memposting ulasan '
            'atau berbagi pengalaman wisata.',
            ukuran: 13,
          ),

          const SizedBox(height: 18),

          // BAGIAN 2
          teks(
            '2. Cara Kami Menggunakan Data',
            ukuran: 13,
          ),

          poin(
            'Memberikan rekomendasi tempat wisata berdasarkan lokasi.',
            ukuran: 13,
          ),

          poin(
            'Memproses pencarian dan filter destinasi sesuai preferensi.',
            ukuran: 13,
          ),

          poin(
            'Menampilkan ulasan dan foto yang dibagikan pengguna lain.',
            ukuran: 13,
          ),

          poin(
            'Menyediakan informasi transportasi berdasarkan data lokasi.',
            ukuran: 13,
          ),

          const SizedBox(height: 18),

          // BAGIAN 3
          teks(
            '3. Keamanan Data',
            ukuran: 13,
          ),

          teks(
            'Kami menggunakan enkripsi dan metode keamanan lainnya '
            'untuk melindungi data Anda.',
            ukuran: 13,
          ),

          const SizedBox(height: 18),

          // BAGIAN 4
          teks(
            '4. Hak Pengguna',
            ukuran: 13,
          ),

          poin(
            'Anda dapat memperbarui atau menghapus informasi akun kapan saja.',
            ukuran: 13,
          ),

          poin(
            'Anda dapat menonaktifkan fitur lokasi jika tidak ingin '
            'berbagi data lokasi.',
            ukuran: 13,
          ),

          poin(
            'Kami tidak akan membagikan data pribadi Anda kepada '
            'pihak ketiga tanpa izin.',
            ukuran: 13,
          ),

          const SizedBox(height: 18),

          // KONTAK
          teks(
            'Jika Anda memiliki pertanyaan mengenai kebijakan ini, '
            'silakan hubungi:',
            ukuran: 13,
          ),

          const SizedBox(height: 4),

          teks(
            'privacy@ecowalk.com',
            ukuran: 13,
            warna: hijau,
            tebal: true,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 5. TAMPILAN UTAMA
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            header(context),
            Expanded(
              child: isiKebijakan(),
            ),
          ],
        ),
      ),
    );
  }
}
