import 'package:flutter/material.dart';

class CmTextField extends StatelessWidget {
  const CmTextField(
      {super.key,
      required this.title,
      this.width = 150,
      required this.controller});
  final String title;
  final double? width;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 5),
        _getTextField(
          child: CustomPaint(
            painter: _DottedLinePainter(),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _getTextField({required Widget child}) => width == null
      ? Expanded(child: child)
      : SizedBox(width:width, child: child);
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  const _DottedLinePainter({
    this.color = Colors.grey,
    this.strokeWidth = 2.0,
    this.dashWidth = 2.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height), // Start at top of the painter area
        Offset(startX + dashWidth, size.height), // Draw horizontal line
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
