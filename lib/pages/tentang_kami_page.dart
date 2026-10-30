
import 'package:flutter/material.dart';
import '../utils/konstanta.dart';

class TentangKamiPage extends StatelessWidget {
  const TentangKamiPage({super.key});

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
            'Tentang Kami',
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
    double tinggiBaris = 1.6,
    Color warna = Colors.black,
    TextDecoration dekorasi = TextDecoration.none,
  }) {
    return Text(
      isi,
      style: TextStyle(
        fontSize: ukuran,
        fontWeight: tebal ? FontWeight.w700 : FontWeight.normal,
        fontStyle: miring ? FontStyle.italic : FontStyle.normal,
        height: tinggiBaris,
        color: warna,
        decoration: dekorasi,
      ),
    );
  }

  // ============================================================
  // 3. KOMPONEN POIN
  // ============================================================
  Widget poin(String isi) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 3,
        bottom: 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          teks(
            '●',
            ukuran: 12,
            tebal: true,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: teks(
              isi,
              ukuran: 12,
            ),
          ),
        ],
      ),
    );
  }


  // ============================================================
  // 4. KOMPONEN KONTAK
  // ============================================================
  Widget itemKontak({
    required IconData ikon,
    required String isi,
    VoidCallback? aksi,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: aksi,
        child: Row(
          children: [
            Icon(
              ikon,
              size: 20,
              color: Colors.black,
            ),
            const SizedBox(width: 9),
            Expanded(
              child: teks(
                isi,
                ukuran: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 5. ISI HALAMAN TENTANG KAMI
  // ============================================================
  Widget isiTentangKami() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(11, 14, 11, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO ECOWALK
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 2,
                bottom: 18,
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

          // DESKRIPSI APLIKASI
          teks(
            'ECOWALK adalah aplikasi wisata yang membantu pengguna '
            'menemukan destinasi terbaik dengan rekomendasi '
            'berdasarkan lokasi, perbandingan harga, serta informasi '
            'transportasi.',
            ukuran: 13,
          ),

          const SizedBox(height: 14),

          // MISI KAMI
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              teks(
                'Misi Kami',
                ukuran: 13,
                tebal: true,
              ),
              Container(
                width: 65,
                height: 1,
                color: Colors.black,
                margin: const EdgeInsets.only(top: 1),
              ),
            ],
          ),

          teks(
            'Menyediakan pengalaman wisata yang lebih mudah, '
            'informatif, dan terjangkau bagi semua orang dengan '
            'fokus pada ekowisata yang ramah lingkungan.',
            ukuran: 13,
          ),

          const SizedBox(height: 14),

          // APA YANG KAMI TAWARKAN
          teks('Apa yang Kami Tawarkan?',
          ukuran: 13,
          ),
          

          poin(
            'Rekomendasi tempat wisata berdasarkan lokasi '
            'dan preferensi Anda.',
            
          ),

          poin(
            'Informasi harga tiket, ketersediaan fasilitas, '
            'dan ulasan pengguna.',
          ),

          poin(
            'Peta interaktif untuk membantu navigasi di area wisata.',
          ),

          poin(
            'Perbandingan harga transportasi untuk perjalanan '
            'yang lebih hemat.',
          ),

          const SizedBox(height: 4),

          // PENUTUP
          teks(
            'Kami percaya bahwa menjelajahi dunia harus menjadi '
            'pengalaman yang menyenangkan dan mudah diakses oleh '
            'semua orang, dengan tetap menjaga kelestarian lingkungan.',
            ukuran: 13,
          ),

          const SizedBox(height: 2),

          // KONTAK
          teks(
            'Untuk pertanyaan atau saran, hubungi kami di:',
            ukuran: 13,
          ),

          const SizedBox(height: 10),

          itemKontak(
            ikon: Icons.email,
            isi: 'support@ecowalk.com',
          ),

          itemKontak(
            ikon: Icons.phone,
            isi: '0899-1234-4567',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 6. TAMPILAN UTAMA
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
              child: isiTentangKami(),
            ),
          ],
        ),
      ),
    );
  }
}
