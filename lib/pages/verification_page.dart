
import 'package:flutter/material.dart';

import '../utils/konstanta.dart';
import '../widgets/widget_bantuan.dart';
import '../pages/login_page.dart';
import '../pages/reset_password_page.dart';

// ============ HALAMAN VERIFIKASI ============

class VerificationPage extends StatefulWidget {
  final bool lewatHp;
  final bool untukReset;
  final bool untukPengaturan;

  const VerificationPage({
    super.key,
    this.lewatHp = true,
    this.untukReset = false,
    this.untukPengaturan = false,
  });

  @override
  State<VerificationPage> createState() =>
      _VerificationPageState();
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
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (v) {
          if (v.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: abu,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFE3E3E3),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: hijau,
              width: 1.5,
            ),
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
                      child: Center(
                        child: logo(
                          imgLogoHijau,
                          262,
                          hijau,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  const Row(
                    children: [
                      Icon(Icons.check, size: 22),
                      SizedBox(width: 10),
                      Text(
                        'VERIFIKASI',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        imgIkonHp,
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) =>
                            const Icon(
                          Icons.phone_android,
                          size: 36,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              height: 1.35,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    'Periksa dan ketik kode verifikasi yang telah dikirimkan ke ',
                              ),
                              TextSpan(
                                text: lewatHp
                                    ? '+6212371923719238'
                                    : 'contohsample@gmail.com',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      kotakKode(0),
                      kotakKode(1),
                      kotakKode(2),
                      kotakKode(3),
                    ],
                  ),
                  const SizedBox(height: 34),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        lewatHp = !lewatHp;
                      });
                    },
                    child: Text(
                      lewatHp
                          ? 'Verifikasi menggunakan Email'
                          : 'Verifikasi menggunakan No. Hp',
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF00B4D8),
                        fontWeight: FontWeight.w600,
                      ),
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
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        if (kode.any((c) => c.text.trim().isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Isi 4 digit kode verifikasi dulu',
                              ),
                            ),
                          );
                          return;
                        }

                        if (widget.untukReset) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResetPasswordPage(),
                            ),
                          );
                        } else if (widget.untukPengaturan) {
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          );
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        }
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

                  const Center(
                    child: Text(
                      'Kirim Ulang Kode',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF1D6556),
                        fontWeight: FontWeight.w600,
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

// ============ PEMOTONG BENTUK HEADER VERIFIKASI ============

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
  bool shouldReclip(
    covariant CustomClipper<Path> oldClipper,
  ) {
    return false;
  }
}
