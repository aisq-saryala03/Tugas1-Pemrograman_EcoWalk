import 'package:flutter/material.dart';
import 'nilai_ulasan_page.dart';

class DetailWisataPage extends StatefulWidget {
  const DetailWisataPage({super.key});

  @override
  State<DetailWisataPage> createState() => _DetailWisataPageState();
}

class _DetailWisataPageState extends State<DetailWisataPage> {

  // ==========================================================
  // 1. PENGATURAN WARNA
  // Ubah warna halaman dari sini.
  // ==========================================================

  static const Color warnaHijau = Color(0xFF1B6B5B);
  static const Color warnaCyan = Color(0xFF00B4D8);
  static const Color warnaTeks = Colors.black;
  static const Color warnaLatar = Colors.white;
  static const Color warnaJamBuka = Colors.green;


  // ==========================================================
  // 2. PENGATURAN UKURAN
  // Semua ukuran tampilan dikumpulkan di sini.
  // ==========================================================

  // Header
  static const double tinggiHeader = 63;
  static const double ukuranJudulHeader = 19;
  static const double ukuranIkonKembali = 25;

  // Foto
  static const double tinggiFotoUtama = 364;
  static const double lebarFotoTiket = 400;
  static const double tinggiFotoUlasan = 120;
  static const double tinggiFotoPeta = 162;

  // Teks
  static const double ukuranJudulWisata = 25;
  static const double ukuranJudulBagian = 17;
  static const double ukuranDeskripsi = 16;
  static const double ukuranAlamat = 13;
  static const double ukuranJamBuka = 14;
  static const double ukuranTeksKecil = 13;
  static const double ukuranTeksHarga = 14;

  // Ikon
  static const double ukuranIkonFavorit = 29;
  static const double ukuranIkonRating = 17;
  static const double ukuranIkonAlamat = 24;
  static const double ukuranIkonJam = 20;
  static const double ukuranIkonLainnya = 18;

  // Rating
  static const double ratingPaddingHorizontal = 15;
  static const double ratingPaddingVertikal = 10;
  static const double sudutRating = 11;

  // Sudut gambar dan kartu
  static const double sudutGambar = 10;

  // Jarak antarbagian
  static const double jarakKecil = 5;
  static const double jarakSedang = 10;
  static const double jarakBesar = 10;
  static const double jarakAntarBagian = 24;

  // Padding konten
  static const double paddingKiri = 16;
  static const double paddingKanan = 16;


  // ==========================================================
  // 3. DATA WISATA
  // Ubah informasi wisata dari bagian ini.
  // ==========================================================

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


  // ==========================================================
  // 4. NAMA FILE GAMBAR
  // Pastikan nama file sesuai dengan folder lib/images.
  // ==========================================================

  static const String folderGambar = 'lib/images/';

  static const String fotoUtama = 'image 1.png';
  static const String fotoHargaTiket = 'Frame 7.png';
  static const String fotoUlasan = 'Frame 5.png';
  static const String fotoPeta = 'Frame 6.png';


  // ==========================================================
  // 5. FUNGSI MENAMPILKAN GAMBAR
  // ==========================================================

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


  // ==========================================================
  // 6. KOMPONEN RATING
  // ==========================================================

  Widget kotakRating() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ratingPaddingHorizontal,
        vertical: ratingPaddingVertikal,
      ),
      decoration: BoxDecoration(
        color: warnaHijau,
        borderRadius: BorderRadius.circular(sudutRating),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: ukuranIkonRating,
          ),
          const SizedBox(width: jarakKecil),
          Text(
            nilaiRating,
            style: const TextStyle(
              color: Colors.white,
              fontSize: ukuranTeksKecil,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  // ==========================================================
  // 7. HEADER DAN TOMBOL KEMBALI
  // ==========================================================

  Widget bagianHeader() {
    return Container(
      height: tinggiHeader,
      width: double.infinity,
      color: warnaHijau,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: ukuranIkonKembali,
            ),
          ),
          Expanded(
            child: Text(
              namaWisata,
              style: const TextStyle(
                color: Colors.white,
                fontSize: ukuranJudulHeader,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }


  // ==========================================================
  // 8. FOTO UTAMA DAN RATING
  // ==========================================================

  Widget bagianFotoUtama() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Foto utama
        SizedBox(
          width: double.infinity,
          height: tinggiFotoUtama,
          child: Image.asset(
            '$folderGambar$fotoUtama',
            fit: BoxFit.cover,
          ),
        ),

        // Gradasi putih di bagian bawah foto
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          height: 170,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.25, 0.50, 0.75, 1.0],
                colors: [
                  Colors.transparent,
                  Color(0x1AFFFFFF),
                  Color(0x66FFFFFF),
                  Color(0xCCFFFFFF),
                  Colors.white,
                ],
              ),
            ),
          ),
        ),

        // Rating di atas foto
        Positioned(
          left: paddingKiri,
          bottom: 55,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NilaiUlasanPage(),
                ),
              );
            },
            child: kotakRating(),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 9. TOMBOL FAVORIT
  // ==========================================================

  Widget tombolFavorit() {
    return Transform.translate(
      offset: const Offset(-3, -30),
      child: Material(
        color: warnaHijau,
        shape: const CircleBorder(),
        child: IconButton(
          onPressed: () {
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
          icon: Icon(
            favorit
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.white,
            size: ukuranIkonFavorit,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 10. INFORMASI WISATA
  // ==========================================================

  Widget bagianInformasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
      // Nama wisata
      Row(
        children: [
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Text(
                namaWisata,
                style: const TextStyle(
                  fontSize: ukuranJudulWisata,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          tombolFavorit(),
        ],
      ),

        const SizedBox(height: 0),

        // Jam buka
        Row(
          children: [
            const Icon(
              Icons.access_time,
              size: ukuranIkonJam,
            ),
            const SizedBox(width: jarakKecil),
            Text(
              jamBuka,
              style: const TextStyle(
                fontSize: ukuranJamBuka,
                color: warnaJamBuka,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        // Alamat
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.map_outlined,
              size: ukuranIkonAlamat,
            ),
            const SizedBox(width: jarakKecil),
            Expanded(
              child: Text(
                alamat,
                style: const TextStyle(
                  fontSize: ukuranAlamat,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: jarakBesar),

        // Deskripsi
        Text(
          deskripsi,
          style: const TextStyle(
            fontSize: ukuranDeskripsi,
            height: 1.20,
          ),
        ),
      ],
    );
  }


  // ==========================================================
  // 11. HARGA TIKET
  // ==========================================================

  Widget bagianHargaTiket() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Harga Tiket Mulai Dari',
          style: TextStyle(
            fontSize: ukuranTeksHarga,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: jarakKecil),

        tampilkanGambar(
          fotoHargaTiket,
          lebar: lebarFotoTiket,
          fit: BoxFit.contain,
        ),
      ],
    );
  }


  // ==========================================================
  // 12. NILAI DAN ULASAN
  // ==========================================================

  Widget bagianUlasan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          'Nilai & Ulasan',
          style: TextStyle(
            fontSize: ukuranJudulBagian,
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
                      fontSize: ukuranTeksKecil,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    jumlahUlasan,
                    style: const TextStyle(
                      fontSize: ukuranTeksKecil,
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
                      fontSize: ukuranTeksKecil,
                      color: warnaTeks,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: ukuranIkonLainnya,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: jarakSedang),

        ClipRRect(
          borderRadius: BorderRadius.circular(sudutGambar),
          child: tampilkanGambar(
            fotoUlasan,
            tinggi: tinggiFotoUlasan,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }


  // ==========================================================
  // 13. PETA
  // ==========================================================

  Widget bagianPeta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lihat Peta',
          style: TextStyle(
            fontSize: ukuranJudulBagian,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          '1,68 KM dari lokasimu saat ini',
          style: TextStyle(fontSize: ukuranJamBuka),
        ),

        const SizedBox(height: jarakSedang),

        ClipRRect(
          borderRadius: BorderRadius.circular(sudutGambar),
          child: tampilkanGambar(
            fotoPeta,
            tinggi: tinggiFotoPeta,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }


  // ==========================================================
  // 14. NAVIGASI BAWAH
  // ==========================================================

  Widget bagianNavigasiBawah() {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: warnaLatar,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.crop_square,
            color: Colors.blue,
            size: 24,
          ),
          Icon(
            Icons.crop_square,
            color: Colors.blue,
            size: 24,
          ),
        ],
      ),
    );
  }


  // ==========================================================
  // 15. TAMPILAN UTAMA
  // Bagian ini menyusun semua komponen halaman.
  // ==========================================================
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      body: Column(
        children: [
          // Header hijau
          SafeArea(
            bottom: false,
            child: bagianHeader(),
          ),

          // Foto dan konten lainnya
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto langsung menempel di bawah header
                  Transform.translate(
                    offset: const Offset(0, -6),
                    child: bagianFotoUtama(),
                  ),

                  // Informasi wisata
                  Transform.translate(
                    offset: const Offset(0, -55),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(
                        paddingKiri,
                        15,
                        paddingKanan,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bagianInformasi(),

                          const SizedBox(height: 18),

                          bagianHargaTiket(),

                          const SizedBox(height: jarakAntarBagian),

                          bagianUlasan(),

                          const SizedBox(height: jarakAntarBagian),

                          bagianPeta(),

                          const SizedBox(height: jarakAntarBagian),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigasi bawah
          bagianNavigasiBawah(),
        ],
      ),
    );
  }
}