import 'package:flutter/material.dart';

class FilterWisataPage extends StatefulWidget {
  const FilterWisataPage({super.key});

  @override
  State<FilterWisataPage> createState() => _FilterWisataPageState();
}

class _FilterWisataPageState extends State<FilterWisataPage> {
  static const Color hijau = Color(0xFF196657);

  double jarak = 500;
  String pilihanJarak = '500 M';
  String? pilihanHarga;
  final Set<String> lokasiDipilih = {};
  final Set<String> zonaDipilih = {};

  final TextEditingController minimalController =
      TextEditingController(text: '100.000,00');
  final TextEditingController maksimalController =
      TextEditingController(text: '99.999.999,00');

  void resetFilter() {
    setState(() {
      jarak = 500;
      pilihanJarak = '500 M';
      pilihanHarga = null;
      lokasiDipilih.clear();
      zonaDipilih.clear();
      minimalController.text = '100.000,00';
      maksimalController.text = '99.999.999,00';
    });
  }

  @override
  void dispose() {
    minimalController.dispose();
    maksimalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 18),

          // Garis kecil bagian atas
          Container(
            width: 98,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Judul Filter
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
            child: Row(
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: resetFilter,
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 21),
                ),
              ],
            ),
          ),

          // Isi filter dapat digulir
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const Divider(height: 1, color: Color(0xFFE7E7E7)),

                // RENTANG JARAK
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rentang Jarak',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _tombolJarak('500 M'),
                          const SizedBox(width: 6),
                          _tombolJarak('Terdekat'),
                          const SizedBox(width: 6),
                          _tombolJarak('Terjauh'),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: hijau,
                          inactiveTrackColor: Colors.grey.shade400,
                          thumbColor: hijau,
                          overlayColor: hijau.withValues(alpha: 0.12),
                          trackHeight: 2,
                        ),
                        child: Slider(
                          value: jarak,
                          min: 0,
                          max: 10000,
                          onChanged: (value) {
                            setState(() {
                              jarak = value;
                              pilihanJarak = '${value.round()} M';
                            });
                          },
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Terdekat',
                            style: TextStyle(fontSize: 9,
                            fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Terjauh',
                            style: TextStyle(fontSize: 9,
                            fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFE7E7E7)),

                // RENTANG HARGA
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rentang Harga',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _kolomHarga(
                              'Minimal',
                              minimalController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _kolomHarga(
                              'Maksimal',
                              maksimalController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: _tombolHarga('< Rp 50.000,00'),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _tombolHarga('< Rp 100.000,00'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _tombolHarga('< Rp 300.000,00'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _tombolHarga('Gratis'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFE7E7E7)),

                // LOKASI POPULER
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lokasi Populer',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...[
                        'Blok M',
                        'Gelora Bung Karno',
                        'Senayan',
                        'Citra Delapan',
                      ].map(
                        (lokasi) => InkWell(
                          onTap: () {
                            setState(() {
                              if (lokasiDipilih.contains(lokasi)) {
                                lokasiDipilih.remove(lokasi);
                              } else {
                                lokasiDipilih.add(lokasi);
                              }
                            });
                          },
                          child: SizedBox(
                            height: 28,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    lokasi,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Icon(
                                  lokasiDipilih.contains(lokasi)
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: hijau,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ZONA
                      const Text(
                        'Zona',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _tombolZona(
                            'Dalam Ruangan',
                            Icons.roofing_outlined,
                          ),
                          const SizedBox(width: 14),
                          _tombolZona(
                            'Luar Ruangan',
                            Icons.sports_soccer,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tombol Terapkan
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'jarak': jarak,
                      'harga': pilihanHarga,
                      'minimal': minimalController.text,
                      'maksimal': maksimalController.text,
                      'lokasi': lokasiDipilih.toList(),
                      'zona': zonaDipilih.toList(),
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hijau,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Terapkan Filter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tombolJarak(String teks) {
    final aktif = pilihanJarak == teks;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            pilihanJarak = teks;
            if (teks == '500 M') jarak = 500;
            if (teks == 'Terdekat') jarak = 0;
            if (teks == 'Terjauh') jarak = 10000;
          });
        },
        child: Container(
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: aktif ? hijau : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: hijau),
          ),
          child: Text(
            teks,
            style: TextStyle(
              fontSize: 10,
              color: aktif ? Colors.white : hijau,
            ),
          ),
        ),
      ),
    );
  }

  Widget _kolomHarga(
    String label,
    TextEditingController controller,
  ) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: hijau,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tombolHarga(String teks) {
    final aktif = pilihanHarga == teks;

    return GestureDetector(
      onTap: () {
        setState(() {
          pilihanHarga = teks;
          if (teks == 'Gratis') {
            minimalController.text = '0';
            maksimalController.text = '0';
          } else {
            minimalController.text = '0';
            maksimalController.text =
                teks.replaceAll(RegExp(r'[^0-9]'), '');
          }
        });
      },
      child: Container(
        height: 29,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: aktif ? hijau : Colors.white,
          border: Border.all(color: aktif ? hijau : Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          teks,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: aktif ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _tombolZona(String teks, IconData ikon) {
    final aktif = zonaDipilih.contains(teks);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (aktif) {
            zonaDipilih.remove(teks);
          } else {
            zonaDipilih.add(teks);
          }
        });
      },
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: aktif ? hijau.withValues(alpha: 0.1) : Colors.white,
          border: Border.all(
            color: aktif ? hijau : const Color(0xFFBDBDBD),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ikon, size: 20),
            const SizedBox(height: 5),
            Text(
              teks,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 7),
            ),
          ],
        ),
      ),
    );
  }
}



class UrutkanWisataSheet extends StatefulWidget {
  final String urutanAwal;

  const UrutkanWisataSheet({
    super.key,
    this.urutanAwal = 'rekomendasi',
  });

  @override
  State<UrutkanWisataSheet> createState() =>
      _UrutkanWisataSheetState();
}

class _UrutkanWisataSheetState
    extends State<UrutkanWisataSheet> {
  late String pilihan;

  final List<Map<String, String>> opsi = [
    {
      'label': 'Direkomendasikan',
      'value': 'rekomendasi',
    },
    {
      'label': 'Harga Tertinggi',
      'value': 'harga_tertinggi',
    },
    {
      'label': 'Harga Terendah',
      'value': 'harga_terendah',
    },
    {
      'label': 'Ulasan Terbaik',
      'value': 'ulasan',
    },
    {
      'label': 'Jarak Terdekat',
      'value': 'jarak',
    },
  ];

  @override
  void initState() {
    super.initState();
    pilihan = widget.urutanAwal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),

            // Garis kecil di bagian atas panel
            Container(
              width: 98,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 10),

            // Judul dan tombol tutup
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16, 0, 8, 10,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Urutkan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Color(0xFFE7E7E7),
            ),

            // Pilihan urutan
            ...opsi.map((item) {
              final aktif = pilihan == item['value'];

              return InkWell(
                onTap: () {
                  setState(() {
                    pilihan = item['value']!;
                  });

                  Navigator.pop(context, pilihan);
                },
                child: SizedBox(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['label']!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          width: 19,
                          height: 19,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: aktif
                                ? const Color(0xFF1A6556)
                                : const Color(0xFFF2F2F2),
                            border: Border.all(
                              color: const Color(0xFF1A6556),
                              width: 1,
                            ),
                          ),
                          child: aktif
                              ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}