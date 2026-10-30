import 'package:flutter/material.dart';

import '../utils/konstanta.dart';
import '../models/akun.dart';
import 'kamera_page.dart';
import 'galeri_page.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final TextEditingController namaController =
      TextEditingController();

  String? fotoProfilBaru;

  @override
  void initState() {
    super.initState();

    namaController.text = akunAktif?.nama ?? '';

    // Menggunakan foto bawaan jika belum ada foto profil
    fotoProfilBaru = akunAktif?.fotoPath;

    if (fotoProfilBaru == null ||
        fotoProfilBaru!.isEmpty ||
        !fotoProfilBaru!.startsWith('lib/images/')) {
      fotoProfilBaru = 'lib/images/pic.jpg';
    }
  }

  // MENYIMPAN NAMA DAN FOTO PROFIL
  Future<void> simpanProfil() async {
    final namaBaru = namaController.text.trim();

    if (namaBaru.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama pengguna wajib diisi'),
        ),
      );
      return;
    }

    if (akunAktif == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan login terlebih dahulu'),
        ),
      );
      return;
    }

    akunAktif!.nama = namaBaru;

    if (fotoProfilBaru != null) {
      akunAktif!.fotoPath = fotoProfilBaru;
    }

    await simpanAkun();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui'),
      ),
    );

    Navigator.pop(context, true);
  }

  // MODAL PILIHAN FOTO
  void tampilkanPilihanFoto() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return Container(
          height: 188,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 11),

              Container(
                width: 84,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFC8C8C8),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pilihanFoto(
                    modalContext: modalContext,
                    namaIkon: 'lib/images/ikon_kamera.png',
                    teks: 'Kamera',
                    bukaKamera: true,
                  ),

                  const SizedBox(width: 42),

                  pilihanFoto(
                    modalContext: modalContext,
                    namaIkon: 'lib/images/ikon_galeri.png',
                    teks: 'Galeri',
                    bukaKamera: false,
                  ),
                ],
              ),

              const Spacer(),

              Container(
                height: 1,
                color: const Color(0xFFF0F0F0),
              ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget pilihanFoto({
    required BuildContext modalContext,
    required String namaIkon,
    required String teks,
    required bool bukaKamera,
  }) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(modalContext);

        final String? hasil = await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (_) {
              return bukaKamera
                  ? const KameraPage(
                      fotoHasil: 'lib/images/pic.jpg',
                    )
                  : const GaleriPage();
            },
          ),
        );

        if (hasil != null && mounted) {
          setState(() {
            fotoProfilBaru = hasil;
          });
        }
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 66,
              decoration: BoxDecoration(
                color: const Color(0xFFF0EEF0),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                namaIkon,
                width: 34,
                height: 34,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return Icon(
                    bukaKamera
                        ? Icons.camera_alt_outlined
                        : Icons.photo_library_outlined,
                    size: 32,
                    color: Colors.black,
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Text(
              teks,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MENAMPILKAN FOTO PROFIL
  ImageProvider gambarProfil() {
    if (fotoProfilBaru == null || fotoProfilBaru!.isEmpty) {
      return const AssetImage('lib/images/pic.jpg');
    }

    return AssetImage(fotoProfilBaru!);
  }

    @override
    void dispose() {
      namaController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final lebarLayar = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER
            Container(
              height: 58,
              color: hijau,
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Text(
                    'Edit Profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // FOTO PROFIL
            SizedBox(height: lebarLayar * 0.075),

            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: lebarLayar * 0.153,
                    backgroundColor: const Color(0xFFEAEAEA),
                    backgroundImage: gambarProfil(),
                  ),

                  Positioned(
                    right: 0,
                    bottom: 2,
                    child: GestureDetector(
                      onTap: tampilkanPilihanFoto,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: hijau,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 21,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // KOLOM NAMA
            SizedBox(height: lebarLayar * 0.135),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: TextField(
                controller: namaController,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                decoration: const InputDecoration(
                  hintText: 'Nama Pengguna',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF777777),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    size: 24,
                    color: Color(0xFF858585),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 32,
                    minHeight: 34,
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF777777),
                      width: 1.1,
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
            ),

            // JARAK KE TOMBOL
            SizedBox(height: lebarLayar * 0.225),

            // TOMBOL SIMPAN
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
              ),
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: simpanProfil,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hijau,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'SIMPAN',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}