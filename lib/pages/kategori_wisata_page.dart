import 'package:flutter/material.dart';
import '../pages/filter_wisata_page.dart';
import '../pages/detail_wisata_page.dart';

const Color hijauEco = Color(0xFF196657);

class KategoriWisataPage extends StatefulWidget {
  const KategoriWisataPage({super.key});

  @override
  State<KategoriWisataPage> createState() =>
      _KategoriWisataPageState();
}

class _KategoriWisataPageState extends State<KategoriWisataPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String kategoriTerpilih = 'Semua';
  String kataKunci = '';
  String urutanAktif = 'default';

  Map<String, dynamic> filterAktif = {};

  final List<String> kategori = [
    'Semua',
    'Kuliner',
    'Sejarah',
    'Alam',
    'Religi',
    'Seni',
  ];

  final List<Map<String, dynamic>> destinasi = [
    {
      'nama': 'Dunia Fantasi (DUFAN)',
      'rating': 4.75,
      'lokasi': 'Ancol, Jakarta utara',
      'jam': '10:00 - 22:00',
      'harga': 200000,
      'kategori': 'Seni',
    },
    {
      'nama': 'Taman Mini Indonesia Indah',
      'rating': 4.70,
      'lokasi': 'Jakarta Timur',
      'jam': '06:00 - 17:00',
      'harga': 35000,
      'kategori': 'Sejarah',
    },
    {
      'nama': 'Kota Tua Jakarta',
      'rating': 4.60,
      'lokasi': 'Jakarta Barat',
      'jam': '08:00 - 21:00',
      'harga': 0,
      'kategori': 'Sejarah',
    },
    {
      'nama': 'Ragunan Zoo',
      'rating': 4.50,
      'lokasi': 'Jakarta Selatan',
      'jam': '07:00 - 16:00',
      'harga': 4000,
      'kategori': 'Alam',
    },
    {
      'nama': 'Monumen Nasional (Monas)',
      'rating': 4.65,
      'lokasi': 'Jakarta Pusat',
      'jam': '08:00 - 16:00',
      'harga': 20000,
      'kategori': 'Sejarah',
    },
    {
      'nama': 'Jakarta Aquarium Safari',
      'rating': 4.80,
      'lokasi': 'Jakarta Barat',
      'jam': '10:00 - 21:00',
      'harga': 150000,
      'kategori': 'Alam',
    },
  ];

  List<Map<String, dynamic>> get destinasiTampil {
    final hasil = destinasi.where((item) {
      final cocokKategori = kategoriTerpilih == 'Semua' ||
          item['kategori'] == kategoriTerpilih;

      final nama = item['nama'].toString().toLowerCase();
      final lokasi = item['lokasi'].toString().toLowerCase();
      final cari = kataKunci.toLowerCase();

      return cocokKategori &&
          (nama.contains(cari) || lokasi.contains(cari));
    }).toList();

    if (urutanAktif == 'harga') {
      hasil.sort(
        (a, b) =>
            (a['harga'] as int).compareTo(b['harga'] as int),
      );
    } else if (urutanAktif == 'rating') {
      hasil.sort(
        (a, b) => (b['rating'] as double)
            .compareTo(a['rating'] as double),
      );
    }

    return hasil;
  }

  String formatHarga(int harga) {
    if (harga == 0) return 'Gratis';

    final angka = harga.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < angka.length; i++) {
      buffer.write(angka[i]);

      final sisa = angka.length - i - 1;
      if (sisa > 0 && sisa % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp. ${buffer.toString()}';
  }

  Future<void> bukaFilter() async {
    final hasil = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterWisataPage(),
    );

    if (hasil != null) {
      setState(() {
        filterAktif = hasil;
      });
    }
  }

  Future<void> bukaUrutan() async {
    final hasil = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) => UrutkanWisataSheet(
        urutanAwal: urutanAktif,
      ),
    );

    if (hasil != null) {
      setState(() {
        urutanAktif = hasil;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasilWisata = destinasiTampil;

    return Scaffold(
      backgroundColor: Colors.white,

      // HEADER, PENCARIAN, TAB, DAN DAFTAR
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 63,
              width: double.infinity,
              color: hijauEco,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // PENCARIAN, FILTER, URUTKAN
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 17, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBFBFB),
                        border: Border.all(
                          color: const Color(0xFFDDDDDD),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            kataKunci = value;
                          });
                        },
                        style: const TextStyle(fontSize: 11),
                        decoration: const InputDecoration(
                          hintText: 'Cari destinasi wisata',
                          hintStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 18,
                            fontWeight: FontWeight.w700,
                            color: hijauEco,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // FILTER
                  InkWell(
                    onTap: bukaFilter,
                    child: const SizedBox(
                      width: 40,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.tune,
                            color: hijauEco,
                            size: 25,
                          ),
                          Text(
                            'Filter',
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // URUTKAN
                  InkWell(
                    onTap: bukaUrutan,
                    child: SizedBox(
                      width: 42,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.sort,
                            color: hijauEco,
                            size: 26,
                          ),
                          Text(
                            urutanAktif == 'harga'
                                ? 'Harga'
                                : urutanAktif == 'rating'
                                    ? 'Rating'
                                    : 'Urutkan',
                            style: const TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // TAB KATEGORI
            SizedBox(
              height: 41,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: kategori.length,
                itemBuilder: (context, index) {
                  final nama = kategori[index];
                  final aktif = kategoriTerpilih == nama;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        kategoriTerpilih = nama;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: aktif
                                ? hijauEco
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        nama,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: aktif
                              ? FontWeight.w700
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE5E5E5),
            ),

            // DAFTAR DESTINASI
            Expanded(
              child: hasilWisata.isEmpty
                  ? const Center(
                      child: Text(
                        'Destinasi wisata tidak ditemukan',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: hasilWisata.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailWisataPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                'lib/images/Group 4.png',
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // NAVIGASI BAWAH
      bottomNavigationBar: Container(
        height: 52,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFF1F1F1),
            ),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.crop_square,
              color: Colors.blue,
              size: 24,
            ),
            Icon(
              Icons.crop_square,
              color: Colors.blue,
              size: 24,
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
    required this.urutanAwal,
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
            // Garis kecil bagian atas
            const SizedBox(height: 15),
            Container(
              width: 98,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            // Judul dan tombol tutup
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16, 12, 8, 8,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Urutkan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
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

            // Daftar pilihan pengurutan
            ...opsi.map((item) {
              final aktif = pilihan == item['value'];

              return InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                    item['value'],
                  );
                },
                child: SizedBox(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
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

                        // Lingkaran pilihan
                        Container(
                          width: 19,
                          height: 19,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF196657),
                              width: 1,
                            ),
                          ),
                          child: aktif
                              ? Center(
                                  child: Container(
                                    width: 9,
                                    height: 9,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF196657),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
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
