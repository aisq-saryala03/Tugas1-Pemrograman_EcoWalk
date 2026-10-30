import 'package:flutter/material.dart';

import '../models/akun.dart';
import '../utils/konstanta.dart';
import '../widgets/widget_bantuan.dart';
import '../pages/verification_page.dart';
import '../pages/login_page.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(teks)),
    );
  }

  Future<void> ubahSandi() async {
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

    // Pastikan akun yang akan direset tersedia.
    final akun = akunUntukReset;

    if (akun == null) {
    pesan('Akun reset tidak ditemukan. Ulangi proses lupa kata sandi.');
    return;
  }

  // Ubah kata sandi akun yang dipilih.
  akun.sandi = sandiBaru.text;

  // Simpan perubahan ke SharedPreferences.
  await simpanAkun();

  // Bersihkan akun reset setelah penyimpanan berhasil.
  akunUntukReset = null;

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Kata sandi berhasil diubah'),
    ),
  );

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginPage(),
    ),
    (route) => false,
  );
}



Widget kolomSandi({
  required String hint,
  required TextEditingController controller,
  required bool sembunyi,
  required VoidCallback gantiMata,
}) {
  const warnaIkon = Color(0xFF737373);
  const warnaTeks = Color(0xFF666666);

  return SizedBox(
    height: 40,
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF777777),
            width: 1.2,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.lock,
            size: 18,
            color: warnaIkon,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: sembunyi,
              style: const TextStyle(
                fontSize: 13,
                color: warnaTeks,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  color: warnaTeks,
                ),
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: gantiMata,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: SizedBox(
                width: 20,
                child: Icon(
                  sembunyi
                  ? Icons.visibility_off
                   : Icons.visibility,
                  size: 18,
                  color: warnaIkon,
                ),
              ),
            ),
          ),
        ],
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
                        color: const Color(0xFFDAE6E3),
                      ),
                    ),
                    Positioned(
                      top: 158,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          logo(
                            imgLogoHijau,
                            262,
                            hijau,
                          ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  const Text(
                    'Masukan Kata Sandi Baru',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 44),
                  kolomSandi(
                    hint: 'Kata Sandi Baru',
                    controller: sandiBaru,
                    sembunyi: sembunyi1,
                    gantiMata: () {
                      setState(() {
                        sembunyi1 = !sembunyi1;
                      });
                    },
                  ),
                  const SizedBox(height: 38),

                  kolomSandi(
                    hint: 'Konfirmasi Kata Sandi',
                    controller: sandiKonfirmasi,
                    sembunyi: sembunyi2,
                    gantiMata: () {
                      setState(() {
                        sembunyi2 = !sembunyi2;
                      });
                    },
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: ubahSandi,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hijau,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'UBAH KATA SANDI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
