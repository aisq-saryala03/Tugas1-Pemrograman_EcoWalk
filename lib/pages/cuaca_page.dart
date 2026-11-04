import 'package:flutter/material.dart';

class CuacaPage extends StatelessWidget {
  const CuacaPage({super.key});

  static const Color hijau = Color(0xFF1A6556);
  static const Color latar = Color(0xFFD1E0DD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,

      // HEADER
      appBar: AppBar(
        toolbarHeight: 54,
        backgroundColor: hijau,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cuaca',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),

      // ISI HALAMAN
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // JUDUL PRAKIRAAN CUACA
            const Text(
              'Prakiraan Cuaca',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'Klapanunggal, Bogor',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),

            // SUHU DAN GAMBAR CUACA
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, -64),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '30°C',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Cerah Berawan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -87),
                  child: Image.asset(
                    'lib/images/image 3.png',
                    width: 210,
                    height: 245,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            // KELEMBAPAN DAN KUALITAS UDARA
            Transform.translate(
              offset: const Offset(0, -115),
              child: Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      icon: Icons.water_drop_outlined,
                      label: 'Kelembapan',
                      value: '92%',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _infoCard(
                      icon: Icons.air,
                      label: 'Kualitas Udara',
                      value: '39.1',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // =====================================
            // PRAKIRAAN CUACA PER JAM
            // =====================================

            Transform.translate(
              offset: const Offset(0, -100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hari ini',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // GAMBAR BISA DIGESER KE SAMPING
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Image.asset(
                          'lib/images/Frame 10.png',
                          width: MediaQuery.of(context).size.width - 32,
                          height: 90,
                          fit: BoxFit.fill,
                        ),

                        const SizedBox(width: 10),

                        Image.asset(
                          'lib/images/Frame 10.png',
                          width: MediaQuery.of(context).size.width - 32,
                          height: 90,
                          fit: BoxFit.fill,
                        ),

                        const SizedBox(width: 10),

                        Image.asset(
                          'lib/images/Frame 10.png',
                          width: MediaQuery.of(context).size.width - 32,
                          height: 90,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 31),

            // PRAKIRAAN HARI INI DAN BESOK
            Transform.translate(
              offset: const Offset(0, -100),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'lib/images/Group 5.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // AKTIVITAS HARIAN
            Transform.translate(
              offset: const Offset(0, -100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aktivitas Harian',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const _AktivitasCuaca(
                    icon: Icons.sentiment_satisfied_alt_outlined,
                    teks: 'Berjalan-jalan adalah pilihan terbaik saat ini !',
                    subteks: 'Lihat Destinasi Wisata',
                    warnaSubteks: Color(0xFF1F99D1),
                  ),

                  const SizedBox(height: 12),

                  const _AktivitasCuaca(
                    icon: Icons.umbrella_outlined,
                    teks: 'Jangan lupa bawa payung untuk berjaga-jaga',
                  ),

                  const SizedBox(height: 12),

                  const _AktivitasCuaca(
                    icon: Icons.home_outlined,
                    teks: 'Aktivitas outdoor direkomendasikan',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // KARTU KELEMBAPAN DAN KUALITAS UDARA
  static Widget _infoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      height: 67,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: hijau,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 12,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// AKTIVITAS HARIAN
class _AktivitasCuaca extends StatelessWidget {
  final IconData icon;
  final String teks;
  final String? subteks;
  final Color warnaSubteks;

  const _AktivitasCuaca({
    required this.icon,
    required this.teks,
    this.subteks,
    this.warnaSubteks = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teks,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  height: 1.6,
                ),
              ),
              if (subteks != null) ...[
                const SizedBox(height: 2),
                Text(
                  subteks!,
                  style: TextStyle(
                    color: warnaSubteks,
                    fontSize: 8,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
