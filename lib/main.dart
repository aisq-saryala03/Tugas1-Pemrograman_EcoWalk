import 'package:flutter/material.dart';
import 'models/akun.dart';
import 'pages/splash_page.dart';
import 'beranda_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Memuat akun yang pernah didaftarkan
  await muatAkun();

  // Menjalankan aplikasi EcoWalk
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EcoWalk',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
