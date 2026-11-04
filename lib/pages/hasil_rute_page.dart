import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/detail_kendaraan_pribadi_page.dart';
import '../pages/detail_transportasi_umum_page.dart';
import '../pages/detail_kendaraan_pribadi_page.dart';

class HasilRutePage extends StatelessWidget {
  const HasilRutePage({super.key});

  static const Color hijau = Color(0xFF1B6B5B);

  // ==========================================================
  // 1. HEADER
  // ==========================================================

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
          const Text(
            'Rekomendasi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // 2. GAMBAR RUTE ASAL DAN TUJUAN
  // ==========================================================

  Widget informasiRute() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Image.asset(
        'lib/images/Group 8.png',
        width: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'Gambar Group 8.png tidak ditemukan',
          );
        },
      ),
    );
  }

  // ==========================================================
  // 3. LOGO TRANSPORTASI DAN WAKTU
  // ==========================================================

  Widget pilihanWaktu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'lib/images/Group 9.png',
          width: double.infinity,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'Gambar Group 9.png tidak ditemukan',
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // 4. PETA PERJALANAN
  // ==========================================================

  Widget petaPerjalanan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'lib/images/Frame 13.png',
          width: double.infinity,
          height: 210,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 210,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Icon(
                Icons.map,
                size: 45,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // 5. OPSI KENDARAAN
  // ==========================================================

  Widget opsiKendaraan(BuildContext context) {

    const double jarakAntarGambar = 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 18, 16, 10),
          child: Text(
            'Opsi Kendaraan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

              SizedBox(width: jarakAntarGambar),

              // TRANSPORTASI UMUM
              Transform.translate(
                offset: const Offset(-140, -15),
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

  // ==========================================================
  // 6. INFORMASI KEUNGGULAN KENDARAAN
  // ==========================================================

  Widget informasiKendaraan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: hijau,
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mau cepat & murah? 👉 Ojek Online',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Mau lebih hemat? 👉 Transportasi Umum',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Mau nyaman & fleksibel? 👉 Kendaraan Pribadi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // 7. TAMPILAN UTAMA
  // ==========================================================

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

              // KONTEN YANG BISA DI-SCROLL
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 38),

                      // ASAL DAN TUJUAN
                      informasiRute(),

                      const SizedBox(height: 25),

                      // LOGO
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'lib/images/logo_ecowalk_hijau.png',
                            width: 130,
                            height: 35,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // PILIHAN WAKTU
                      pilihanWaktu(),

                      const SizedBox(height: 15),

                      // PETA
                      petaPerjalanan(),

                      // OPSI KENDARAAN
                      opsiKendaraan(context),

                      // INFORMASI KENDARAAN
                      Transform.translate(
                        offset: const Offset(0, -20),
                        child: informasiKendaraan(),
                      ),
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
