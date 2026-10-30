import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/konstanta.dart';
import '../widgets/widget_bantuan.dart';
import '../pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
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