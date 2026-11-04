
import 'package:flutter/material.dart';

import '../models/akun.dart';
import '../utils/konstanta.dart';
import '../widgets/widget_bantuan.dart';
import '../pages/forgot_password_page.dart';
import '../pages/profile_page.dart';
import '../pages/register_page.dart';
import '../beranda_page.dart';

// ============ HALAMAN LOGIN ============

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCtrl = TextEditingController();
  final sandiCtrl = TextEditingController();

  String? errUser;
  String? errSandi;

  @override
  void dispose() {
    userCtrl.dispose();
    sandiCtrl.dispose();
    super.dispose();
  }

  void masuk() {
    setState(() {
      errUser = userCtrl.text.trim().isEmpty
          ? 'Nama pengguna wajib diisi'
          : null;

      errSandi = sandiCtrl.text.isEmpty
          ? 'Kata sandi wajib diisi'
          : null;
    });

    if (errUser != null || errSandi != null) {
      return;
    }

    final inputUser = userCtrl.text.trim().toLowerCase();

    final cocok = daftarAkun.where(
      (a) =>
          (a.email.toLowerCase() == inputUser ||
              a.nama.toLowerCase() == inputUser ||
              a.hp == userCtrl.text.trim()) &&
          a.sandi == sandiCtrl.text,
    );

    if (cocok.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Akun atau kata sandi salah'),
        ),
      );
      return;
    }

    akunAktif = cocok.first;

    debugPrint('LOGIN BERHASIL: menuju BerandaPage');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const BerandaPage(),
      ),
    );
  }

  Widget label(String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        teks,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget garisPudar(bool kiri) {
    return Expanded(
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: kiri
                ? [
                    Colors.transparent,
                    Colors.grey.shade400,
                  ]
                : [
                    Colors.grey.shade400,
                    Colors.transparent,
                  ],
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
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: judul('MASUK',
                    lebarLogo: 250, ukuranTeks: 25, jarak: 2, tebal: 0.4),
                ),
                const SizedBox(height: 56),

                label('Nama Pengguna'),
                kolom(
                  '',
                  Icons.person,
                  controller: userCtrl,
                  errorText: errUser,
                  onChanged: (_) {
                    if (errUser != null) {
                      setState(() => errUser = null);
                    }
                  },
                ),
                const SizedBox(height: 13),

                label('Kata Sandi'),
                kolom(
                  '',
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
                
                const SizedBox(height: 40),

                // Tombol MASUK
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: masuk,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hijau,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text('MASUK',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900)),
                  ),
                ),

                const SizedBox(height: 28),


                //Lupa Kata Sandi? 
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text('Lupa Kata Sandi?',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: biru,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Garis "Atau"
                Row(
                  children: [
                    garisPudar(true),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14,),
                      child: Text('Atau', style: TextStyle(fontSize: 11)),
                    ),
                    garisPudar(false),
                  ],
                ),
                const SizedBox(height: 36),

                // Tombol Google
                Material(
                  color: abu,
                  elevation: 3,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {},
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            imgGoogle,
                            width: 24,
                            height: 24,
                            errorBuilder: (context, error, stack) {
                              debugPrint('ERROR GAMBAR: $error',);
                              return const Text('G',
                                style: TextStyle(
                                  color: Color(0xFF4285F4),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900));
                            },
                          ),
                          const SizedBox(width: 12),
                          const Text('Lanjutkan dengan Google',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 44),

                // Tidak punya akun? Daftar disini
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
                        style: TextStyle(fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'Tidak punya akun? '),
                          TextSpan(
                            text: 'Daftar disini',
                            style: TextStyle(color: biru),
                          ),
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