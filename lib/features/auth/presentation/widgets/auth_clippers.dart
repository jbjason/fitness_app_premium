import 'package:flutter/material.dart';

class AuthClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    final h = size.height, w = size.width;
    path.moveTo(8, 4);
    path.lineTo(w + 4, -4);
    path.lineTo(w - 8, h - 4);
    path.lineTo(-4, h + 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
