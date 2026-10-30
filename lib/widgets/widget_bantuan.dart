
import 'package:flutter/material.dart';
import '../utils/konstanta.dart';

// ============ LOGO ============

Widget logo(String path, double lebar, Color warna, {double isi = 1.0}) {
  return ClipRect(
    child: Align(
      widthFactor: isi,
      child: Image.asset(
        path,
        width: lebar,
        errorBuilder: (context, error, stack) {
          debugPrint('ERROR GAMBAR: $error');

          final gaya = TextStyle(
            color: warna,
            fontSize: lebar / 6,
            fontWeight: FontWeight.w900,
          );

          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ECOWA', style: gaya),
              Icon(
                Icons.directions_run,
                color: warna,
                size: lebar / 5,
              ),
              Text('K', style: gaya),
            ],
          );
        },
      ),
    ),
  );
}

// ============ KOLOM ISIAN ============

class KolomIsian extends StatefulWidget {
  final String hint;
  final IconData? ikon;
  final bool sandi;
  final bool garis;
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const KolomIsian({
    super.key,
    required this.hint,
    required this.ikon,
    this.sandi = false,
    this.garis = false,
    this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  State<KolomIsian> createState() => _KolomIsianState();
}

class _KolomIsianState extends State<KolomIsian> {
  late bool tersembunyi;

  @override
  void initState() {
    super.initState();
    tersembunyi = widget.sandi;
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder border = widget.garis
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1.2),
          );

    final InputBorder borderError = widget.garis
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red.shade400),
          );

    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: tersembunyi,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 13,
          fontStyle: FontStyle.italic,
          color: Colors.grey.shade600,
        ),
        errorText: widget.errorText,
        errorStyle: TextStyle(
          fontSize: 10,
          color: Colors.red.shade600,
        ),
        prefixIcon: widget.ikon == null
            ? null
            : Icon(
                widget.ikon,
                size: 18,
                color: Colors.grey.shade700,
              ),
        suffixIcon: widget.sandi
            ? IconButton(
                onPressed: () {
                  setState(() {
                    tersembunyi = !tersembunyi;
                  });
                },
                icon: Icon(
                  tersembunyi
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 18,
                  color: Colors.grey.shade700,
                ),
              )
            : null,
        filled: !widget.garis,
        fillColor: abu,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border,
        enabledBorder: border,
        errorBorder: borderError,
        focusedErrorBorder: borderError,
        focusedBorder: widget.garis
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: hijau),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: hijau),
              ),
      ),
    );
  }
}

// ============ FUNGSI KOLOM INPUT ============

Widget kolom(
  String hint,
  IconData ikon, {
  bool sandi = false,
  TextEditingController? controller,
  String? errorText,
  ValueChanged<String>? onChanged,
}) {
  return KolomIsian(
    hint: hint,
    ikon: ikon,
    sandi: sandi,
    controller: controller,
    errorText: errorText,
    onChanged: onChanged,
  );
}

Widget kolomGaris(
  String hint,
  IconData? ikon, {
  bool sandi = false,
}) {
  return KolomIsian(
    hint: hint,
    ikon: ikon,
    sandi: sandi,
    garis: true,
  );
}

// ============ TOMBOL ============

Widget tombol(
  String teks,
  VoidCallback aksi, {
  FontWeight berat = FontWeight.bold,
}) {
  return SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton(
      onPressed: aksi,
      style: ElevatedButton.styleFrom(
        backgroundColor: hijau,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        teks,
        style: TextStyle(fontWeight: berat),
      ),
    ),
  );
}

// ============ JUDUL DAN LOGO ============

Widget judul(
  String teks, {
  bool kiri = false,
  double jarak = 3,
  double lebarLogo = 200,
  double ukuranTeks = 20,
  bool samaLebar = false,
  double tebal = 0.3,
  double isiLogo = 1.0,
}) {
  final tulisan = Text(
    teks,
    style: TextStyle(
      color: hijau,
      fontSize: ukuranTeks,
      fontWeight: FontWeight.w900,
      letterSpacing: jarak,
      shadows: [
        Shadow(color: hijau, offset: Offset(tebal, 0)),
        Shadow(color: hijau, offset: Offset(-tebal, 0)),
        Shadow(color: hijau, offset: Offset(0, tebal)),
        Shadow(color: hijau, offset: Offset(0, -tebal)),
      ],
    ),
  );

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment:
        kiri ? CrossAxisAlignment.start : CrossAxisAlignment.center,
    children: [
      samaLebar
          ? SizedBox(
              width: lebarLogo * isiLogo,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: tulisan,
              ),
            )
          : tulisan,
      const SizedBox(height: 4),
      logo(imgLogoHijau, lebarLogo, hijau, isi: isiLogo),
    ],
  );
}

// ============ HEADER ============

class PotongMiring extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height * 0.55)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Widget header([String sub = '']) {
  return ClipPath(
    clipper: PotongMiring(),
    child: Container(
      width: double.infinity,
      height: 220,
      color: const Color(0xFFDAE6E3),
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo(imgLogoHijau, 200, hijau),
          if (sub != '')
            Text(
              sub,
              style: const TextStyle(
                color: hijau,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
        ],
      ),
    ),
  );
}
