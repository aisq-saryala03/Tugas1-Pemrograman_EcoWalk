import 'package:flutter/material.dart';

import '../models/akun.dart';
import '../utils/konstanta.dart';
import '../widgets/widget_bantuan.dart';
import '../pages/verification_page.dart';

// ============ HALAMAN LUPA KATA SANDI ============

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
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
                              shadows: [
                                Shadow(
                                  color: hijau,
                                  offset: Offset(0.3, 0),
                                  blurRadius: 0,
                                ),
                              ],
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        imgIkonLonceng,
                        width: 26,
                        height: 26,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) =>
                            const Icon(
                          Icons.notifications_none,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          pakaiEmail
                              ? 'Periksa dan masukan alamat Email untuk mendapatkan kode verifikasi'
                              : 'Periksa dan masukan Nomor Hp untuk mendapatkan kode verifikasi',
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),
                  Text(
                    pakaiEmail ? 'Alamat Email' : 'Nomor Hp',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF555555),
                    ),
                  ),
                  TextField(
                    controller: isian,
                    keyboardType: pakaiEmail
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: 22,
                        bottom: 12,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9E9E9E),
                          width: 1.3,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: hijau,
                          width: 1.5,
                        ),
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
                      pakaiEmail
                          ? 'Gunakan Nomor Hp'
                          : 'Gunakan Email',
                      style: const TextStyle(
                        fontSize: 14,
                        color: biru,
                      ),
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
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        final nilai = isian.text.trim();

                        if (nilai.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                pakaiEmail
                                    ? 'Alamat Email wajib diisi'
                                    : 'Nomor Hp wajib diisi',
                              ),
                            ),
                          );
                          return;
                        }

                        Akun? ditemukan;

                        for (final akun in daftarAkun) {
                          final cocok = pakaiEmail
                            ? akun.email.toLowerCase() == nilai.toLowerCase()
                            : akun.hp == nilai;

                          if (cocok) {
                            ditemukan = akun;
                            break;
                          }
                        }
                        
                        if (ditemukan == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Akun tidak ditemukan'),
                            ),
                          );
                          return;
                        }

                        akunUntukReset = ditemukan;
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VerificationPage(
                              lewatHp: !pakaiEmail,
                              untukReset: true,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'KIRIM',
                        style: TextStyle(
                          fontSize: 15,
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
