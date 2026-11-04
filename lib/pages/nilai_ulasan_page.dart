import 'package:flutter/material.dart';

class NilaiUlasanPage extends StatefulWidget {
  final Map<String, dynamic>? ulasanBaru;

  const NilaiUlasanPage({
    super.key,
    this.ulasanBaru,
  });

  @override
  State<NilaiUlasanPage> createState() => _NilaiUlasanPageState();
}

class _NilaiUlasanPageState extends State<NilaiUlasanPage> {
  // ============================================================
  // 1. PENGATURAN WARNA DAN TAMPILAN
  // ============================================================

  static const Color warnaHijau = Color(0xFF196858);
  static const Color warnaBiru = Color(0xFF42A5F5);
  static const Color warnaAbu = Color(0xFFD9D9D9);

  String filterAktif = 'Semua';
  int? filterBintang;

  // ============================================================
  // 2. DATA ULASAN
  // Ubah nama, rating, tanggal, ulasan, dan foto di bagian ini.
  // ============================================================

  final List<Map<String, dynamic>> daftarUlasan = [
    {
      'nama': 'Kaisyarani Zahra',
      'rating': 5,
      'tanggal': '23 Februari 2026',
      'ulasan':
          'Pokoknya sangat bagus, tempatnya menyenangkan dan cocok untuk berlibur bersama teman maupun keluarga.',
      'foto': false,
      'sembunyikanNama': false,
      'lengkap': false,
    },
    {
      'nama': 'Kaisyarani Zahra',
      'rating': 5,
      'tanggal': '22 Februari 2026',
      'ulasan':
          'Pokoknya sangat bagus, tempatnya menyenangkan dan cocok untuk berlibur bersama teman maupun keluarga.',
      'foto': true,
      'sembunyikanNama': false,
      'lengkap': false,
    },
    {
      'nama': 'Kaisyarani Zahra',
      'rating': 5,
      'tanggal': '20 Februari 2026',
      'ulasan':
          'Pokoknya sangat bagus, tempatnya menyenangkan dan cocok untuk berlibur bersama teman maupun keluarga.',
      'foto': false,
      'sembunyikanNama': false,
      'lengkap': false,
    },
    {
      'nama': 'Kaisyarani Zahra',
      'rating': 4,
      'tanggal': '18 Februari 2026',
      'ulasan':
          'Tempat wisata menarik dan cocok untuk liburan bersama keluarga. Wahana cukup beragam dan suasananya menyenangkan.',
      'foto': true,
      'sembunyikanNama': false,
      'lengkap': false,
    },
  ];

  // ============================================================
  // MEMASUKKAN ULASAN BARU
  // ============================================================

  @override
  void initState() {
    super.initState();

    if (widget.ulasanBaru != null) {
      daftarUlasan.insert(0, widget.ulasanBaru!);
    }
  }

  // ============================================================
  // 3. PENGOLAHAN DATA ULASAN
  // ============================================================

  // Menghitung rata-rata rating.
  double get rataRataRating {
    if (daftarUlasan.isEmpty) return 0;

    final totalRating = daftarUlasan.fold<int>(
      0,
      (total, ulasan) => total + (ulasan['rating'] as int),
    );

    return totalRating / daftarUlasan.length;
  }

  // Menampilkan ulasan sesuai filter yang dipilih.
  List<Map<String, dynamic>> get ulasanTampil {
    return daftarUlasan.where((ulasan) {
      final cocokFoto =
          filterAktif != 'Dengan Foto' || ulasan['foto'] == true;

      final cocokBintang = filterBintang == null ||
          ulasan['rating'] == filterBintang;

      return cocokFoto && cocokBintang;
    }).toList();
  }

  // Memilih filter.
  void pilihFilter(String filter) {
    setState(() {
      filterAktif = filter;

      if (filter != 'Bintang') {
        filterBintang = null;
      }
    });
  }

  // ============================================================
  // 4. FILTER BERDASARKAN BINTANG
  // ============================================================

  void tampilkanPilihanBintang() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filter berdasarkan bintang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...List.generate(5, (index) {
                  final nilaiBintang = 5 - index;

                  return ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    title: Text('$nilaiBintang bintang'),
                    trailing: filterBintang == nilaiBintang
                        ? const Icon(
                            Icons.check,
                            color: warnaHijau,
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        filterAktif = 'Bintang';
                        filterBintang = nilaiBintang;
                      });

                      Navigator.pop(context);
                    },
                  );
                }),

                TextButton(
                  onPressed: () {
                    setState(() {
                      filterAktif = 'Semua';
                      filterBintang = null;
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Hapus filter'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // 5. TAMPILAN UTAMA HALAMAN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final ulasan = ulasanTampil;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            headerHalaman(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  ringkasanRating(),
                  daftarFilter(),
                  daftarKartuUlasan(ulasan),
                ],
              ),
            ),
            navigasiBawah(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 6. HEADER HALAMAN
  // ============================================================

  Widget headerHalaman() {
    return Container(
      height: 60,
      width: double.infinity,
      color: warnaHijau,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const Text(
            'Nilai & Ulasan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  
  // ============================================================
  // 7. RINGKASAN RATING
  // ============================================================

  Widget ringkasanRating() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ANGKA RATING DAN BINTANG
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 1,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '4.75',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      ...List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // LOGO ECOWALK DI KANAN
                Transform.translate(
                  offset: const Offset(0, 0),
                  child: Image.asset(
                    'lib/images/logo_ecowalk_hijau.png',
                    width: 70,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // JUMLAH ULASAN DI BAWAH RATING
            const Text(
              '24.543 Ulasan',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 8. DAFTAR TOMBOL FILTER
  // ============================================================

  Widget daftarFilter() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            tombolFilter(
              'Semua',
              aktif: filterAktif == 'Semua',
              aksi: () => pilihFilter('Semua'),
            ),

            tombolFilter(
              'Dengan Foto',
              aktif: filterAktif == 'Dengan Foto',
              aksi: () => pilihFilter('Dengan Foto'),
            ),

            tombolFilter(
              filterBintang == null
                  ? 'Bintang ⌄'
                  : '$filterBintang Bintang ⌄',
              aktif: filterAktif == 'Bintang',
              aksi: tampilkanPilihanBintang,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 9. KONTEN DAFTAR ULASAN
  // ============================================================

  Widget daftarKartuUlasan(
    List<Map<String, dynamic>> ulasan,
  ) {
    if (ulasan.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text('Belum ada ulasan untuk filter ini.'),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return kartuUlasan(ulasan[index]);
          },
          childCount: ulasan.length,
        ),
      ),
    );
  }

  // ============================================================
  // 10. KOMPONEN TOMBOL FILTER
  // ============================================================

  Widget tombolFilter(
    String teks, {
    required bool aktif,
    required VoidCallback aksi,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Center(
        child: InkWell(
          onTap: aksi,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: aktif ? warnaHijau : const Color(0xFF267565),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              teks,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // 11. KARTU ULASAN
  // ============================================================

  Widget kartuUlasan(Map<String, dynamic> data) {
    final String isiUlasan = data['ulasan'] as String;
    final bool tampilkanSemua = data['lengkap'] as bool;
    final bool punyaFoto = data['foto'] as bool;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailUlasanPage(data: data),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NAMA PENGULAS DAN RATING
            identitasPengulas(data),

            const SizedBox(height: 12),

            // TEKS ULASAN
            Text(
              isiUlasan,
              maxLines: tampilkanSemua ? null : 3,
              overflow: tampilkanSemua
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                height: 1.5,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 5),

            // TOMBOL SELENGKAPNYA
            GestureDetector(
              onTap: () {
                setState(() {
                  data['lengkap'] = !tampilkanSemua;
                });
              },
              child: const Text(
                'Selengkapnya',
                style: TextStyle(
                  color: warnaBiru,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // FOTO ULASAN
            if (punyaFoto) ...[
              const SizedBox(height: 10),
              fotoUlasan(),
            ],

            const SizedBox(height: 10),

            // TANGGAL ULASAN
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Dinilai pada ${data['tanggal']}',
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  // ============================================================
  // 12. IDENTITAS PENGULAS DAN RATING
  // ============================================================

  Widget identitasPengulas(Map<String, dynamic> data) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 11,
          backgroundColor: warnaAbu,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 14,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            data['sembunyikanNama'] == true
                ? 'Pengguna Anonim'
                : data['nama'] as String,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: warnaHijau,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '${data['rating']}.0 / 5.0',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 13. FOTO ULASAN
  // Ganti bagian ini ketika foto asli sudah tersedia.
  // ============================================================

  Widget fotoUlasan() {
    return Row(
      children: [
        kotakFoto(),
        const SizedBox(width: 10),
        kotakFoto(),
      ],
    );
  }

  Widget kotakFoto() {
    return Container(
      width: 59,
      height: 59,
      color: warnaAbu,
      child: const Icon(
        Icons.image_outlined,
        color: Colors.white,
      ),
    );
  }

  // ============================================================
  // 14. NAVIGASI BAWAH
  // ============================================================

  Widget navigasiBawah() {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.crop_square,
              color: warnaBiru,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.crop_square,
              color: warnaBiru,
            ),
          ),
        ],
      ),
    );
  }
}


class DetailUlasanPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailUlasanPage({
    super.key,
    required this.data,
  });

  static const Color warnaHijau = Color(0xFF196858);
  static const Color warnaAbu = Color(0xFFD9D9D9);
  static const Color warnaBiru = Color(0xFF42A5F5);

  // ============================================================
  // 1. HEADER
  // ============================================================

  Widget header(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      color: warnaHijau,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 23,
            ),
          ),
          const Text(
            'Nilai & Ulasan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 2. IDENTITAS PENGULAS
  // ============================================================

  Widget identitasPengulas() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 15,
          backgroundColor: warnaAbu,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 19,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            data['sembunyikanNama'] == true
                ? 'Pengguna Anonim'
                : data['nama'] as String,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: warnaHijau,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '${data['rating']}.0 / 5.0',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 3. FOTO ULASAN
  // ============================================================

  Widget fotoUlasan() {
    return Row(
      children: [
        kotakFoto(),
        const SizedBox(width: 10),
        kotakFoto(),
      ],
    );
  }

  Widget kotakFoto() {
    return Container(
      width: 59,
      height: 59,
      color: warnaAbu,
      child: const Icon(
        Icons.image_outlined,
        color: Colors.white,
      ),
    );
  }

  // ============================================================
  // 4. DETAIL ISI ULASAN
  // ============================================================

  Widget isiDetailUlasan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 19, 26, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          identitasPengulas(),

          const SizedBox(height: 15),

          Text(
            data['ulasan'] as String,
            style: const TextStyle(
              fontSize: 9,
              height: 1.6,
              color: Colors.black,
            ),
          ),

          if (data['foto'] == true) ...[
            const SizedBox(height: 17),
            fotoUlasan(),
          ],

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Dinilai pada ${data['tanggal']}',
              style: const TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 35),

          const Divider(
            color: Color(0xFFE0E0E0),
            thickness: 0.8,
          ),
        ],
      ),
    );
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          // HEADER
          header(context),

          // KONTEN DETAIL ULASAN
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: isiDetailUlasan(),
            ),
          ),
        ],
      ),
    ),
  );
}
}
