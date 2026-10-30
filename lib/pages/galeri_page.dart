import 'package:flutter/material.dart';
import '../utils/konstanta.dart';

class GaleriPage extends StatelessWidget {
  const GaleriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> daftarFoto = [
      imgFoto,
      'lib/images/background.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF176D5B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pilih Foto',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarFoto.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),

        itemBuilder: (context, index) {
          final foto = daftarFoto[index];

          return GestureDetector(
            onTap: () {
              Navigator.pop(context, foto);
            },

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                foto,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
