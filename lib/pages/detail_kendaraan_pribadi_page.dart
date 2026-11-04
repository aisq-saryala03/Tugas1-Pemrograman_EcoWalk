import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/detail_mobil_page.dart';
import '../pages/detail_motor_page.dart';
import '../pages/detail_ojek_online_page.dart';
import '../pages/detail_taxi_page.dart';

class DetailKendaraanPribadiPage extends StatelessWidget {
  const DetailKendaraanPribadiPage({super.key});

  static const Color hijau = Color(0xFF1B6B5B);

  // ==========================================================
  // PENGATURAN TAMPILAN
  // ==========================================================

  // Gambar utama Ojek Online
  static const double tinggiGambarOjek = 180;

  // Gambar peta
  static const double tinggiPeta = 210;

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
  // 2. GAMBAR OJEK ONLINE
  // ==========================================================

  Widget gambarOjekOnline() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'lib/images/image 5.png',
          width: double.infinity,
          height: tinggiGambarOjek,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: tinggiGambarOjek,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Text('Gambar Ojek Online tidak ditemukan'),
            );
          },
        ),

        // LABEL TERCEPAT
        Positioned(
          right: 16,
          bottom: -12,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Tercepat',
              style: TextStyle(
                color: hijau,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 3. NAMA KENDARAAN
  // ==========================================================

  Widget namaKendaraan() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 17, 16, 5),
      child: Text(
        'Kendaraan Pribadi',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
    );
  }


  // ==========================================================
  // 4. HARGA DAN ESTIMASI WAKTU
  // ==========================================================

  Widget informasiHarga() {

    // PENGATURAN UKURAN GAMBAR
    const double lebarGambar = 150;
    const double tinggiGambar = 55;

    // PENGATURAN POSISI GAMBAR
    const double geserX = 0;
    const double geserY = -5;

    return Padding(
      // Mengatur jarak kiri, atas, kanan, dan bawah
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),

      child: Transform.translate(
        // Mengatur posisi gambar
        offset: const Offset(geserX, geserY),

        child: Align(
          alignment: Alignment.centerLeft,

          child: Image.asset(
            'lib/images/Group 11.png',
            width: lebarGambar,
            height: tinggiGambar,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'Gambar Group 11.png tidak ditemukan',
              );
            },
          ),
        ),
      ),
    );
  }


  // ==========================================================
  // 5. PETA PERJALANAN
  // ==========================================================

  Widget petaPerjalanan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'lib/images/Frame 13.png',
          width: double.infinity,
          height: tinggiPeta,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: tinggiPeta,
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
  // 6. ANALISIS PERJALANAN
  // ==========================================================

  Widget analisisPerjalanan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
      child: Image.asset(
        'lib/images/Group 10.png',
        width: double.infinity,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return const Text('Gambar Group 10.png tidak ditemukan');
        },
      ),
    );
  }


  // ==========================================================
  // 7. OPSI KENDARAAN PRIBADI
  // ==========================================================

  Widget opsiKendaraanPribadi(BuildContext context) {

    // PENGATURAN UKURAN GAMBAR
    const double lebarGambar = double.infinity;

    // PENGATURAN POSISI DAN JARAK
    const double geserX = 0;
    const double geserY = 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Opsi Kendaraan Pribadi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // GAMBAR DAN AREA KLIK DETAIL
          Transform.translate(
            offset: const Offset(geserX, geserY),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double lebar = constraints.maxWidth;
                final double tinggi = lebar * 266 / 369;

                return SizedBox(
                  width: lebar,
                  height: tinggi,
                  child: Stack(
                    children: [

                      // GAMBAR UTAMA
                      Image.asset(
                        'lib/images/Group 17.png',
                        width: lebar,
                        height: tinggi,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text(
                            'Gambar Group 17.png tidak ditemukan',
                          );
                        },
                      ),

                      // DETAIL MOBIL
                      Positioned(
                        left: lebar * 0.78,
                        top: tinggi * 0.10,
                        width: lebar * 0.20,
                        height: tinggi * 0.11,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailMobilPage(),
                              ),
                            );  
                          },
                        ),
                      ),

                      // DETAIL MOTOR
                      Positioned(
                        left: lebar * 0.78,
                        top: tinggi * 0.315,
                        width: lebar * 0.20,
                        height: tinggi * 0.11,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetailMotorPage(),
                                ),
                              );
                            },
                        ),
                      ),

                      // DETAIL OJEK ONLINE
                      Positioned(
                        left: lebar * 0.78,
                        top: tinggi * 0.53,
                        width: lebar * 0.20,
                        height: tinggi * 0.11,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailOjekOnlinePage(),
                              ),
                            );
                          },
                        ),
                      ),

                      // DETAIL TAXI
                      Positioned(
                        left: lebar * 0.78,
                        top: tinggi * 0.745,
                        width: lebar * 0.20,
                        height: tinggi * 0.11,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailTaxiPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
                      // GAMBAR OJEK ONLINE
                      gambarOjekOnline(),

                      // NAMA KENDARAAN
                      namaKendaraan(),

                      // HARGA DAN ESTIMASI WAKTU
                      informasiHarga(),

                      const SizedBox(height: 22),

                      // PETA PERJALANAN
                      petaPerjalanan(),

                      // ANALISIS PERJALANAN
                      analisisPerjalanan(),

                      // OPSI KENDARAAN PRIBADI
                      opsiKendaraanPribadi(context),
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
