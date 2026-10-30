
import 'package:flutter/material.dart';
import '../models/akun.dart';
import '../utils/konstanta.dart';
import '../widgets/widget_bantuan.dart';
import '../pages/verification_page.dart';

// ============ HALAMAN REGISTRASI ============

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

  bool setuju = false;

  String? errNama;
  String? errEmail;
  String? errHp;
  String? errSandi;
  String? errKonfirm;
  String? errSetuju;

  @override
  void dispose() {
    namaCtrl.dispose();
    emailCtrl.dispose();
    hpCtrl.dispose();
    sandiCtrl.dispose();
    konfirmCtrl.dispose();
    super.dispose();
  }

  void buatAkun() {
    final nama = namaCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final hp = hpCtrl.text.trim();
    final sandi = sandiCtrl.text;
    final konfirm = konfirmCtrl.text;

    final emailBenar =
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);

    setState(() {
      errNama =
          nama.isEmpty ? 'Nama pengguna wajib diisi' : null;

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

      errSetuju =
          setuju ? null : 'Centang persetujuan terlebih dahulu';
    });

    final adaError = errNama != null ||
        errEmail != null ||
        errHp != null ||
        errSandi != null ||
        errKonfirm != null ||
        errSetuju != null;

    if (adaError) return;

    final emailBaru = email.toLowerCase();

    if (daftarAkun.any(
      (a) => a.email.toLowerCase() == emailBaru,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sudah terdaftar'),
        ),
      );
      return;
    }

    // Menambahkan akun baru dan menyimpannya ke penyimpanan HP.
    daftarAkun.add(
      Akun(
        nama: nama,
        email: email,
        hp: hp,
        sandi: sandi,
      ),
    );

    simpanAkun();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VerificationPage(),
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
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: judul(
                    'BUAT AKUN',
                    kiri: true,
                    jarak: 0.5,
                    lebarLogo: 250,
                    ukuranTeks: 25,
                    tebal: 0.4,
                    isiLogo: 0.94,
                  ),
                ),
                const SizedBox(height: 25),

                kolom(
                  'Nama Pengguna',
                  Icons.person,
                  controller: namaCtrl,
                  errorText: errNama,
                  onChanged: (_) {
                    if (errNama != null) {
                      setState(() => errNama = null);
                    }
                  },
                ),
                const SizedBox(height: 22),

                kolom(
                  'Email',
                  Icons.email,
                  controller: emailCtrl,
                  errorText: errEmail,
                  onChanged: (_) {
                    if (errEmail != null) {
                      setState(() => errEmail = null);
                    }
                  },
                ),
                const SizedBox(height: 22),

                kolom(
                  'Nomor Hp',
                  Icons.phone,
                  controller: hpCtrl,
                  errorText: errHp,
                  onChanged: (_) {
                    if (errHp != null) {
                      setState(() => errHp = null);
                    }
                  },
                ),
                const SizedBox(height: 22),

                kolom(
                  'Kata Sandi',
                  Icons.lock,
                  sandi: true,
                  controller: sandiCtrl,
                  errorText: errSandi,
                  onChanged: (_) {
                    if (errSandi != null) {
                      setState(() => errSandi = null);
                    }
                  },
                ),
                const SizedBox(height: 22),

                kolom(
                  'Konfirmasi Kata Sandi',
                  Icons.lock,
                  sandi: true,
                  controller: konfirmCtrl,
                  errorText: errKonfirm,
                  onChanged: (_) {
                    if (errKonfirm != null) {
                      setState(() => errKonfirm = null);
                    }
                  },
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Checkbox(
                      value: setuju,
                      activeColor: hijau,
                      onChanged: (v) {
                        setState(() {
                          setuju = v ?? false;
                          errSetuju = null;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                              text:
                                  'Saya telah membaca dan menyetujui ',
                            ),
                            TextSpan(
                              text:
                                  'persyaratan dan privasi pengguna',
                              style: TextStyle(color: biru),
                            ),
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
                      child: Text(
                        errSetuju!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 25),

                tombol(
                  'BUAT AKUN',
                  buatAkun,
                  berat: FontWeight.w800,
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 13),
                      children: [
                        TextSpan(
                          text: 'Sudah punya akun? ',
                        ),
                        TextSpan(
                          text: 'Masuk',
                          style: TextStyle(color: biru),
                        ),
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
