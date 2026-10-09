import 'dart:async';
import 'package:flutter/material.dart';

// ============ ALAMAT GAMBAR (ubah di sini kalau nama file berbeda) ============
const imgLogoHijau = 'lib/images/logo_ecowalk_hijau.png';
const imgLogoPutih = 'lib/images/logo_ecowalk_putih.png';
const imgGoogle = 'lib/images/google.png';
const imgFoto = 'lib/images/pic.jpg';
const imgIkonHp = 'lib/images/ikon_hp.png';
const imgIkonLonceng = 'lib/images/ikon_lonceng.png';

// ============ WARNA ============
const hijau = Color(0xFF1D6556);
const biru = Color(0xFF00B4D8);
const abu = Color(0xFFF6F6F6);

class Akun {
  final String nama;
  final String email;
  final String hp;
  String sandi;
  Akun({
    required this.nama,
    required this.email,
    required this.hp,
    required this.sandi,
  });
}

final List<Akun> daftarAkun = [];
Akun? akunAktif;

// ============ TITIK AWAL APLIKASI ============
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EcoWalk',
      debugShowCheckedModeBanner: false,
      home: SplashPage(), // mulai dari splash, lalu otomatis ke Login
    );
  }
}

// ============ WIDGET BANTUAN (dipakai berulang) ============

// Logo ECOWALK. [lebar] dalam piksel.
// isi: bagian gambar yang dipakai (1.0 = semua, 0.8 = ruang kosong kiri-kanan
// dipotong). Kalau gambar gagal dibaca, tampil pengganti dan pesan di terminal.
Widget logo(String path, double lebar, Color warna, {double isi = 1.0}) {
  return ClipRect(
    child: Align(
      widthFactor: isi,
      child: Image.asset(
        path,
        width: lebar,
        errorBuilder: (context, error, stack) {
          debugPrint('ERROR GAMBAR: $error');
          final gaya = TextStyle(
            color: warna,
            fontSize: lebar / 6,
            fontWeight: FontWeight.w900,
          );
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ECOWA', style: gaya),
              Icon(Icons.directions_run, color: warna, size: lebar / 5),
              Text('K', style: gaya),
            ],
          );
        },
      ),
    ),
  );
}

// Kolom isian. Kalau sandi: true, ikon mata bisa ditekan.
// errorText = tulisan merah di bawah kolom (null = tidak ada).
class KolomIsian extends StatefulWidget {
  final String hint;
  final IconData? ikon;
  final bool sandi;
  final bool garis; // true = garis bawah, false = kotak abu
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const KolomIsian({
    super.key,
    required this.hint,
    required this.ikon,
    this.sandi = false,
    this.garis = false,
    this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  State<KolomIsian> createState() => _KolomIsianState();
}

class _KolomIsianState extends State<KolomIsian> {
  late bool tersembunyi;

  @override
  void initState() {
    super.initState();
    tersembunyi = widget.sandi;
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder border = widget.garis
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400))
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          );

    final InputBorder borderError = widget.garis
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400))
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red.shade400),
          );

    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: tersembunyi,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey.shade600),
        errorText: widget.errorText,
        errorStyle: TextStyle(fontSize: 10, color: Colors.red.shade600),
        prefixIcon: widget.ikon == null
            ? null
            : Icon(widget.ikon, size: 18, color: Colors.grey.shade700),
        // ikon mata: bisa ditekan
        suffixIcon: widget.sandi
            ? IconButton(
                onPressed: () => setState(() => tersembunyi = !tersembunyi),
                icon: Icon(
                  tersembunyi ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: Colors.grey.shade700,
                ),
              )
            : null,
        filled: !widget.garis,
        fillColor: abu,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border,
        enabledBorder: border,
        errorBorder: borderError,
        focusedErrorBorder: borderError,
        focusedBorder: widget.garis
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: hijau))
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: hijau),
              ),
      ),
    );
  }
}

// Kolom isian (kotak abu)
Widget kolom(
  String hint,
  IconData ikon, {
  bool sandi = false,
  TextEditingController? controller,
  String? errorText,
  ValueChanged<String>? onChanged,
}) {
  return KolomIsian(
    hint: hint,
    ikon: ikon,
    sandi: sandi,
    controller: controller,
    errorText: errorText,
    onChanged: onChanged,
  );
}

// Kolom isian (garis bawah)
Widget kolomGaris(String hint, IconData? ikon, {bool sandi = false}) {
  return KolomIsian(hint: hint, ikon: ikon, sandi: sandi, garis: true);
}

// Tombol hijau. [berat] = tebal tulisan (default bold).
Widget tombol(String teks, VoidCallback aksi,
    {FontWeight berat = FontWeight.bold}) {
  return SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton(
      onPressed: aksi,
      style: ElevatedButton.styleFrom(
        backgroundColor: hijau,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(teks, style: TextStyle(fontWeight: berat)),
    ),
  );
}

// Judul kecil + logo di atas halaman
// kiri: true = rata kiri sejajar tepi logo (Registrasi)
// jarak = jarak antar huruf, lebarLogo = lebar logo, ukuranTeks = besar tulisan
Widget judul(String teks,
    {bool kiri = false,
    double jarak = 3,
    double lebarLogo = 200,
    double ukuranTeks = 20,
    bool samaLebar = false,
    double tebal = 0.3,
    double isiLogo = 1.0}) {
  final tulisan = Text(
    teks,
    style: TextStyle(
      color: hijau,
      fontSize: ukuranTeks,
      fontWeight: FontWeight.w900,
      letterSpacing: jarak,
      shadows: [
        Shadow(color: hijau, offset: Offset(tebal, 0)),
        Shadow(color: hijau, offset: Offset(-tebal, 0)),
        Shadow(color: hijau, offset: Offset(0, tebal)),
        Shadow(color: hijau, offset: Offset(0, -tebal)),
      ],
    ),
  );

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment:
        kiri ? CrossAxisAlignment.start : CrossAxisAlignment.center,
    children: [
      samaLebar
          ? SizedBox(
              width: lebarLogo * isiLogo,
              child: FittedBox(fit: BoxFit.fitWidth, child: tulisan),
            )
          : tulisan,
      const SizedBox(height: 4),
      logo(imgLogoHijau, lebarLogo, hijau, isi: isiLogo),
    ],
  );
}

// Bentuk header miring
class PotongMiring extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height * 0.55)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Header abu kehijauan (Verifikasi, Lupa Sandi, Ubah Sandi)
Widget header([String sub = '']) {
  return ClipPath(
    clipper: PotongMiring(),
    child: Container(
      width: double.infinity,
      height: 220,
      color: const Color(0xFFDAE6E3),
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo(imgLogoHijau, 200, hijau),
          if (sub != '')
            Text(sub,
                style: const TextStyle(
                    color: hijau, fontSize: 14, fontWeight: FontWeight.w800)),
        ],
      ),
    ),
  );
}

// ============ 1. SPLASH ============
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // setelah 2 detik pindah ke Login
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hijau,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            logo(imgLogoPutih, 220, Colors.white),
            const SizedBox(height: 8),
            const Text('"Bandingkan, pilih, liburan tanpa ragu !"',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ============ 2. LOGIN ============
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCtrl = TextEditingController();
  final sandiCtrl = TextEditingController();
  String? errUser; // tulisan merah di bawah kolom (null = tidak ada)
  String? errSandi;

  @override
  void dispose() {
    userCtrl.dispose();
    sandiCtrl.dispose();
    super.dispose();
  }

  // Dicek dulu. Kalau ada yang kosong, tidak pindah halaman.
void masuk() {
  // Cek apakah kolom sudah diisi
  setState(() {
    errUser = userCtrl.text.trim().isEmpty
        ? 'Nama pengguna wajib diisi'
        : null;

    errSandi = sandiCtrl.text.isEmpty
        ? 'Kata sandi wajib diisi'
        : null;
  });

  // Jika masih ada kolom kosong, berhenti
  if (errUser != null || errSandi != null) {
    return;
  }

  // Ambil nama pengguna atau email
  final inputUser = userCtrl.text.trim().toLowerCase();

  // Cari akun yang sesuai
  final cocok = daftarAkun.where((a) =>
      (a.email.toLowerCase() == inputUser ||
          a.nama.toLowerCase() == inputUser ||
          a.hp == userCtrl.text.trim()) &&
      a.sandi == sandiCtrl.text);

  // Jika akun tidak ditemukan
  if (cocok.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun atau kata sandi salah'),
      ),
    );
    return;
  }

  // Simpan akun yang berhasil login
  akunAktif = cocok.first;

  // Pindah ke halaman profil
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const ProfilePage(),
    ),
  );
}


  // label kecil di atas kolom
  Widget label(String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(teks, style: const TextStyle(fontSize: 11)),
    );
  }

  // garis yang memudar di ujung (kiri/kanan "Atau")
  Widget garisPudar(bool kiri) {
    return Expanded(
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: kiri
                ? [Colors.transparent, Colors.grey.shade400]
                : [Colors.grey.shade400, Colors.transparent],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: judul('MASUK')),
                const SizedBox(height: 48),

                label('Nama Pengguna'),
                kolom(
                  '',
                  Icons.person,
                  controller: userCtrl,
                  errorText: errUser,
                  onChanged: (_) {
                    if (errUser != null) setState(() => errUser = null);
                  },
                ),
                const SizedBox(height: 16),

                label('Kata Sandi'),
                kolom(
                  '',
                  Icons.lock,
                  sandi: true, // mata bisa ditekan
                  controller: sandiCtrl,
                  errorText: errSandi,
                  onChanged: (_) {
                    if (errSandi != null) setState(() => errSandi = null);
                  },
                ),
                const SizedBox(height: 40),

                // Tombol MASUK (tulisan lebih tebal)
                tombol('MASUK', masuk, berat: FontWeight.w900),
                const SizedBox(height: 14),

                // Lupa Kata Sandi?
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPage()),
                      );
                    },
                    child: const Text('Lupa Kata Sandi?',
                        style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: biru)),
                  ),
                ),
                const SizedBox(height: 22),

                // Garis "Atau"
                Row(
                  children: [
                    garisPudar(true),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text('Atau', style: TextStyle(fontSize: 9)),
                    ),
                    garisPudar(false),
                  ],
                ),
                const SizedBox(height: 26),

                // Tombol Google (putih + bayangan)
                Material(
                  color: Colors.white,
                  elevation: 3,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {},
                    child: SizedBox(
                      height: 44,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            imgGoogle,
                            width: 18,
                            height: 18,
                            errorBuilder: (context, error, stack) {
                              debugPrint('ERROR GAMBAR: $error');
                              return const Text('G',
                                  style: TextStyle(
                                      color: Color(0xFF4285F4),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900));
                            },
                          ),
                          const SizedBox(width: 10),
                          const Text('Lanjutkan dengan Google',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Pindah ke Registrasi
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterPage()),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 11),
                        children: [
                          TextSpan(text: 'Tidak punya akun? '),
                          TextSpan(
                              text: 'Daftar disini',
                              style: TextStyle(color: biru)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============ 3. REGISTRASI ============
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final hpCtrl = TextEditingController();
  final sandiCtrl = TextEditingController();
  final konfirmCtrl = TextEditingController();

  bool setuju = false; // status checkbox

  // tulisan merah di bawah kolom (null = tidak ada)
  String? errNama, errEmail, errHp, errSandi, errKonfirm, errSetuju;

  @override
  void dispose() {
    namaCtrl.dispose();
    emailCtrl.dispose();
    hpCtrl.dispose();
    sandiCtrl.dispose();
    konfirmCtrl.dispose();
    super.dispose();
  }

  // Dicek dulu. Kalau ada yang belum benar, tidak pindah ke Verifikasi.
  void buatAkun() {
    final nama = namaCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final hp = hpCtrl.text.trim();
    final sandi = sandiCtrl.text;
    final konfirm = konfirmCtrl.text;
    final emailBenar = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);

    setState(() {
      errNama = nama.isEmpty ? 'Nama pengguna wajib diisi' : null;

      if (email.isEmpty) {
        errEmail = 'Email wajib diisi';
      } else if (!emailBenar) {
        errEmail = 'Format email tidak valid';
      } else {
        errEmail = null;
      }

      if (hp.isEmpty) {
        errHp = 'Nomor HP wajib diisi';
      } else if (hp.length < 10) {
        errHp = 'Nomor HP minimal 10 digit';
      } else {
        errHp = null;
      }

      if (sandi.isEmpty) {
        errSandi = 'Kata sandi wajib diisi';
      } else if (sandi.length < 6) {
        errSandi = 'Kata sandi minimal 6 karakter';
      } else {
        errSandi = null;
      }

      if (konfirm.isEmpty) {
        errKonfirm = 'Konfirmasi kata sandi wajib diisi';
      } else if (konfirm != sandi) {
        errKonfirm = 'Kata sandi tidak sama';
      } else {
        errKonfirm = null;
      }

      errSetuju = setuju ? null : 'Centang persetujuan terlebih dahulu';
    });

    final adaError = errNama != null ||
        errEmail != null ||
        errHp != null ||
        errSandi != null ||
        errKonfirm != null ||
        errSetuju != null;
    if (adaError) return; // belum lengkap, tetap di halaman ini

    final emailBaru = emailCtrl.text.trim().toLowerCase();
    if (daftarAkun.any((a) => a.email.toLowerCase() == emailBaru)) {
      ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email sudah terdaftar')),
        );
        return;
    }
    daftarAkun.add(Akun(
      nama: namaCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      hp: hpCtrl.text.trim(),
      sandi: sandiCtrl.text,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VerificationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Transform.translate(
                  offset: const Offset(0, -40), // angka minus = naik
                  child: judul('BUAT AKUN',
                      kiri: true,
                      jarak: 0.5,
                      lebarLogo: 250,
                      ukuranTeks: 25,
                      tebal: 0.4,
                      isiLogo: 0.94),
                ),
                const SizedBox(height: 32),

                kolom('Nama Pengguna', Icons.person,
                    controller: namaCtrl,
                    errorText: errNama,
                    onChanged: (_) {
                      if (errNama != null) setState(() => errNama = null);
                    }),
                const SizedBox(height: 22),
                kolom('Email', Icons.email,
                    controller: emailCtrl,
                    errorText: errEmail,
                    onChanged: (_) {
                      if (errEmail != null) setState(() => errEmail = null);
                    }),
                const SizedBox(height: 22),
                kolom('Nomor Hp', Icons.phone,
                    controller: hpCtrl,
                    errorText: errHp,
                    onChanged: (_) {
                      if (errHp != null) setState(() => errHp = null);
                    }),
                const SizedBox(height: 22),
                kolom('Kata Sandi', Icons.lock,
                    sandi: true,
                    controller: sandiCtrl,
                    errorText: errSandi,
                    onChanged: (_) {
                      if (errSandi != null) setState(() => errSandi = null);
                    }),
                const SizedBox(height: 22),
                kolom('Konfirmasi Kata Sandi', Icons.lock,
                    sandi: true,
                    controller: konfirmCtrl,
                    errorText: errKonfirm,
                    onChanged: (_) {
                      if (errKonfirm != null) {
                        setState(() => errKonfirm = null);
                      }
                    }),
                const SizedBox(height: 14),

                // Checkbox persetujuan
                Row(
                  children: [
                    Checkbox(
                      value: setuju,
                      activeColor: hijau,
                      onChanged: (v) => setState(() {
                        setuju = v!;
                        errSetuju = null;
                      }),
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 11),
                          children: [
                            TextSpan(text: 'Saya telah membaca dan menyetujui '),
                            TextSpan(
                                text: 'persyaratan dan privasi pengguna',
                                style: TextStyle(color: biru)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (errSetuju != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(errSetuju!,
                          style: TextStyle(
                              fontSize: 10, color: Colors.red.shade600)),
                    ),
                  ),
                const SizedBox(height: 16),

                // Tombol BUAT AKUN (dicek dulu sebelum ke Verifikasi)
                tombol('BUAT AKUN', buatAkun, berat: FontWeight.w800),
                const SizedBox(height: 20),

                // Sudah punya akun? Masuk -> kembali ke Login
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 12),
                      children: [
                        TextSpan(text: 'Sudah punya akun? '),
                        TextSpan(text: 'Masuk', style: TextStyle(color: biru)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============ 4. VERIFIKASI ============
class VerificationPage extends StatefulWidget {
  final bool lewatHp;
  final bool untukReset; // true = datang dari Lupa Kata Sandi

  const VerificationPage(
      {super.key, this.lewatHp = true, this.untukReset = false});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late bool lewatHp;

  final List<TextEditingController> kode =
      List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    lewatHp = widget.lewatHp;
  }

  @override
  void dispose() {
    for (final c in kode) {
      c.dispose();
    }
    super.dispose();
  }

  // satu kotak kode
  Widget kotakKode(int i) {
    return SizedBox(
      width: 82,
      height: 82,
      child: TextField(
        controller: kode[i],
        expands: true,
        maxLines: null,
        minLines: null,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        onChanged: (v) {
          if (v.isNotEmpty) FocusScope.of(context).nextFocus();
        },
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: abu,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE3E3E3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: hijau, width: 1.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== header =====
            RepaintBoundary(
              child: SizedBox(
                height: 275,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: PotongVerif(),
                      child: Container(
                        height: 275,
                        width: double.infinity,
                        color: const Color(0xFFDAE6E3),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Center(child: logo(imgLogoHijau, 262, hijau)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.check, size: 22),
                      SizedBox(width: 10),
                      Text('VERIFIKASI',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        imgIkonHp,
                        width: 36,
                        height: 36,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.phone_android, size: 34),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(
                                fontSize: 13.5,
                                color: Colors.black,
                                height: 1.35),
                            children: [
                              const TextSpan(
                                  text:
                                      'Periksa dan ketik kode verifikasi yang telah dikirimkan ke '),
                              TextSpan(
                                text: lewatHp
                                    ? '+6212371923719238'
                                    : 'contohsample@gmail.com',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  // 4 kotak kode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      kotakKode(0),
                      kotakKode(1),
                      kotakKode(2),
                      kotakKode(3),
                    ],
                  ),
                  const SizedBox(height: 34),

                  GestureDetector(
                    onTap: () => setState(() => lewatHp = !lewatHp),
                    child: Text(
                      lewatHp
                          ? 'Verifikasi menggunakan Email'
                          : 'Verifikasi menggunakan No. Hp',
                      style: const TextStyle(fontSize: 13.5, color: biru),
                    ),
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hijau,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () {
                        // wajib isi 4 kotak dulu
                        if (kode.any((c) => c.text.trim().isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Isi 4 digit kode verifikasi dulu')),
                          );
                          return;
                        }
                        if (widget.untukReset) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ResetPasswordPage()),
                          );
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text('KIRIM',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Center(
                    child: Text('Kirim Ulang Kode',
                        style: TextStyle(fontSize: 13.5, color: hijau)),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// potongan miring header Verifikasi (kiri lebih tinggi dari kanan)
class PotongVerif extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height * 0.43)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ============ 5. LUPA KATA SANDI ============
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool pakaiEmail = true;
  final TextEditingController isian = TextEditingController();

  @override
  void dispose() {
    isian.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== header: logo + LUPA KATA SANDI =====
            RepaintBoundary(
              child: SizedBox(
                height: 275,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: PotongVerif(),
                      child: Container(
                        height: 275,
                        width: double.infinity,
                        color: const Color(0xFFDAE6E3),
                      ),
                    ),
                    Positioned(
                      top: 158,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          logo(imgLogoHijau, 262, hijau),
                          const SizedBox(height: 4),
                          const Text(
                            'LUPA KATA SANDI',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: hijau,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 22),

                  // lonceng + keterangan
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        imgIkonLonceng,
                        width: 26,
                        height: 26,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.notifications_none, size: 26),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          pakaiEmail
                              ? 'Periksa dan masukan alamat Email untuk mendapatkan kode verifikasi'
                              : 'Periksa dan masukan Nomor Hp untuk mendapatkan kode verifikasi',
                          style: const TextStyle(
                              fontSize: 14, height: 1.35, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),

                  Text(
                    pakaiEmail ? 'Alamat Email' : 'Nomor Hp',
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF555555)),
                  ),
                  TextField(
                    controller: isian,
                    keyboardType: pakaiEmail
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(top: 22, bottom: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF9E9E9E), width: 1.3),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: hijau, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  GestureDetector(
                    onTap: () => setState(() {
                      pakaiEmail = !pakaiEmail;
                      isian.clear();
                    }),
                    child: Text(
                      pakaiEmail ? 'Gunakan Nomor Hp' : 'Gunakan Email',
                      style: const TextStyle(fontSize: 14, color: biru),
                    ),
                  ),
                  const SizedBox(height: 34),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hijau,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () {
                        final nilai = isian.text.trim();
                        if (nilai.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(pakaiEmail
                                  ? 'Alamat Email wajib diisi'
                                  : 'Nomor Hp wajib diisi'),
                            ),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VerificationPage(
                                lewatHp: !pakaiEmail, untukReset: true),
                          ),
                        );
                      },
                      child: const Text('KIRIM',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ 6. UBAH KATA SANDI ============
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController sandiBaru = TextEditingController();
  final TextEditingController sandiKonfirmasi = TextEditingController();
  bool sembunyi1 = true;
  bool sembunyi2 = true;

  @override
  void dispose() {
    sandiBaru.dispose();
    sandiKonfirmasi.dispose();
    super.dispose();
  }

  void pesan(String teks) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(teks)));
  }

  void ubahSandi() {
    if (sandiBaru.text.isEmpty) {
      pesan('Kata sandi baru wajib diisi');
      return;
    }
    if (sandiBaru.text.length < 6) {
      pesan('Kata sandi minimal 6 karakter');
      return;
    }
    if (sandiKonfirmasi.text.isEmpty) {
      pesan('Konfirmasi kata sandi wajib diisi');
      return;
    }
    if (sandiKonfirmasi.text != sandiBaru.text) {
      pesan('Kata sandi tidak sama');
      return;
    }
    pesan('Kata sandi berhasil diubah');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  // satu kolom kata sandi (ikon gembok, isian, ikon mata, garis bawah)
  Widget kolomSandi({
    required String hint,
    required TextEditingController controller,
    required bool sembunyi,
    required VoidCallback gantiMata,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF7A7A7A), width: 1.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock, size: 22, color: Color(0xFF6B6B6B)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: sembunyi,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF777777),
                ),
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 9),
              ),
            ),
          ),
          GestureDetector(
            onTap: gantiMata,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 14),
              child: Icon(
                sembunyi ? Icons.visibility_off : Icons.visibility,
                size: 22,
                color: const Color(0xFF6B6B6B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== header: logo + LUPA KATA SANDI =====
            RepaintBoundary(
              child: SizedBox(
                height: 275,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: PotongVerif(),
                      child: Container(
                        height: 275,
                        width: double.infinity,
                        color: const Color(0xFFDAE6E3),
                      ),
                    ),
                    Positioned(
                      top: 158,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          logo(imgLogoHijau, 262, hijau),
                          const SizedBox(height: 4),
                          const Text(
                            'LUPA KATA SANDI',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: hijau,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 38),
                  const Text(
                    'Masukan Kata Sandi Baru',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 44),

                  kolomSandi(
                    hint: 'Kata Sandi Baru',
                    controller: sandiBaru,
                    sembunyi: sembunyi1,
                    gantiMata: () => setState(() => sembunyi1 = !sembunyi1),
                  ),
                  const SizedBox(height: 38),

                  kolomSandi(
                    hint: 'Konfirmasi Kata Sandi',
                    controller: sandiKonfirmasi,
                    sembunyi: sembunyi2,
                    gantiMata: () => setState(() => sembunyi2 = !sembunyi2),
                  ),
                  const SizedBox(height: 60),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hijau,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: ubahSandi,
                      child: const Text('UBAH KATA SANDI',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ 7. HALAMAN PROFIL ============
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Ganti nama dan email di sini
  static const String nama = 'AISQ SARYALA';
  static const String email = 'aisqsaryala@gmail.com';

  // Foto bulat (124) dengan garis putih
  Widget foto() {
    return Container(
      width: 124,
      height: 124,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: abu,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: ClipOval(
        child: Image.asset(
          imgFoto,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) {
            debugPrint('ERROR GAMBAR: $error');
            return const Icon(Icons.person, size: 60, color: Colors.grey);
          },
        ),
      ),
    );
  }

   // Satu baris menu (tulisan 18, ikon 28, tiap baris setinggi 68)
  Widget menu(IconData ikon, String teks, [VoidCallback? aksi]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InkWell(
            onTap: aksi,
            child: Padding(
              padding: const EdgeInsets.only(left: 17, top: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(ikon, size: 28, color: Colors.black),
                  const SizedBox(width: 22),
                  Expanded(
                    child: Text(teks,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  const Icon(Icons.chevron_right,
                      size: 30, color: Colors.black),
                ],
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFCFCFCF)),
        ],
      ),
    );
  }

  // Menu bawah: 3 ikon + lingkaran AKUN yang menonjol ke atas
  Widget navBawah() {
    return SizedBox(
      height: 118,
      child: Stack(
        children: [
          // batang hijau
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 76,
              color: hijau,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: const Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Icon(Icons.home_outlined,
                          color: Colors.white, size: 40),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Icon(Icons.verified_user,
                          color: Colors.white, size: 36),
                    ),
                  ),
                  Expanded(
                    // balon chat + hati di dalamnya
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.chat_bubble,
                              color: Colors.white, size: 40),
                          Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Icon(Icons.favorite,
                                color: hijau, size: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()), // tempat lingkaran AKUN
                ],
              ),
            ),
          ),

          // lingkaran AKUN
          Positioned(
            top: 0,
            right: 29,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 86, height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: hijau, width: 9),
                  ),
                  child: const Icon(Icons.person, color: hijau, size: 48),
                ),
                const SizedBox(height: 2),
                const Text('AKUN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Latar hijau + foto yang menonjol ke bawah
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(height: 150, width: double.infinity, color: hijau),
              Positioned(bottom: -62, child: foto()),
            ],
          ),
          const SizedBox(height: 74),

          // Nama
          const Text(nama,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 7),

          // Email (kotak hijau)
          Container(
            width: 190,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hijau,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(email,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 24),

          // Daftar menu (bisa digulir kalau layar kecil)
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                menu(Icons.settings_outlined, 'Pengaturan'),
                menu(Icons.edit_outlined, 'Edit Profil'),
                menu(Icons.lock_outline, 'Kebijakan Privasi'),
                menu(Icons.info_outline, 'Tentang Kami'),
                menu(Icons.fact_check_outlined, 'Ketentuan Layanan'),
                Builder(
                  builder: (context) => menu(Icons.logout, 'Keluar', () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  }),
                ),
              ],
            ),
          ),

          navBawah(),
        ],
      ),
    );
  }
}