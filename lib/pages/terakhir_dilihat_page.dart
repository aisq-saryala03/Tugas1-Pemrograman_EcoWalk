
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TerakhirDilihatPage extends StatelessWidget {
  const TerakhirDilihatPage({super.key});

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
            'Terakhir Dilihat',
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

  // =====================================
  // DAFTAR WISATA
  // =====================================

  Widget daftarWisata() {
    return Image.asset(
      'lib/images/Group 7.png',
      width: double.infinity,
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.grey.shade200,
          child: const Text(
            'Gambar daftar wisata belum ditemukan',
            style: TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }

  // =====================================
  // NAVIGASI BAWAH
  // =====================================

  Widget navigasiBawah() {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 0.5,
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.crop_square,
            color: Color(0xFF168AFF),
            size: 24,
          ),
          Icon(
            Icons.crop_square,
            color: Color(0xFF168AFF),
            size: 24,
          ),
        ],
      ),
    );
  }

  // =====================================
  // TAMPILAN UTAMA
  // =====================================

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

              // ISI HALAMAN
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      daftarWisata(),
                    ],
                  ),
                ),
              ),

              // NAVIGASI BAWAH
              navigasiBawah(),
            ],
          ),
        ),
      ),
    );
  }
}
