
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeberangkatanPage extends StatelessWidget {
  const KeberangkatanPage({super.key});

  static const Color hijau = Color(0xFF1B6B5B);

  // ==========================================================
  // PENGATURAN TAMPILAN
  // ==========================================================

  static const double tinggiPeta = 340;
  static const double tinggiKartu = 112;
  static const double posisiKartu = -55;

  // ==========================================================
  // 1. HEADER
  // ==========================================================

  Widget header(BuildContext context) {
    return Container(
      height: 53,
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
            'Keberangkatan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // 2. GAMBAR PETA
  // ==========================================================

  Widget gambarPeta() {
    return Image.asset(
      'lib/images/Frame 17.png',
      width: double.infinity,
      height: tinggiPeta,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: tinggiPeta,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Text(
            'Gambar Frame 17.png tidak ditemukan',
          ),
        );
      },
    );
  }

  // ==========================================================
  // 3. KARTU KEBERANGKATAN
  // ==========================================================

  Widget gambarKeberangkatan(String namaFile) {
    return Image.asset(
      namaFile,
      width: double.infinity,
      height: tinggiKartu,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: tinggiKartu,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Gambar $namaFile tidak ditemukan',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // 4. DAFTAR KEBERANGKATAN
  // ==========================================================

  Widget daftarKeberangkatan() {
    return Container(
      width: double.infinity,
      color: hijau,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
        child: Transform.translate(
          offset: const Offset(0, posisiKartu),
          child: Column(
            children: [
              // KEBERANGKATAN KORIDOR
              gambarKeberangkatan(
                'lib/images/Group 15.png',
              ),

              const SizedBox(height: 8),

              // KEBERANGKATAN BUS 2
              gambarKeberangkatan(
                'lib/images/Group 16.png',
              ),

              const SizedBox(height: 8),

              gambarKeberangkatan(
                'lib/images/Group 16.png',
              ),

              const SizedBox(height: 8),

              gambarKeberangkatan(
                'lib/images/Group 16.png',
              ),

              const SizedBox(height: 8),

              gambarKeberangkatan(
                'lib/images/Group 16.png',
              ),

              const SizedBox(height: 8),

              gambarKeberangkatan(
                'lib/images/Group 16.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 5. TAMPILAN UTAMA
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: hijau,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: hijau,

        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // HEADER
              header(context),

              // KONTEN YANG BISA DI-SCROLL
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // GAMBAR PETA
                      gambarPeta(),

                      // DAFTAR KEBERANGKATAN
                      daftarKeberangkatan(),
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
