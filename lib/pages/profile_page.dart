import 'package:flutter/material.dart';

import '../models/akun.dart';
import '../utils/konstanta.dart';
import '../pages/login_page.dart';
import '../pages/edit_profil_baru_page.dart';
import '../pages/pengaturan_page.dart';
import '../pages/ketentuan_layanan_page.dart';
import '../pages/kebijakan_privasi_page.dart';
import '../pages/tentang_kami_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

Widget foto() {
  final String pathFoto =
      akunAktif?.fotoPath ?? 'lib/images/pic.jpg';

  return Container(
    width: 124,
    height: 124,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: abu,
      border: Border.all(
        color: Colors.white,
        width: 4,
      ),
    ),
    child: ClipOval(
      child: Image.asset(
        pathFoto.startsWith('lib/images/')
            ? pathFoto
            : 'lib/images/pic.jpg',
        width: 124,
        height: 124,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'lib/images/pic.jpg',
            width: 124,
            height: 124,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person,
                size: 60,
                color: Colors.grey,
              );
            },
          );
        },
      ),
    ),
  );
}

  // =====================================================
  // POP-UP KONFIRMASI KELUAR
  // =====================================================
  void konfirmasiKeluar(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.32),
      builder: (dialogContext) {
        return Transform.translate(
          offset: const Offset(0, -50),
          child: Dialog(
            backgroundColor: Colors.white,
            elevation: 8,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 24,
            ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: SizedBox(
            width: 300,
            height: 165, 
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // JUDUL POP-UP
                  const Text(
                    'Keluar?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // PESAN KONFIRMASI
                  const Text(
                    'Apakah Kamu Yakin Ingin Keluar?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // TOMBOL BATAL DAN KELUAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TOMBOL BATAL
                      SizedBox(
                          width: 105,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                dialogContext,
                                false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hijau,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              'Batal',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(width: 12),

                      // TOMBOL KELUAR
                      SizedBox(
                          width: 103, 
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(
                                dialogContext,
                                true,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: const BorderSide(
                                color: Color(0xFF176D5B),
                                width: 2,
                              ),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              'Keluar',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ),
        );
      },
    ).then((hasil) {
      // JIKA PENGGUNA MEMILIH KELUAR
      if (hasil == true) {
        akunAktif = null;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
          (route) => false,
        );
      }
    });
  }


  Widget menu(IconData ikon, String teks, [VoidCallback? aksi]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          InkWell(
            onTap: aksi,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Icon(
                    ikon,
                    size: 28,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    child: Text(
                      teks,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1.3,
            color: Color(0xFFCFCFCF),
          ),
        ],
      ),
    );
  }

  Widget navBawah(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // LATAR HIJAU — SAMA DENGAN BERANDA
          Positioned(
            left: 0,
            right: 0,
            top: 30,
            bottom: -30,
            child: Container(
              color: const Color(0xFF1B6657),
            ),
          ),

          // EMPAT IKON NAVIGASI
          Row(
            children: [
              itemNavigasi(context, 0, Icons.home_outlined, 'BERANDA'),
              itemNavigasi(context, 1, Icons.verified_user, ''),
              itemNavigasi(context, 2, Icons.favorite, ''),
              itemNavigasi(context, 3, Icons.person, 'AKUN'),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemNavigasi(
    BuildContext context,
    int index,
    IconData ikon,
    String label,
  ) {
    // Di halaman Profil, ikon Profil yang aktif.
    final bool aktif = index == 3;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 3) {
            return;
          }

          if (index == 0) {
            Navigator.pop(context);
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                index == 1
                    ? 'Menu Tantangan dipilih'
                    : 'Menu Aktivitas dipilih',
              ),
              duration: const Duration(milliseconds: 800),
            ),
          );
        },
        child: SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              // LINGKARAN AKTIF — SAMA DENGAN BERANDA
              if (aktif)
                Positioned(
                  top: -20,
                  child: Container(
                    width: 92,
                    height: 92,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B6657),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        ikon,
                        size: 47,
                        color: const Color(0xFF315F55),
                      ),
                    ),
                  ),
                )
              else
                Positioned(
                  top: 44,
                  child: Icon(
                    ikon,
                    size: 38,
                    color: Colors.white,
                  ),
                ),

              // LABEL AKUN
              if (aktif && label.isNotEmpty)
                Positioned(
                  top: 70,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final nama = (akunAktif?.nama ?? '').toUpperCase();
    final email = akunAktif?.email ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                color: hijau,
              ),
              Positioned(
                bottom: -62,
                child: foto(),
              ),
            ],
          ),
          const SizedBox(height: 74),
          Text(
            nama,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: hijau,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                menu(Icons.settings_outlined, 'Pengaturan', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PengaturanPage(),
                    ),
                  );
                }),
                menu(Icons.edit_outlined, 'Edit Profil', () async {
                  final hasil = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilBaruPage(),
                    ),
                  );

                  if (!mounted) return;

                  if (hasil == true) {
                    setState(() {});
                  }
                }),
                menu(Icons.lock_outline, 'Kebijakan Privasi', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KebijakanPrivasiPage(),
                    ),
                  );
                }),
                menu(Icons.info_outline, 'Tentang Kami', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TentangKamiPage(),
                    ),
                  );
                }),
                menu(Icons.fact_check_outlined, 'Ketentuan Layanan', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KetentuanLayananPage(),
                    ),
                  );
                }),
                menu(
                  Icons.logout,
                  'Keluar',
                  () => konfirmasiKeluar(context),
                ),
              ],
            ),
          ),
          navBawah(context),
        ],
      ),
    );
  }
}
