
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailMotorPage extends StatelessWidget {
  const DetailMotorPage({super.key});

  static const Color hijau = Color(0xFF1B6B5B);

  // ==========================================================
  // PENGATURAN TAMPILAN
  // ==========================================================

  static const double tinggiGambarMotor = 180;

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
            'Kendaraan Pribadi',
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
  // 2. GAMBAR MOTOR
  // ==========================================================

  Widget gambarMotor() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'lib/images/image 9.png',
          width: double.infinity,
          height: tinggiGambarMotor,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: tinggiGambarMotor,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Text(
                'Gambar Motor tidak ditemukan',
              ),
            );
          },
        ),

        // LABEL REKOMENDASI
        Positioned(
          right: 20,
          bottom: -12,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
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
              'Praktis',
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
      padding: EdgeInsets.fromLTRB(16, 17, 16, 25),
      child: Text(
        'MOTOR',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  // ==========================================================
  // 4. ITEM INFORMASI DROPDOWN
  // ==========================================================

  Widget itemInformasi({
    required String judul,
    String isi = '',
    Widget? isiCustom,
    bool warnaHijau = false,
    double paddingBawah = 14,
    double tinggiJudul = 45,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: warnaHijau ? hijau : Colors.white,
        border: warnaHijau
            ? null
            : Border.all(
                color: Colors.black,
                width: 2,
              ),
        borderRadius: BorderRadius.circular(11),
        boxShadow: warnaHijau
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          visualDensity: const VisualDensity(
            vertical: -2,
          ),
          minTileHeight: tinggiJudul,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            paddingBawah,
          ),
          iconColor:
              warnaHijau ? Colors.white : Colors.grey.shade700,
          collapsedIconColor:
              warnaHijau ? Colors.white : Colors.grey.shade700,
          title: Text(
            judul,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: warnaHijau ? Colors.white : Colors.black,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: isiCustom ??
                  Text(
                    isi,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: warnaHijau
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // 5. DAFTAR INFORMASI MOTOR
  // ==========================================================

  Widget daftarInformasi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [

          // BIAYA
          itemInformasi(
            judul: 'Biaya',
            isiCustom: const Text(
              'Biaya bahan bakar dan parkir '
              'menyesuaikan jarak perjalanan.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                height: 1.4,
              ),
            ),
          ),

          // ESTIMASI
          itemInformasi(
            judul: 'Estimasi',
            isiCustom: const Text(
              'Waktu perjalanan menyesuaikan jarak '
              'dan kondisi lalu lintas selama perjalanan.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.45,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
          ),

          // KETERANGAN KENDARAAN
          itemInformasi(
            judul: 'Keterangan Kendaraan',
            isiCustom: const Text(
              'Motor merupakan kendaraan pribadi '
              'yang cocok digunakan untuk perjalanan '
              'dengan jumlah penumpang terbatas. '
              'Kendaraan ini lebih mudah digunakan '
              'untuk melewati jalan yang relatif padat.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),

          // KONDISI LALU LINTAS
          itemInformasi(
            judul: 'Kondisi Lalu Lintas',
            isiCustom: const Text(
              'Motor memiliki fleksibilitas lebih tinggi '
              'saat menghadapi kepadatan lalu lintas. '
              'Namun, waktu perjalanan tetap dapat berubah '
              'sesuai kondisi jalan.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),

          // RUTE YANG DILALUI
          itemInformasi(
            judul: 'Rute yang dilalui',
            isiCustom: const Text(
              'Perjalanan menggunakan motor pribadi '
              'dari lokasi keberangkatan menuju lokasi tujuan '
              'melalui jalur jalan raya yang tersedia.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ),

          // KELEBIHAN DAN KEKURANGAN
          itemInformasi(
            judul: 'Kelebihan & Kekurangan',
            warnaHijau: true,
            isiCustom: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Kelebihan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  '• Lebih praktis untuk perjalanan sehari-hari\n'
                  '• Lebih mudah melewati jalan yang padat\n'
                  '• Biaya bahan bakar relatif lebih hemat '
                  'dibandingkan mobil',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Kekurangan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  '• Kapasitas penumpang terbatas\n'
                  '• Terpengaruh kondisi cuaca\n'
                  '• Risiko keselamatan lebih tinggi '
                  'jika tidak berhati-hati',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // 6. BAGIAN BAWAH
  // ==========================================================

  Widget bottomBar() {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.crop_free,
            color: Colors.blue,
            size: 23,
          ),
          Icon(
            Icons.crop_free,
            color: Colors.blue,
            size: 23,
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

                      // FOTO MOTOR
                      gambarMotor(),

                      // NAMA KENDARAAN
                      namaKendaraan(),

                      // DAFTAR INFORMASI
                      daftarInformasi(),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // BAGIAN BAWAH
        bottomNavigationBar: bottomBar(),
      ),
    );
  }
}
