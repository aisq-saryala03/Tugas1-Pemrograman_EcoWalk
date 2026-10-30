import 'package:flutter/material.dart';

class CuacaPage extends StatelessWidget {
  const CuacaPage({super.key});

  static const Color hijau = Color(0xFF1A6556);
  static const Color latar = Color(0xFFD1E0DD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
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
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Prakiraan Cuaca',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Klapanunggal, Bogor',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),

              // Suhu dan ikon cuaca
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '30°C',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
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
                  Image.asset(
                    'lib/images/cuaca.png',
                    width: 105,
                    height: 105,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Informasi kelembapan dan kualitas udara
              Row(
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
              const SizedBox(height: 22),

              const Text(
                'Hari ini',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),

              // Prakiraan cuaca per jam
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final jam = [
                      'Sekarang',
                      '07:00',
                      '10:00',
                      '13:00',
                      '16:00',
                      '19:00',
                      '22:00',
                    ][index];

                    return Container(
                      width: 78,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE7E7E7),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/cuaca.png',
                            width: 34,
                            height: 34,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '30°C',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            jam,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Prakiraan hari ini dan besok
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    _PrakiraanHarian(
                      hari: 'Hari Ini',
                      suhu: '30°C / 20°C',
                    ),
                    SizedBox(height: 10),
                    _PrakiraanHarian(
                      hari: 'Besok',
                      suhu: '30°C / 20°C',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Aktivitas harian
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
                icon: Icons.sentiment_satisfied_alt,
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
      ),
    );
  }

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

class _PrakiraanHarian extends StatelessWidget {
  final String hari;
  final String suhu;

  const _PrakiraanHarian({
    required this.hari,
    required this.suhu,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 78,
          child: Text(
            hari,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
        Image.asset(
          'lib/images/cuaca.png',
          width: 23,
          height: 23,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 22),
        const Expanded(
          child: Text(
            'Cerah Berawan',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          suhu,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

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