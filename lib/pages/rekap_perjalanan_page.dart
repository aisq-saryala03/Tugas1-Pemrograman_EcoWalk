import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/detail_kendaraan_pribadi_page.dart';
import '../pages/detail_transportasi_umum_page.dart';
import '../pages/beri_ulasan_page.dart';
import '../pages/kategori_wisata_page.dart';

class RekapPerjalananPage extends StatelessWidget {
  const RekapPerjalananPage({super.key});

  static const Color hijau = Color(0xFF1B6B5B);

  // =====================================
  // HEADER
  // =====================================

  Widget header(BuildContext context) {
    return Container(
      height: 63,
      width: double.infinity,
      color: hijau,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Rekap Perjalanan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // FOTO WISATA MELENGKUNG
  // =====================================

  Widget fotoWisata() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(55),
          bottomRight: Radius.circular(55),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(55),
          bottomRight: Radius.circular(55),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 140,
          child: Image.asset(
            'lib/images/image 1.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported,
                  size: 40,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =====================================
  // INFORMASI WISATA
  // =====================================

  Widget informasiWisata() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dunia Fantasi (DUFAN)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 3),

          // TANGGAL PERJALANAN
          const Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.grey,
                size: 20,
              ),
              SizedBox(width: 7),
              Text(
                '19 Februari 2025 | 12:00 WIB',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ALAMAT WISATA
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.map_outlined,
                color: Colors.black,
                size: 19,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Jl. Lodan Timur No.7, Ancol, Kec. '
                  'Pademangan, Jkt Utara, Daerah Khusus '
                  'Ibukota Jakarta 14430',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================
  // JUDUL BAGIAN
  // =====================================

  Widget judulBagian(String judul) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        judul,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  // =====================================
  // RUTE PERJALANAN
  // =====================================

  Widget bagianRute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        judulBagian('Rute Perjalanan'),

        const SizedBox(height: 7),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: double.infinity,
              height: 136,
              child: Image.asset(
                'lib/images/Frame 6.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.map,
                      size: 40,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }



  // =====================================
  // TRANSPORTASI / OPSI KENDARAAN
  // =====================================

  Widget bagianTransportasi(BuildContext context) {
    const double jarakAntarGambar = 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // JUDUL OPSI KENDARAAN
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Text(
            'Opsi Kendaraan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),

        // FOTO PILIHAN KENDARAAN
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // KENDARAAN PRIBADI
              Transform.translate(
                offset: const Offset(-40, -15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DetailKendaraanPribadiPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'lib/images/Frame 14.png',
                      width: 155,
                      height: 155,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: jarakAntarGambar),

              // TRANSPORTASI UMUM
              Transform.translate(
                offset: const Offset(-100, -8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DetailTransportasiUmumPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'lib/images/Frame 15.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================
  // PENILAIAN PERJALANAN
  // =====================================

  Widget bagianPenilaian(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BeriUlasanPage(),
            ),
          );
        },
        child: Image.asset(
          'lib/images/Group 6.png',
          width: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 110,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Gambar penilaian belum ditemukan',
                style: TextStyle(fontSize: 11),
              ),
            );
          },
        ),
      ),
    );
  }

Widget tombolPergiLagi(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KategoriWisataPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: hijau,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'Pergi Lagi',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            header(context),

            // SELURUH KONTEN HALAMAN
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fotoWisata(),

                    const SizedBox(height: 25),

                    informasiWisata(),

                    const SizedBox(height: 32),

                    bagianRute(),

                    const SizedBox(height: 18),

                    // OPSI KENDARAAN
                    bagianTransportasi(context),

                    // KOTAK PENILAIAN - DITARIK KE ATAS
                    Transform.translate(
                      offset: const Offset(0, -15),
                      child: bagianPenilaian(context),
                    ),

                    // TOMBOL PERGI LAGI
                    const SizedBox(height: 5),

                    tombolPergiLagi(context),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
