import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/keberangkatan_page.dart';

class DetailTransjakartaPage extends StatelessWidget {
  const DetailTransjakartaPage({super.key});
  static const Color hijau = Color(0xFF1B6B5B);

  // ==========================================================
  // PENGATURAN TAMPILAN
  // ==========================================================

  static const double tinggiGambarTransum = 180;

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
            'Transportasi Umum',
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
          'lib/images/image 12.png',
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
                'Gambar TransJakarta tidak ditemukan',
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
              'Rekomendasi',
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
  // 3. NAMA TRANSPORTASI
  // ==========================================================

  Widget namaKendaraan() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 17, 16, 25),
      child: Text(
        'TRANSJAKARTA',
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
    required String isi,
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
          initiallyExpanded: true,
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
  // 5. DAFTAR INFORMASI TRANSPORTASI UMUM
  // ==========================================================

  Widget daftarInformasi(BuildContext context) {
    const TextStyle teksIsi = TextStyle(
      fontSize: 13,
      height: 1.4,
      color: Colors.black,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [

          // BIAYA
          itemInformasi(
            judul: 'Biaya',
            isi: '',
            tinggiJudul: 35,
            paddingBawah: 10,
            isiCustom: const Text(
              'Rp 3.500 (tarif flat TransJakarta)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                height: 1.1,
              ),
            ),
          ),

          // ESTIMASI
          itemInformasi(
            judul: 'Estimasi',
            isi: '',
            isiCustom: const Text(
              '±60-75 menit (tergantung kondisi lalu lintas '
              'dan waktu tunggu)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.45,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
          ),

          // KEBERANGKATAN
          itemInformasi(
            judul: 'Keberangkatan',
            isi: '',
            isiCustom: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Perkiraan keberangkatan dari Halte Duri Kepa:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const Text(
                  'Pukul 18.00 WIB',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 3),

                const Text(
                  'Bisa berubah tergantung kepadatan lalu lintas',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 17),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const KeberangkatanPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Selengkapnya',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // INFORMASI KEPADATAN
          itemInformasi(
            judul: 'Informasi Kepadatan',
            isi: '',
            isiCustom: Text.rich(
              const TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Kepadatan di Halte SSSSS tergolong ',
                  ),
                  TextSpan(
                    text: 'Rendah',
                    style: TextStyle(color: Colors.green),
                  ),
                  TextSpan(text: '/'),
                  TextSpan(
                    text: 'Sedang',
                    style: TextStyle(color: Colors.orange),
                  ),
                  TextSpan(text: '/'),
                  TextSpan(
                    text: 'Tinggi',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),

          // RUTE YANG DILALUI
          itemInformasi(
            judul: 'Rute yang dilalui',
            isi: '',
            isiCustom: const Text(
              'Dari Kedoya Selatan, naik mikrotrans atau ojek\n'
              'online menuju ke halte Kedoya Green Garden\n'
              '⋮\n'
              'Naik Koridor 8 TransJakarta menuju Halte\n'
              'Harmoni\n'
              '⋮\n'
              'Transit di Halte Harmoni, lalu naik ke Koridor 1 ke\n'
              'Halte Monas',
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
            isi: '',
            warnaHijau: true,

            isiCustom: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  '• Biaya Terjangkau\n'
                  '• Jalur khusus bus mengurangi risiko\n'
                  '  terjebak macet',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Kekurangan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  '• Perlu transit dan menunggu bus di setiap\n'
                  '  halte\n'
                  '• Kepadatan penumpang pada jam sibuk',
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
                      // FOTO TRANSJAKARTA
                      gambarTransportasiUmum(),

                      // NAMA KENDARAAN
                      namaKendaraan(),

                      // DAFTAR INFORMASI
                      daftarInformasi(context),

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
