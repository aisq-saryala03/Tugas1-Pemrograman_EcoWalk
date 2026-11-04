import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/konstanta.dart';
import '../pages/profile_page.dart';
import '../pages/detail_wisata_page.dart';
import '../beranda_page.dart';
import '../pages/hasil_rute_page.dart';


class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  // ==========================================================
  // 1. PENGATURAN GAMBAR
  // ==========================================================

  static const String folderGambar = 'lib/images/';

  Widget gambar(
    String nama, {
    double? lebar,
    double? tinggi,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      '$folderGambar$nama',
      width: lebar,
      height: tinggi,
      fit: fit,
    );
  }

  // ==========================================================
  // 2. VARIABEL LOKASI
  // ==========================================================

  final TextEditingController lokasiAsalController =
      TextEditingController();

  final TextEditingController lokasiTujuanController =
      TextEditingController();

  int halamanAktif = 1;

  // ==========================================================
  // 3. HEADER LOGO ECOWALK
  // ==========================================================

  Widget header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: gambar(
          'logo_ecowalk_hijau.png',
          lebar: 140,
          tinggi: 50,
        ),
      ),
    );
  }

  // ==========================================================
  // 4. KOLOM INPUT LOKASI
  // ==========================================================

  Widget kolomLokasi({
    required TextEditingController controller,
    required String petunjuk,
    required IconData ikon,
  }) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: petunjuk,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
          prefixIcon: Icon(
            ikon,
            size: 24,
            fontWeight: FontWeight.w800,
            weight: 2.5,
            color: Colors.black54,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 11,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 5. PENCARIAN RUTE
  // ==========================================================

  Widget pencarianRute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // JUDUL
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 9),
          child: Text(
            'MAU KEMANA HARI INI?',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),

        // KOTAK HIJAU INPUT LOKASI
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
          decoration: BoxDecoration(
            color: hijau,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Column(
            children: [
              // LOKASI ASAL
              kolomLokasi(
                controller: lokasiAsalController,
                petunjuk: 'Masukan Lokasi Asal',
                ikon: Icons.search,
              ),

              const SizedBox(height: 10),

              // LOKASI TUJUAN
              kolomLokasi(
                controller: lokasiTujuanController,
                petunjuk: 'Masukan Lokasi Tujuan',
                ikon: Icons.location_on_outlined,
              ),
            ],
          ),
        ),

        // TOMBOL CARI RUTE
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
          child: SizedBox(
            width: 130,
            height: 37,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HasilRutePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: hijau,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Cari Rute',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 6. KARTU WISATA
  // ==========================================================

  Widget kartuWisata({
    required String nama,
    required String lokasi,
    required String harga,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailWisataPage(),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 153,
          height: 220,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // FOTO WISATA
              gambar(
                'Frame 12.png',
                lebar: 153,
                tinggi: 220,
                fit: BoxFit.cover,
              ),

              // LAPISAN GELAP BAGIAN BAWAH
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(
                    6, 15, 6, 7,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAMA WISATA
                      Text(
                        nama,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 3),

                      // LOKASI
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 10,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              lokasi,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 7,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 3),

                      // HARGA
                      Text(
                        'Mulai dari Rp. $harga',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // RATING DAN LEBIH LANJUT
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          const Icon(
                            Icons.star_half,
                            color: Colors.yellow,
                            size: 12,
                          ),

                          const Spacer(),

                          const Text(
                            'Lebih Lanjut',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 6,
                            ),
                          ),

                          const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 10,
                          ),
                        ],
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


  // ==========================================================
  // 7. REKOMENDASI TUJUAN
  // ==========================================================

  Widget rekomendasiTujuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 42, 16, 19),
          child: Text(
            'Rekomendasi Tujuan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            'lib/images/Frame 12.png',
            width: double.infinity,
            height: 250,
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 9. NAVIGASI BAWAH
  // ==========================================================

  Widget navigasiBawah() {
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // LATAR HIJAU
          Positioned(
            left: 0,
            right: 0,
            top: 30,
            bottom: -30,
            child: Container(
              color: const Color(0xFF1B6657),
            ),
          ),

          // EMPAT IKON NAVIGASI
          Row(
            children: [
              itemNavigasi(
                0,
                Icons.home_outlined,
                '',
              ),
              itemNavigasi(
                1,
                Icons.verified_user,
                'REKOMENDASI',
              ),
              itemNavigasi(
                2,
                Icons.favorite,
                '',
              ),
              itemNavigasi(
                3,
                Icons.person,
                '',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // 10. ITEM NAVIGASI
  // ==========================================================
  
  Widget itemNavigasi(
    int index,
    IconData ikon,
    String label,
  ) {
    final bool aktif = halamanAktif == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          // MENU BERANDA
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BerandaPage(),
              ),
            );
            return;
          }

          // MENU REKOMENDASI
          if (index == 1) {
            return;
          }

          // MENU PROFIL
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
            return;
          }

          // MENU AKTIVITAS
          if (index == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Menu Aktivitas dipilih'),
                duration: Duration(milliseconds: 800),
              ),
            );
          }
        },
        child: SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              if (aktif)
                Positioned(
                  top: -20,
                  child: Container(
                    width: 92,
                    height: 92,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B6657),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        ikon,
                        size: 47,
                        color: const Color(0xFF315F55),
                      ),
                    ),
                  ),
                )
              else
                Positioned(
                  top: 44,
                  child: Icon(
                    ikon,
                    size: 38,
                    color: Colors.white,
                  ),
                ),

              if (aktif && label.isNotEmpty)
                Positioned(
                  top: 70,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }


  // ==========================================================
  // 11. TAMPILAN UTAMA REKOMENDASI
  // ==========================================================

  @override
  void dispose() {
    lokasiAsalController.dispose();
    lokasiTujuanController.dispose();
    super.dispose();
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
              header(),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PENCARIAN RUTE
                        pencarianRute(),

                        // REKOMENDASI TUJUAN
                        rekomendasiTujuan(),

                        // JARAK DI AKHIR KONTEN
                        const SizedBox(height: 20),
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
