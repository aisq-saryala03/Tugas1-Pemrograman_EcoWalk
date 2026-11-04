import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/detail_transjakarta_page.dart';
import '../pages/detail_mrt_page.dart';
import '../pages/detail_lrt_page.dart';
import '../pages/detail_krl_page.dart';
import '../pages/detail_mikrotrans_page.dart';

class DetailTransportasiUmumPage extends StatelessWidget {
  const DetailTransportasiUmumPage({super.key});

  static const Color hijau = Color(0xFF1B6B5B);

  // ==========================================================
  // PENGATURAN TAMPILAN
  // ==========================================================

  // Gambar utama Transportasi Umum
  static const double tinggiGambarTransum = 180;

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
  // 2. GAMBAR TRANSPORTASI UMUM
  // ==========================================================

  Widget gambarTransportasiUmum() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'lib/images/image 11.png',
          width: double.infinity,
          height: tinggiGambarTransum,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: tinggiGambarTransum,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Text(
                'Gambar Transportasi Umum tidak ditemukan',
              ),
            );
          },
        ),

        // LABEL TERMURAH
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
              'Termurah',
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
        'TRANSPORTASI UMUM',
        style: TextStyle(
          fontSize: 20,
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
      // Jarak kiri, atas, kanan, dan bawah
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),

      child: Transform.translate(
        // Posisi gambar
        offset: const Offset(geserX, geserY),

        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'lib/images/Group 12.png',
            width: lebarGambar,
            height: tinggiGambar,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'Gambar Group 12.png tidak ditemukan',
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
        'lib/images/Group 13.png',
        width: double.infinity,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'Gambar Group 13.png tidak ditemukan',
          );
        },
      ),
    );
  }

  // ==========================================================
  // 7. OPSI TRANSPORTASI UMUM
  // ==========================================================

  Widget opsiTransportasiUmum(BuildContext context) {
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
              'Opsi Transportasi Umum',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
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

                // Rasio disesuaikan dengan gambar referensi 436 x 349
                final double tinggi = lebar * 390 / 460;

                return SizedBox(
                  width: lebar,
                  height: tinggi,
                  child: Stack(
                    children: [
                      // GAMBAR UTAMA
                      Image.asset(
                        'lib/images/Group 14.png',
                        width: lebar,
                        height: tinggi,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text(
                            'Gambar Group 14.png tidak ditemukan',
                          );
                        },
                      ),

                      // AREA KLIK SELURUH GAMBAR
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTapUp: (details) {
                            final double posisiY =
                                details.localPosition.dy / tinggi;

                            if (posisiY >= 0.05 && posisiY < 0.30) {
                              debugPrint('Klik Transjakarta');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DetailTransjakartaPage(),
                                ),
                              );
                            } else if (posisiY >= 0.30 && posisiY < 0.45) {
                              debugPrint('Klik MRT');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DetailMrtPage(),
                                ),
                              );
                            } else if (posisiY >= 0.45 && posisiY < 0.60) {
                              debugPrint('Klik LRT');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DetailLrtPage(),
                                ),
                              );
                            } else if (posisiY >= 0.60 && posisiY < 0.75) {
                              debugPrint('Klik KRL');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DetailKrlPage(),
                                ),
                              );
                            } else if (posisiY >= 0.75 && posisiY < 0.90) {
                              debugPrint('Klik Mikrotrans');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DetailMikrotransPage(),
                                ),
                              );
                            }
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
  // 8. TAMPILAN UTAMA
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
                      // GAMBAR TRANSPORTASI UMUM
                      gambarTransportasiUmum(),

                      // NAMA KENDARAAN
                      namaKendaraan(),

                      // HARGA DAN ESTIMASI WAKTU
                      informasiHarga(),

                      const SizedBox(height: 22),

                      // PETA PERJALANAN
                      petaPerjalanan(),

                      // ANALISIS PERJALANAN
                      analisisPerjalanan(),

                      // OPSI TRANSPORTASI UMUM
                      opsiTransportasiUmum(context),
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
