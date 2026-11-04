import 'package:flutter/material.dart';
import '../utils/konstanta.dart';
import '../pages/profile_page.dart';
import '../pages/detail_wisata_page.dart';
import '../pages/beri_ulasan_page.dart';
import '../pages/kategori_wisata_page.dart';
import '../pages/cuaca_page.dart';
import '../pages/notifikasi_page.dart';
import '../pages/rekap_perjalanan_page.dart';
import '../pages/terakhir_dilihat_page.dart';
import '../pages/rekomendasi_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  // ==========================================================
  // 1. PENGATURAN GAMBAR
  // Ganti nama file gambar di bagian ini atau pada pemanggilnya.
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
  // 2. VARIABEL KARTU ULASAN
  // ==========================================================

  bool tampilkanUlasan = true;
  int bintangDipilih = 0;



  // ==========================================================
  // 3. HEADER BERANDA
  // ==========================================================

  Widget header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 16, 16),
      child: Row(
        children: [
          // LOGO ECOWALK
          Transform.translate(
            offset: const Offset(20, 0),
            child: gambar(
              'logo_ecowalk_hijau.png',
              lebar: 130,
              tinggi: 45,
            ),
          ),

          const Spacer(),

          // IKON NOTIFIKASI
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotifikasiPage(),
                ),
              );
            },
            child: gambar(
              'Frame 1.png',
              lebar: 85,
              tinggi: 45,
            ),
          ),
        ],
      ),
    );
  }



  // ==========================================================
  // 4. KARTU CUACA
  // ==========================================================

  Widget kartuCuaca() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CuacaPage(),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: gambar(
            'Group 1.png',
            lebar: double.infinity,
            tinggi: 230,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 5. JUDUL BAGIAN
  // ==========================================================

  Widget judulBagian(String judul) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Text(
        judul,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }


// ==========================================================
// 6. DAFTAR GAMBAR HORIZONTAL
// ==========================================================

Widget daftarGambar({
  required List<String> namaGambar,
  required double lebar,
  required double tinggi,
  bool bukaRekapPerjalanan = false,
  bool bukaKategori = false,
}) {
  return SizedBox(
    width: double.infinity,
    height: tinggi,

    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: 16),

      itemCount: namaGambar.length,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 16);
      },

      itemBuilder: (context, index) {
        return SizedBox(
          width: lebar,
          height: tinggi,

          child: GestureDetector(
            behavior: HitTestBehavior.opaque,

            onTap: () {
              if (bukaRekapPerjalanan) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RekapPerjalananPage(),
                  ),
                );
              } else if (bukaKategori) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const KategoriWisataPage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const DetailWisataPage(),
                  ),
                );
              }
            },

            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: gambar(
                namaGambar[index],
                lebar: lebar,
                tinggi: tinggi,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    ),
  );
}

  // ==========================================================
  // 7. KARTU ULASAN PERJALANAN
  // Tombol X menutup kartu, bintang dapat dipilih.
  // ==========================================================
  
  Widget kartuUlasan() {
    if (!tampilkanUlasan) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BeriUlasanPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 15, 16, 24),
        padding: const EdgeInsets.fromLTRB(18, 14, 12, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bagaimana Perjalananmu?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        'Yuk beri ulasan untuk tempat yang baru kamu kunjungi !',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // TOMBOL X UNTUK MENUTUP KARTU
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      tampilkanUlasan = false;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.close,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // BINTANG RATING
            Row(
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    index < bintangDipilih
                        ? Icons.star
                        : Icons.star_border,
                    size: 30,
                    color: Colors.black,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }


    // ==========================================================
    // 8. KATEGORI WISATA
    // ==========================================================

    Widget kategori() {
      final List<String> daftarKategori = [
        'Semua',
        'Kuliner',
        'Sejarah',
        'Alam',
        'Religi',
        'Seni',
      ];

      return SizedBox(
        height: 33,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          scrollDirection: Axis.horizontal,
          itemCount: daftarKategori.length,
          separatorBuilder: (_, __) => const SizedBox(width: 4),
          itemBuilder: (context, index) {
            final bool terpilih = index == 0;

            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: terpilih ? hijau : Colors.transparent,
                borderRadius: BorderRadius.circular(23),
              ),
              child: Text(
                daftarKategori[index],
                style: TextStyle(
                  fontSize: 15,
                  color: terpilih ? Colors.white : Colors.black,
                  fontWeight:
                      terpilih ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            );
          },
        ),
      );
    }


  // ==========================================================
  // 9. JUDUL DENGAN AKSI SELENGKAPNYA
  // ==========================================================


  Widget judulDenganAksi(
    String judul, {
    String teksAksi = 'Selengkapnya',
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              judul,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              if (teksAksi == 'Jelajahi') {
                // Jelajahi menuju halaman Kategori Wisata
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KategoriWisataPage(),
                  ),
                );
              } else if (judul == 'Kunjungi Lagi') {
                // Selengkapnya menuju Rekap Perjalanan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RekapPerjalananPage(),
                  ),
                );
              } else if (judul == 'Terakhir Dilihat') {
                // Selengkapnya menuju halaman Terakhir Dilihat
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TerakhirDilihatPage(),
                  ),
                );
              }
            },
            child: Text(
              teksAksi,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 6),

          const Icon(Icons.chevron_right, size: 18),
        ],
      ),
    );
  }



  // ==========================================================
  // 10. BANNER PERBANDINGAN
  // ==========================================================

  Widget bannerPerbandingan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: gambar(
          'Frame 4.png',
          lebar: double.infinity,
          tinggi: 110,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  // ==========================================================
  // 11. TERAKHIR DILIHAT
  // ==========================================================

  Widget terakhirDilihat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TerakhirDilihatPage(),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: gambar(
              'Group 2.png',
              lebar: 145,
              tinggi: 220,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }



  // ==========================================================
  // 12. ROBOT BANTUAN
  // ==========================================================

  Widget robotBantuan() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 12, top: 8),
        child: gambar(
          'robot.png',
          lebar: 58,
          tinggi: 72,
        ),
      ),
    );
  }


  // ==========================================================
  // 13. NAVIGASI BAWAH
  // ==========================================================

  int halamanAktif = 0;
  
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
              itemNavigasi(0, Icons.home_outlined, 'BERANDA'),
              itemNavigasi(1, Icons.verified_user, 'REKOMENDASI'),
              itemNavigasi(2, Icons.favorite, ''),
              itemNavigasi(3, Icons.person, ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemNavigasi(
    int index,
    IconData ikon,
    String label,
  ) {
    final bool aktif = halamanAktif == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          // MENU REKOMENDASI
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RekomendasiPage(),
              ),
            );
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

          // MENU BERANDA DAN AKTIVITAS
          setState(() {
            halamanAktif = index;
          });

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
              // LINGKARAN PUTIH UNTUK IKON AKTIF
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

              // LABEL MENU AKTIF
              if (aktif && label.isNotEmpty)
                Positioned(
                  top: 70,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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
  // 14. TAMPILAN UTAMA BERANDA
  // SingleChildScrollView membuat konten dapat di-scroll vertikal.
  // Navigasi bawah tetap berada di bagian bawah layar.
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            header(),

            // KONTEN YANG BISA DI-SCROLL
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CUACA
                    kartuCuaca(),

                    judulBagian('Rekomendasi'),
                    daftarGambar(
                      namaGambar: [
                        'Frame 2.png',
                        'Frame 2.png',
                        'Frame 2.png',
                        'Frame 2.png',
                        'Frame 2.png',
                      ],
                      lebar: 390,
                      tinggi: 250,
                    ),

                    const SizedBox(height: 5), // JARAK ANTAR BAGIAN

                    // ULASAN PERJALANAN
                    kartuUlasan(),

                    // KATEGORI
                    judulBagian('Kategori'),
                    kategori(),

                    // PILIHAN TERATAS
                    judulDenganAksi(
                      'Pilihan Teratas',
                      teksAksi: 'Jelajahi',
                    ),

                    daftarGambar(
                      namaGambar: [
                        'Frame 3.png',
                        'Frame 3.png',
                        'Frame 3.png',
                        'Frame 3.png',
                      ],
                      lebar: 450,
                      tinggi: 130,
                      bukaKategori: true,
                    ),

                    // BANNER
                    bannerPerbandingan(),


                  // KUNJUNGI LAGI
                  judulDenganAksi('Kunjungi Lagi'),
                  daftarGambar(
                    namaGambar: [
                      'Frame 3.png',
                    ],
                    lebar: 450,
                    tinggi: 130,
                    bukaRekapPerjalanan: true,
                  ),


                    // TERAKHIR DILIHAT
                    judulDenganAksi('Terakhir Dilihat'),
                    terakhirDilihat(),

                    // ROBOT BANTUAN
                    robotBantuan(),

                    // JARAK DI AKHIR KONTEN
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // NAVIGASI BAWAH TETAP DI BAWAH
            navigasiBawah(),
          ],
        ),
      ),
    );
  }
}