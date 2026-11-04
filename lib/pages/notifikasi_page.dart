
import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  static const Color hijau = Color(0xFF1B6B5B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 63,
              width: double.infinity,
              color: hijau,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Notifikasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ISI HALAMAN
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                children: [
                  // NOTIFIKASI DESTINASI 1
                  notifikasiWisata(),

                  // NOTIFIKASI DESTINASI 2
                  notifikasiWisata(),

                  // NOTIFIKASI DESTINASI 3
                  notifikasiWisata(),

                  // NOTIFIKASI DESTINASI 4
                  notifikasiWisata(),

                  // NOTIFIKASI CUACA
                  notifikasiCuaca(),

                  // NOTIFIKASI DESTINASI 5
                  notifikasiWisata(),

                  // NOTIFIKASI DESTINASI 6
                  notifikasiWisata(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NOTIFIKASI WISATA
  Widget notifikasiWisata() {
    return Container(
      height: 101,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE1E1E1),
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GAMBAR DESTINASI
          Container(
            width: 66,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(width: 18),

          // INFORMASI NOTIFIKASI
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dunia Fantasi (DUFAN)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 2),

                const Text(
                  '19 Februari 2025',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 8,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Transportasi Umum',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9,
                  ),
                ),

                const SizedBox(height: 2),

                const Text(
                  'Pergi Lagi',
                  style: TextStyle(
                    color: Color(0xFF008FE5),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // STATUS SELESAI
          const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xFF1B6657),
                size: 11,
              ),
              SizedBox(width: 2),
              Text(
                'Selesai',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // NOTIFIKASI CUACA
  Widget notifikasiCuaca() {
    return Container(
      height: 101,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE1E1E1),
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // GAMBAR CUACA
          Image.asset(
            'lib/images/image 4.png',
            width: 66,
            height: 60,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 18),

          // INFORMASI CUACA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Cuaca Sedang Cerah',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  '19 Februari 2025',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 8,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Yuk keluar dan jalan-jalan !',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  'Lihat Destinasi Wisata',
                  style: TextStyle(
                    color: Color(0xFF008FE5),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
