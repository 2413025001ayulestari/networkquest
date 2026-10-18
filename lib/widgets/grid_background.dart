part of '../main.dart';

class GridBackground extends StatelessWidget {
  final Widget child;

  const GridBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: GridPainter(),
          ),
        ),
        SafeArea(
          child: child,
        ),
      ],
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = const Color(0xFF153653)
      ..strokeWidth = 1;

    for (double x = 0; x < s.width; x += 32) {
      c.drawLine(
        Offset(x, 0),
        Offset(x, s.height),
        p,
      );
    }

    for (double y = 0; y < s.height; y += 32) {
      c.drawLine(
        Offset(0, y),
        Offset(s.width, y),
        p,
      );
    }

    final glow = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0x3321D4FD),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            s.width * .82,
            s.height * .18,
          ),
          radius: 220,
        ),
      );

    c.drawCircle(
      Offset(
        s.width * .82,
        s.height * .18,
      ),
      220,
      glow,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}