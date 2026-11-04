import 'package:flutter/material.dart';
import '../pages/verification_page.dart';

// ============================================================
// 1. HALAMAN UTAMA PENGATURAN
//    Menampilkan menu: Nomor HP, Email, Kata Sandi, Hapus Akun
// ============================================================
class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  static const Color hijau = Color(0xFF176D5B);

  void bukaHalaman(BuildContext context, String judul) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HalamanPengaturanDetail(judul: judul),
      ),
    );
  }


  // DIALOG HAPUS AKUN
  void konfirmasiHapusAkun(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.40),
      builder: (dialogContext) {
        return DialogHapusAkun(
          onHapus: () {
            Navigator.pop(dialogContext);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Fitur hapus akun belum diaktifkan',
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ------------------------------------------------------------
  // KOMPONEN BARIS MENU PENGATURAN (dipakai oleh semua menu)
  // ------------------------------------------------------------
  Widget itemPengaturan({
    required IconData ikon,
    required String judul,
    required VoidCallback aksi,
  }) {
    return InkWell(
      onTap: aksi,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFCCCCCC),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 26,
              child: Icon(
                ikon,
                size: 23,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Text(
                judul,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 32,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }


  // ------------------------------------------------------------
  // TAMPILAN MENU PENGATURAN
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER PENGATURAN
            // Menggunakan Container agar tinggi dan posisi judul mudah disesuaikan.
            Container(
              height: 63,
              width: double.infinity,
              color: hijau,
              child: Row(
                children: [
                  const SizedBox(width: 2),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // DAFTAR MENU PENGATURAN
            const SizedBox(height: 20),

            // MENU 1: UBAH NOMOR HP
            itemPengaturan(
              ikon: Icons.phone_outlined,
              judul: 'Ubah Nomor Hp',
              aksi: () => bukaHalaman(context, 'Ubah Nomor Hp'),
            ),
            const SizedBox(height: 12),

            // MENU 2: UBAH EMAIL
            itemPengaturan(
              ikon: Icons.mail_outline,
              judul: 'Ubah Email',
              aksi: () => bukaHalaman(context, 'Ubah Email'),
            ),
            const SizedBox(height: 12),

            // MENU 3: UBAH KATA SANDI
            itemPengaturan(
              ikon: Icons.key_outlined,
              judul: 'Ubah Kata Sandi',
              aksi: () => bukaHalaman(context, 'Ubah Kata Sandi'),
            ),
            const SizedBox(height: 12),

            // MENU 4: HAPUS AKUN
            itemPengaturan(
              ikon: Icons.delete_outline,
              judul: 'Hapus Akun',
              aksi: () => konfirmasiHapusAkun(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN UBAH NOMOR HP DAN UBAH EMAIL
// ============================================================

class HalamanPengaturanDetail extends StatelessWidget {
  final String judul;

  const HalamanPengaturanDetail({
    super.key,
    required this.judul,
  });

  // ==========================================================
  // 1. PENGATURAN WARNA
  // ==========================================================

  static const Color hijau = Color(0xFF176D5B);
  static const Color latarKotak = Color(0xFFF7F7F7);
  static const Color garisKotak = Color(0xFFCCCCCC);
  static const Color warnaIkon = Color(0xFF777777);
  static const Color warnaHint = Color(0xFF858585);

  // ==========================================================
  // 2. PENGATURAN UKURAN TEKS
  // ==========================================================

  static const double ukuranJudulHeader = 18;
  static const double ukuranLabel = 14;
  static const double ukuranHint = 14;
  static const double ukuranTeksInput = 18;
  static const double ukuranIkon = 25;
  static const double ukuranTombol = 15;

  // ==========================================================
  // 3. PENGATURAN TINGGI KOMPONEN
  // ==========================================================

  static const double tinggiHeader = 63;
  static const double tinggiKotakInput = 60;
  static const double tinggiTombol = 50;

  // ==========================================================
  // 4. PENGATURAN JARAK
  // ==========================================================

  // Jarak isi halaman dari tepi kiri dan kanan
  static const double paddingHorizontal = 13;

  // Jarak isi halaman dari header
  static const double jarakAtasHalaman = 32;

  // Jarak label ke kotak input
  static const double jarakLabelKeKotak = 8;

  // Jarak kotak input ke tombol KIRIM
  static const double jarakKotakKeTombol = 80;

  // Jarak ikon di dalam kotak
  static const double lebarAreaIkon = 48;

  // ==========================================================
  // 5. PENGATURAN BENTUK KOTAK DAN TOMBOL
  // ==========================================================

  static const double radiusKotak = 10;
  static const double radiusTombol = 4;

  // ==========================================================
  // 6. MEMBUAT KOTAK INPUT NOMOR HP / EMAIL
  // ==========================================================

  Widget kotakInput({
    required bool halamanNomorHp,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        width: double.infinity,
        height: tinggiKotakInput,
        child: TextField(
          keyboardType: halamanNomorHp
              ? TextInputType.phone
              : TextInputType.emailAddress,

          // Ukuran teks ketika pengguna mengetik
          style: const TextStyle(
            fontSize: ukuranTeksInput,
            color: Colors.black87,
          ),

          decoration: InputDecoration(
            // Teks petunjuk di dalam kotak
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: ukuranHint,
              color: warnaHint,
              fontStyle: FontStyle.italic,
            ),

            // Warna latar kotak
            filled: true,
            fillColor: latarKotak,

            // Jarak teks dari tepi kotak
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),

            // Ikon di sebelah kiri
            prefixIcon: Icon(
              halamanNomorHp
                  ? Icons.phone
                  : Icons.email,
              size: ukuranIkon,
              color: warnaIkon,
            ),

            prefixIconConstraints: const BoxConstraints(
              minWidth: lebarAreaIkon,
              minHeight: 43,
            ),

            // Garis kotak
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusKotak),
              borderSide: const BorderSide(
                color: garisKotak,
                width: 1,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusKotak),
              borderSide: const BorderSide(
                color: garisKotak,
                width: 1,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusKotak),
              borderSide: const BorderSide(
                color: garisKotak,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 7. MEMBUAT TOMBOL KIRIM
  // ==========================================================

  Widget tombolKirim({
    required BuildContext context,
    required bool halamanNomorHp,
  }) {
    return SizedBox(
      width: double.infinity,
      height: tinggiTombol,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VerificationPage(
                lewatHp: halamanNomorHp,
                untukPengaturan: true,
              ),
            ),
          );
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: hijau,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusTombol),
          ),
        ),

        child: const Text(
          'KIRIM',
          style: TextStyle(
            fontSize: ukuranTombol,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 8. TAMPILAN UTAMA HALAMAN
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    // Menentukan halaman yang dibuka
    if (judul == 'Ubah Kata Sandi') {
      return const HalamanUbahKataSandi();
    }

    final bool halamanNomorHp =
        judul.toLowerCase().contains('nomor');

    // Label di atas kotak
    final String label = halamanNomorHp
        ? 'Masukan Nomor Baru'
        : 'Masukan Email Baru';

    // Teks petunjuk di dalam kotak
    final String hint = halamanNomorHp
        ? 'Nomor Hp'
        : 'Email';

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------------------------
            // HEADER HIJAU
            // --------------------------------------------------

            Container(
              height: tinggiHeader,
              width: double.infinity,
              color: hijau,

              child: Row(
                children: [
                  // Tombol kembali
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),

                  const SizedBox(width: 2),

                  // Judul halaman
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: ukuranJudulHeader,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // --------------------------------------------------
            // ISI HALAMAN
            // --------------------------------------------------

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  paddingHorizontal,
                  jarakAtasHalaman,
                  paddingHorizontal,
                  20,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label di atas kotak
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        bottom: jarakLabelKeKotak,
                      ),

                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: ukuranLabel,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Kotak input nomor HP atau email
                    kotakInput(
                      halamanNomorHp: halamanNomorHp,
                      hint: hint,
                    ),

                    // Jarak sebelum tombol KIRIM
                    const SizedBox(
                      height: jarakKotakKeTombol,
                    ),

                    // Tombol KIRIM
                    tombolKirim(
                      context: context,
                      halamanNomorHp: halamanNomorHp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// ============================================================
// 3. HALAMAN UBAH KATA SANDI
// ============================================================

class HalamanUbahKataSandi extends StatefulWidget {
  const HalamanUbahKataSandi({super.key});

  @override
  State<HalamanUbahKataSandi> createState() =>
      _HalamanUbahKataSandiState();
}

class _HalamanUbahKataSandiState
    extends State<HalamanUbahKataSandi> {

  // ==========================================================
  // 1. PENGATURAN WARNA
  // ==========================================================

  static const Color hijau = Color(0xFF176D5B);
  static const Color latarKotak = Color(0xFFF7F7F7);
  static const Color garisKotak = Color(0xFFCCCCCC);
  static const Color warnaHint = Color(0xFF858585);
  static const Color warnaLupa = Color(0xFF00B4D8);


  // ==========================================================
  // 2. PENGATURAN UKURAN TEKS
  // ==========================================================

  static const double ukuranJudul = 19;
  static const double ukuranLabel = 15;
  static const double ukuranHint = 15;
  static const double ukuranTeksInput = 15;
  static const double ukuranLupa = 14;
  static const double ukuranTombol = 17;


  // ==========================================================
  // 3. PENGATURAN UKURAN KOMPONEN
  // ==========================================================

  static const double tinggiHeader = 63;
  static const double tinggiKotak = 53;
  static const double tinggiTombol = 45;

  static const double radiusKotak = 10;
  static const double radiusTombol = 4;

  // ==========================================================
  // 4. PENGATURAN JARAK
  // ==========================================================

  static const double paddingHorizontal = 15;
  static const double paddingAtas = 34;

  // Jarak label dengan kotak
  static const double jarakLabelKotak = 7;

  // Jarak kotak kata sandi lama dengan tulisan lupa sandi
  static const double jarakKotakLupa = 15;

  // Jarak tulisan lupa sandi dengan label kata sandi baru
  static const double jarakLupaKolomBaru = 17;

  // Jarak kata sandi baru dengan konfirmasi
  static const double jarakKolomBaruKonfirmasi = 17;

  // Jarak konfirmasi dengan tombol UBAH
  static const double jarakKonfirmasiTombol = 67;


  // ==========================================================
  // 5. CONTROLLER DAN TAMPILAN KATA SANDI
  // ==========================================================

  final TextEditingController sandiLamaController =
      TextEditingController();

  final TextEditingController sandiBaruController =
      TextEditingController();

  final TextEditingController konfirmasiController =
      TextEditingController();

  bool tampilSandiLama = false;
  bool tampilSandiBaru = false;
  bool tampilKonfirmasi = false;


  @override
  void dispose() {
    sandiLamaController.dispose();
    sandiBaruController.dispose();
    konfirmasiController.dispose();
    super.dispose();
  }


  // ==========================================================
  // 6. KOMPONEN INPUT KATA SANDI
  // ==========================================================

  Widget inputSandi({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool tampil,
    required VoidCallback ubahTampilan,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // LABEL
        Text(
          label,
          style: const TextStyle(
            fontSize: ukuranLabel,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        SizedBox(height: jarakLabelKotak),

        // KOTAK INPUT
        SizedBox(
          width: double.infinity,
          height: tinggiKotak,
          child: TextField(
            controller: controller,
            obscureText: !tampil,

            style: const TextStyle(
              fontSize: ukuranTeksInput,
              color: Colors.black,
            ),

            decoration: InputDecoration(
              // TEKS ABU-ABU DALAM KOTAK
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 18,
                color: warnaHint,
                fontStyle: FontStyle.italic,
              ),

              filled: true,
              fillColor: latarKotak,

              // JARAK ISI DARI TEPI KOTAK
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),

              // IKON GEMBOK KIRI
              prefixIcon: const Icon(
                Icons.lock,
                size: 16,
                color: Color(0xFF777777),
              ),

              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),

              // IKON MATA KANAN
              suffixIcon: IconButton(
                onPressed: ubahTampilan,
                padding: EdgeInsets.zero,
                icon: Icon(
                  tampil
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 16,
                  color: const Color(0xFF888888),
                ),
              ),

              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),

              // GARIS KOTAK NORMAL
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  radiusKotak,
                ),
                borderSide: const BorderSide(
                  color: garisKotak,
                  width: 1,
                ),
              ),

              // GARIS KOTAK SAAT DIPILIH
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  radiusKotak,
                ),
                borderSide: const BorderSide(
                  color: hijau,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  // ==========================================================
  // 7. TOMBOL UBAH
  // ==========================================================

  Widget tombolUbah() {
    return SizedBox(
      width: double.infinity,
      height: tinggiTombol,
      child: ElevatedButton(
        onPressed: () {

          // CEK KOLOM KOSONG
          if (sandiLamaController.text.isEmpty ||
              sandiBaruController.text.isEmpty ||
              konfirmasiController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Semua kolom kata sandi wajib diisi',
                ),
              ),
            );
            return;
          }

          // CEK KECOCOKAN KONFIRMASI
          if (sandiBaruController.text !=
              konfirmasiController.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Konfirmasi kata sandi tidak cocok',
                ),
              ),
            );
            return;
          }

          // FITUR BELUM TERHUBUNG KE SISTEM AKUN
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Fitur perubahan kata sandi belum diaktifkan',
              ),
            ),
          );
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: hijau,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              radiusTombol,
            ),
          ),
        ),

        child: const Text(
          'UBAH',
          style: TextStyle(
            fontSize: ukuranTombol,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }


  // ==========================================================
  // 8. TAMPILAN HALAMAN UTAMA
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            // HEADER HIJAU
            Container(
              width: double.infinity,
              height: tinggiHeader,
              color: hijau,

              child: Row(
                children: [

                  // TOMBOL KEMBALI
                  SizedBox(
                    width: 43,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 21,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 2),

                  // JUDUL
                  const Text(
                    'Ubah Kata Sandi',
                    style: TextStyle(
                      fontSize: ukuranJudul,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),


            // ISI HALAMAN
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  paddingHorizontal,
                  paddingAtas,
                  paddingHorizontal,
                  20,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ------------------------------------------
                    // KATA SANDI LAMA
                    // ------------------------------------------

                    inputSandi(
                      label: 'Kata Sandi Lama',
                      hint: 'Kata Sandi Lama',
                      controller: sandiLamaController,
                      tampil: tampilSandiLama,
                      ubahTampilan: () {
                        setState(() {
                          tampilSandiLama = !tampilSandiLama;
                        });
                      },
                    ),

                    SizedBox(height: jarakKotakLupa),

                    // LUPA KATA SANDI
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Silakan gunakan fitur lupa kata sandi',
                              ),
                            ),
                          );
                        },

                        child: const Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            fontSize: ukuranLupa,
                            color: warnaLupa,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: jarakLupaKolomBaru),


                    // ------------------------------------------
                    // KATA SANDI BARU
                    // ------------------------------------------

                    inputSandi(
                      label: 'Kata Sandi Baru',
                      hint: 'Kata Sandi Baru',
                      controller: sandiBaruController,
                      tampil: tampilSandiBaru,
                      ubahTampilan: () {
                        setState(() {
                          tampilSandiBaru = !tampilSandiBaru;
                        });
                      },
                    ),

                    SizedBox(
                      height: jarakKolomBaruKonfirmasi,
                    ),


                    // ------------------------------------------
                    // KONFIRMASI KATA SANDI
                    // ------------------------------------------

                    inputSandi(
                      label: 'Konfirmasi Kata Sandi',
                      hint: 'Konfirmasi Kata Sandi',
                      controller: konfirmasiController,
                      tampil: tampilKonfirmasi,
                      ubahTampilan: () {
                        setState(() {
                          tampilKonfirmasi = !tampilKonfirmasi;
                        });
                      },
                    ),

                    SizedBox(
                      height: jarakKonfirmasiTombol,
                    ),


                    // ------------------------------------------
                    // TOMBOL UBAH
                    // ------------------------------------------

                    tombolUbah(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// DIALOG HAPUS AKUN
// ============================================================

class DialogHapusAkun extends StatefulWidget {
  final VoidCallback onHapus;

  const DialogHapusAkun({
    super.key,
    required this.onHapus,
  });

  @override
  State<DialogHapusAkun> createState() =>
      _DialogHapusAkunState();
}

class _DialogHapusAkunState extends State<DialogHapusAkun> {
  // ==========================================================
  // 1. PENGATURAN WARNA
  // ==========================================================

  static const Color merah = Color(0xFFFF2525);
  static const Color merahMuda = Color(0xFFFFE1E1);
  static const Color warnaTeks = Color(0xFF333333);
  static const Color warnaIkon = Color(0xFF374151);
  
  // ==========================================================
  // 2. PENGATURAN UKURAN
  // ==========================================================

  // UKURAN DIALOG
  static const double lebarDialog = 310;
  static const double radiusDialog = 12;

  // UKURAN TEKS
  static const double ukuranJudul = 21;
  static const double ukuranLabel = 12;
  static const double ukuranHint = 10;
  static const double ukuranPeringatan = 9;

  // UKURAN KOMPONEN
  static const double tinggiInput = 40;
  static const double tinggiPeringatan = 45;
  static const double tinggiTombol = 35;

  // JARAK ANTARBAGIAN
  static const double jarakJudulInput = 17;
  static const double jarakInputPeringatan = 17;
  static const double jarakPeringatanTombol = 39;

  // JARAK ISI KOTAK
  static const double paddingInputHorizontal = 15;
  static const double paddingInputVertikal = 10;
  static const double paddingPeringatanHorizontal = 15;

  // UKURAN IKON
  static const double ukuranIkonPeringatan = 20;
  static const double ukuranIkonTutup = 11;
  static const double ukuranIkonMata = 23;


  // ==========================================================
  // 3. CONTROLLER KATA SANDI
  // ==========================================================

  final TextEditingController sandiController =
      TextEditingController();

  bool tampilSandi = false;

  @override
  void dispose() {
    sandiController.dispose();
    super.dispose();
  }

 // ==========================================================
  // 4. KOTAK INPUT KATA SANDI
  // ==========================================================
  
  Widget kotakKataSandi() {
    return SizedBox(
      width: double.infinity,
      height: tinggiInput,
      child: TextField(
        controller: sandiController,
        obscureText: !tampilSandi,
        style: const TextStyle(
          fontSize: 14,
          color: warnaTeks,
        ),
        decoration: InputDecoration(
          labelText: 'Kata Sandi',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontSize: ukuranLabel,
            color: Colors.black,
          ),
          hintText: 'Masukkan Kata Sandi',
          hintStyle: const TextStyle(
            fontSize: ukuranHint,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: paddingInputHorizontal,
            vertical: paddingInputVertikal,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                tampilSandi = !tampilSandi;
              });
            },
            padding: EdgeInsets.zero,
            icon: Icon(
              tampilSandi
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: warnaIkon,
              size: ukuranIkonMata,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 30,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: merah, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: merah, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: merah, width: 1),
          ),
        ),
      ),
    );
  }


  // ==========================================================
  // 5. KOTAK PERINGATAN
  // ==========================================================

  Widget kotakPeringatan() {
  return Container(
    width: double.infinity,
    height: tinggiPeringatan,
    padding: const EdgeInsets.symmetric(
      horizontal: paddingPeringatanHorizontal,
    ),
    color: merahMuda,
    child: Row(
      children: [
        const Icon(
          Icons.error_outline,
          size: ukuranIkonPeringatan,
          color: merah,
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'Anda akan menghapus akun anda. Tindakan ini '
            'tidak dapat dibatalkan. Semua data akan hilang.',
            style: TextStyle(
              fontSize: ukuranPeringatan,
              color: warnaTeks,
            ),
          ),
        ),
        const SizedBox(width: 3),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.close,
            size: ukuranIkonTutup,
            color: Color(0xFF666666),
          ),
        ),
      ],
    ),
  );
}

  // ==========================================================
  // 6. TOMBOL HAPUS DAN BATAL
  // ==========================================================

  Widget tombolAksi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: tinggiTombol,
          child: ElevatedButton(
            onPressed: widget.onHapus,
            style: ElevatedButton.styleFrom(
              backgroundColor: merah,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: const Text(
              'Hapus',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 25),
        SizedBox(
          height: tinggiTombol,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: warnaTeks,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // 7. TAMPILAN DIALOG UTAMA
  // ==========================================================

@override
Widget build(BuildContext context) {
  // UKURAN KOTAK PUTIH
  const double lebarKotakPutih = 380;
  const double tinggiKotakPutih = 270;

  // POSISI KOTAK PUTIH
  const double geserHorizontal = 0;
  const double geserVertikal = -70;

  // JARAK ISI DARI TEPI KOTAK PUTIH
  const double jarakIsiKiri = 32;
  const double jarakIsiAtas = 20;
  const double jarakIsiKanan = 32;
  const double jarakIsiBawah = 20;

  return Transform.translate(
    offset: const Offset(
      geserHorizontal,
      geserVertikal,
    ),
    child: Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusDialog),
      ),
      child: SizedBox(
        width: lebarKotakPutih,
        height: tinggiKotakPutih,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            jarakIsiKiri,
            jarakIsiAtas,
            jarakIsiKanan,
            jarakIsiBawah,
          ),
          child: Column(
            children: [
              const Text(
                'HAPUS AKUN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ukuranJudul,
                  fontWeight: FontWeight.w900,
                  color: warnaTeks,
                ),
              ),

              const SizedBox(height: jarakJudulInput),

              kotakKataSandi(),

              const SizedBox(height: jarakInputPeringatan),

              kotakPeringatan(),

              const SizedBox(height: jarakPeringatanTombol),

              tombolAksi(),
            ],
          ),
        ),
      ),
    ),
  );
}
}