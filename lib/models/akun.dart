import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Model data akun
class Akun {
  String nama;
  final String email;
  final String hp;
  String sandi;
  String? fotoPath;
  String? fotoPathBaru;

  Akun({
    required this.nama,
    required this.email,
    required this.hp,
    required this.sandi,
    this.fotoPath,
    this.fotoPathBaru,
  });
}

// Akun aktif
Akun? akunAktif;
Akun? akunUntukReset;

// Akun bawaan
final List<Akun> daftarAkun = [
  Akun(
    nama: 'Aisq',
    email: 'aisqsaryala@gmail.com',
    hp: '081234567890',
    sandi: '123456',
    fotoPath: 'lib/images/pic.jpg',
    fotoPathBaru: 'lib/images/image 2.png',
  ),
];

// Memuat akun dari penyimpanan HP
Future<void> muatAkun() async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getString('akun_tersimpan');

  if (data == null) return;

  final List list = jsonDecode(data);

  for (final item in list) {
    final email = item['email'] as String;

    final index = daftarAkun.indexWhere(
      (a) => a.email.toLowerCase() == email.toLowerCase(),
    );

    if (index == -1) {
      daftarAkun.add(
        Akun(
          nama: item['nama'],
          email: email,
          hp: item['hp'],
          sandi: item['sandi'],
          fotoPath: fotoAsetValid(item['fotoPath'] as String?),
          fotoPathBaru: fotoAsetValid(
            item['fotoPathBaru'] as String?,
          ),
        ),
      );
    } else {
      final akunLama = daftarAkun[index];
      akunLama.nama = item['nama'] ?? akunLama.nama;
      akunLama.sandi = item['sandi'] ?? akunLama.sandi;
      akunLama.fotoPath = fotoAsetValid(
        item['fotoPath'] as String?,
      );
      akunLama.fotoPathBaru = fotoAsetValid(
        item['fotoPathBaru'] as String?,
      );
    }
  }
}

// Menyimpan semua akun
Future<void> simpanAkun() async {
  final prefs = await SharedPreferences.getInstance();

  final data = jsonEncode(
    daftarAkun.map((a) => {
      'nama': a.nama,
      'email': a.email,
      'hp': a.hp,
      'sandi': a.sandi,
      'fotoPath': a.fotoPath,
      'fotoPathBaru': a.fotoPathBaru,
    }).toList(),
  );

  await prefs.setString('akun_tersimpan', data);
}

// Memastikan foto profil menggunakan aset dari proyek
String? fotoAsetValid(String? path) {
  if (path == null) return null;

  if (path.startsWith('lib/images/')) {
    return path;
  }

  return null;
}
