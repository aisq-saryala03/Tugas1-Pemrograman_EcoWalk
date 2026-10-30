import 'package:flutter/material.dart';

class BeriUlasanPage extends StatefulWidget {
  const BeriUlasanPage({super.key});

  @override
  State<BeriUlasanPage> createState() => _BeriUlasanPageState();
}

class _BeriUlasanPageState extends State<BeriUlasanPage> {
  static const Color hijau = Color(0xFF1B6B5B);

  int rating = 0;
  bool sembunyikanNama = false;

  final TextEditingController ulasanController =
      TextEditingController();

  @override
  void dispose() {
    ulasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 63,
              width: double.infinity,
              color: hijau,
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
                    'Beri Ulasan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Isi halaman
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto wisata
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                          child: SizedBox(
                            height: 140,
                            width: double.infinity,
                            child: Image.asset(
                              'lib/images/image 1.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.image,
                                    size: 45,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),


                        Positioned(
                          right: 24,
                          bottom: -18,
                          child: Container(
                            width: 116,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: hijau,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              'Dunia Fantasi\n(DUFAN)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Sapaan
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hai, Kaisyarani !',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'bagaimana perjalananmu?',
                            style: TextStyle(fontSize: 15,
                             fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Rating bintang
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          ...List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  rating = index + 1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 5,
                                ),
                                child: Icon(
                                  index < rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 39,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }),
                          const SizedBox(width: 2),
                          Text(
                            rating == 0
                                ? 'Bagus'
                                : [
                                    '',
                                    'Buruk',
                                    'Kurang',
                                    'Cukup',
                                    'Bagus',
                                    'Sangat Bagus'
                                  ][rating],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 17),

                    // Kolom ulasan
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: TextField(
                        controller: ulasanController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Ketik ulasan ...',
                          hintStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tambah gambar
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Tambahkan Gambar?',
                        style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 71,
                            height: 71,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Fitur pilih gambar belum dihubungkan',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 71,
                            height: 71,
                            color: Colors.grey.shade200,
                            child: Image.asset(
                              'lib/images/image 1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sembunyikan nama
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: Checkbox(
                              value: sembunyikanNama,
                              activeColor: hijau,
                              onChanged: (value) {
                                setState(() {
                                  sembunyikanNama = value ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Sembunyikan Nama Pengguna',
                            style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tombol kirim
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 53,
                        child: ElevatedButton(
                          onPressed: () {
                            if (rating == 0) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Silakan pilih rating bintang terlebih dahulu',
                                  ),
                                ),
                              );
                              return;
                            }

                            Navigator.pop(context, {
                              'rating': rating,
                              'ulasan': ulasanController.text,
                              'sembunyikanNama': sembunyikanNama,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hijau,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Kirim',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Navigasi bawah
            Container(
              height: 58,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFEEEEEE)),
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
          ],
        ),
      ),
    );
  }
}
