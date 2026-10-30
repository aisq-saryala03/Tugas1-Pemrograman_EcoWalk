
import 'package:flutter/material.dart';
import '../utils/konstanta.dart';

class KetentuanLayananPage extends StatelessWidget {
  const KetentuanLayananPage({super.key});

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
          const SizedBox(width: 0),
          const Text(
            'Ketentuan Layanan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 2. KOMPONEN TEKS DOKUMEN
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
  // 3. ISI KETENTUAN LAYANAN
  // ============================================================
  Widget isiKetentuan() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO
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
            'KETENTUAN PENGGUNAAN APLIKASI ECOWALK',
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
            'Selamat datang di ECOWALK! Dengan menggunakan aplikasi '
            'ini, Anda setuju dengan ketentuan dan persyaratan berikut:',
            ukuran: 13,
          ),

          const SizedBox(height: 20),

          // KETENTUAN 1
          teks(
            '1. Dengan menggunakan aplikasi ECOWALK, Anda dapat '
            'menemukan informasi tentang tempat wisata, rekomendasi '
            'tempat, perbandingan harga, dan layanan peta berbasis lokasi.',
            ukuran: 13,
          ),

          const SizedBox(height: 16),

          // KETENTUAN 2
          teks(
            '2. Anda bertanggung jawab atas keakuratan data, termasuk '
            'ulasan dan foto, yang Anda masukkan.',
            ukuran: 13,
          ),

          const SizedBox(height: 16),

          // KETENTUAN 3
          teks(
            '3. Perubahan Layanan ECOWALK berhak mengubah, menambah, '
            'atau menghentikan layanan tanpa pemberitahuan sebelumnya. '
            'Pengguna bertanggung jawab atas keamanan akun mereka, '
            'termasuk kata sandi. Pengguna juga dilarang menggunakan '
            'aplikasi untuk tujuan yang dapat merugikan pihak lain.\n'
            'Informasi yang diberikan oleh sumber seperti tiket atau '
            'biaya transportasi tidak akurat, dan kami tidak bertanggung '
            'jawab atas kesalahan tersebut.',
            ukuran: 13,
          ),

          const SizedBox(height: 16),

          // KETENTUAN 4
          teks('4. Penolakan Tanggung Jawab',
          ukuran: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                teks(
                  '• ECOWALK hanya menyediakan informasi sebagai '
                  'referensi dan bukan penyedia layanan wisata '
                  'atau transportasi.',
                  ukuran: 13,
                ),
                teks(
                  '• Kami tidak bertanggung jawab atas perubahan harga, '
                  'ketersediaan tempat, atau keterlambatan transportasi.',
                  ukuran: 13,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // PENUTUP
          teks(
            'Dengan menggunakan aplikasi ini, Anda menyetujui semua '
            'ketentuan di atas.',
            ukuran: 13,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 4. TAMPILAN UTAMA
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
              child: isiKetentuan(),
            ),
          ],
        ),
      ),
    );
  }
}
