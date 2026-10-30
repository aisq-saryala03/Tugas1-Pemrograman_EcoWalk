import 'package:flutter/material.dart';

class KameraPage extends StatelessWidget {
  final String fotoHasil;

  const KameraPage({
    super.key,
    required this.fotoHasil,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // BACKGROUND KAMERA SIMULASI
          Image.asset(
            'lib/images/background.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Text(
                  'Background tidak ditemukan',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),

          // LAPISAN GELAP TIPIS
          Container(
            color: Colors.black.withOpacity(0.08),
          ),

          // TOMBOL KEMBALI
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          // TOMBOL GANTI KAMERA SIMULASI
          Positioned(
            top: MediaQuery.of(context).padding.top + 18,
            right: 18,
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fitur ganti kamera hanya simulasi.',
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(
                Icons.cameraswitch_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          // TOMBOL AMBIL FOTO SIMULASI
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 42,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Mengembalikan foto bawaan sebagai hasil foto simulasi
                  Navigator.pop(context, fotoHasil);
                },
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFF176D5B),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
