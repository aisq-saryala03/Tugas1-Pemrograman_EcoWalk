
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'nilai_ulasan_page.dart';

class DetailWisataPage extends StatefulWidget {
  const DetailWisataPage({super.key});

  @override
  State<DetailWisataPage> createState() => _DetailWisataPageState();
}

class _DetailWisataPageState extends State<DetailWisataPage> {
  // =====================================
  // 1. PENGATURAN WARNA
  // =====================================

  static const Color warnaHijau = Color(0xFF1B6B5B);
  static const Color warnaTeks = Colors.black;
  static const Color warnaLatar = Colors.white;
  static const Color warnaJamBuka = Colors.green;

  // =====================================
  // 2. DATA WISATA
  // =====================================

  final String namaWisata = 'Dunia Fantasi (DUFAN)';

  final String jamBuka = 'Open | 10:00 - 22:00';

  final String alamat =
      'Jl. Lodan Timur No.7, Ancol, Kec. Pademangan, '
      'Jkt Utara, Daerah Khusus Ibukota Jakarta 14430';

  final String deskripsi =
      'Dufan (Dunia Fantasi) adalah taman hiburan '
      'yang terletak di kawasan Taman Impian Ancol, '
      'Jakarta Utara. Dufan merupakan salah satu '
      'taman hiburan terbesar dan terpopuler di Indonesia.';

  final String nilaiRating = '4.75';
  final String jumlahUlasan = '24.543 Ulasan';

  bool favorit = false;

  // =====================================
  // 3. NAMA FILE GAMBAR
  // =====================================

  static const String folderGambar = 'lib/images/';

  static const String fotoUtama = 'image 1.png';
  static const String fotoHargaTiket = 'Frame 7.png';
  static const String fotoUlasan = 'Frame 5.png';
  static const String fotoPeta = 'Frame 6.png';

  // =====================================
  // 4. FUNGSI MENAMPILKAN GAMBAR
  // =====================================

  Widget tampilkanGambar(
    String namaFile, {
    double? lebar,
    double? tinggi,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      '$folderGambar$namaFile',
      width: lebar,
      height: tinggi,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: lebar ?? double.infinity,
          height: tinggi ?? 120,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: 30,
              ),
              SizedBox(height: 5),
              Text(
                'Gambar belum ditemukan',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }

  // =====================================
  // 5. KOMPONEN RATING
  // =====================================

  Widget kotakRating() {
    return Container(
      height: 29,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: const Color(0xFF4D8B7F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: Color(0xFFFFDA00),
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            nilaiRating,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // 6. HEADER
  // =====================================

  Widget bagianHeader() {
    return Container(
      height: 63,
      width: double.infinity,
      color: warnaHijau,
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
          Expanded(
            child: Text(
              namaWisata,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // 7. FOTO UTAMA, RATING, JUDUL, FAVORIT
  // =====================================

  Widget bagianFotoUtama() {
    return SizedBox(
      height: 270,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // FOTO UTAMA
          tampilkanGambar(
            fotoUtama,
            lebar: double.infinity,
            tinggi: 270,
            fit: BoxFit.cover,
          ),

          // GRADASI PUTIH BAGIAN BAWAH
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xBBFFFFFF),
                  Colors.white,
                ],
                stops: [0.0, 0.52, 0.82, 1.0],
              ),
            ),
          ),

          // RATING
          Positioned(
            left: 16,
            bottom: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NilaiUlasanPage(),
                  ),
                );
              },
              child: kotakRating(),
            ),
          ),

          // JUDUL WISATA
          Positioned(
            left: 16,
            right: 68,
            bottom: 4,
            child: Text(
              namaWisata,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // TOMBOL FAVORIT
          Positioned(
            right: 16,
            bottom: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  favorit = !favorit;
                });

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        favorit
                            ? 'Ditambahkan ke favorit'
                            : 'Dihapus dari favorit',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF4D8B7F),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  favorit ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // 8. INFORMASI WISATA
  // =====================================

  Widget bagianInformasi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 7),

          // JAM BUKA
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                color: Colors.black,
                size: 17,
              ),
              const SizedBox(width: 5),
              Text(
                'Open',
                style: TextStyle(
                  color: warnaJamBuka,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '| 10:00 - 22:00',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          // ALAMAT
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.map_outlined,
                color: Colors.black,
                size: 19,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  alamat,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          // DESKRIPSI
          Text(
            deskripsi,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // 9. HARGA TIKET
  // =====================================

  Widget bagianHargaTiket() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Harga Tiket Mulai Dari',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          tampilkanGambar(
            fotoHargaTiket,
            lebar: double.infinity,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // =====================================
  // 10. NILAI DAN ULASAN
  // =====================================

  Widget bagianUlasan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nilai & Ulasan',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              kotakRating(),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rekomendasi Istimewa',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      jumlahUlasan,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NilaiUlasanPage(),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 10,
                        color: warnaTeks,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 17,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: tampilkanGambar(
              fotoUlasan,
              lebar: double.infinity,
              tinggi: 120,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // 11. PETA
  // =====================================

  Widget bagianPeta() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lihat Peta',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          const Text(
            '1,68 KM dari lokasimu saat ini',
            style: TextStyle(
              fontSize: 11,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 9),

          ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: tampilkanGambar(
              fotoPeta,
              lebar: double.infinity,
              tinggi: 162,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================
  // 12. TAMPILAN UTAMA
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
        backgroundColor: warnaLatar,
        body: SafeArea(
          child: Column(
            children: [
              // HEADER
              bagianHeader(),

              // ISI HALAMAN
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FOTO WISATA
                      bagianFotoUtama(),

                      // INFORMASI WISATA
                      bagianInformasi(),

                      const SizedBox(height: 20),

                      // HARGA TIKET
                      bagianHargaTiket(),

                      const SizedBox(height: 24),

                      // NILAI DAN ULASAN
                      bagianUlasan(),

                      const SizedBox(height: 24),

                      // PETA
                      bagianPeta(),

                      const SizedBox(height: 30),
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
