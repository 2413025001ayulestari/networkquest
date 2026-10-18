part of '../main.dart';

class MapScreen extends StatefulWidget {
  final GameStore store;

  const MapScreen({
    super.key,
    required this.store,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController mascotAnimation;
  late ScrollController scrollController;

  // ============================================================
  // POSISI LEVEL
  // Level 1 paling bawah → Level 7 paling atas
  // ============================================================

  final List<double> levelY = [
    930,
    800,
    670,
    540,
    410,
    280,
    150,
  ];

  final List<double> levelX = [
    0.50,
    0.68,
    0.35,
    0.67,
    0.32,
    0.65,
    0.48,
  ];

  @override
  void initState() {
    super.initState();

    mascotAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    scrollController = ScrollController();

    widget.store.addListener(refresh);

    // Saat pertama masuk, langsung tampilkan bagian bawah
    // supaya LEVEL 1 terlihat.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.store.removeListener(refresh);
    mascotAnimation.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // GAMBAR MASKOT YANG DIPILIH
  // ============================================================

  String get mascotImage {
    if (widget.store.mascot == 'PIXEL') {
      return 'assets/images/Foto Pixel.png';
    }

    return 'assets/images/Foto Netto.png';
  }

  // ============================================================
  // ICON LEVEL
  // ============================================================

  IconData getLevelIcon(int index) {
    switch (index) {
      case 0:
        return Icons.router_rounded;

      case 1:
        return Icons.account_tree_rounded;

      case 2:
        return Icons.numbers_rounded;

      case 3:
        return Icons.wifi_tethering_rounded;

      case 4:
        return Icons.build_circle_rounded;

      case 5:
        return Icons.hub_rounded;

      case 6:
        return Icons.emoji_events_rounded;

      default:
        return Icons.device_hub_rounded;
    }
  }

  // ============================================================
  // WARNA LEVEL
  // ============================================================

  Color levelColor(int index, bool locked) {
    if (locked) {
      return const Color(0xFF18344B);
    }

    if (index == 6) {
      return const Color(0xFFB8FF2C);
    }

    return const Color(0xFF21D4FD);
  }

  // ============================================================
  // BUKA LEVEL
  // ============================================================

  Future<void> openLevel(int level) async {
    final locked = level > widget.store.unlocked;

    if (locked) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          store: widget.store,
          level: level,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});

    // Setelah level selesai, arahkan kamera ke level terbaru.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToCurrentLevel();
    });
  }

  // ============================================================
  // SCROLL KE LEVEL YANG SUDAH TERBUKA
  // ============================================================

  void scrollToCurrentLevel() {
    if (!scrollController.hasClients) {
      return;
    }

    final currentLevel =
        (widget.store.unlocked - 1).clamp(0, 6);

    final targetY = levelY[currentLevel] - 180;

    final maxScroll =
        scrollController.position.maxScrollExtent;

    final scrollTarget = (levelY[0] - targetY)
        .clamp(0.0, maxScroll);

    scrollController.animateTo(
      scrollTarget,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLevel =
        (widget.store.unlocked - 1).clamp(0, 6);

    return Scaffold(
      body: GridBackground(
        child: Column(
          children: [
            // ==================================================
            // HEADER
            // ==================================================

            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  12,
                  18,
                  8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PETA PETUALANGAN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Ikuti jalur jaringan sampai ke puncak',
                            style: TextStyle(
                              color: Color(0xFF8FAFC5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ScoreChip(
                      score: widget.store.totalScore,
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // PETA
            // ==================================================

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: 1080,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;

                      return Stack(
                        children: [
                          // ====================================
                          // JALAN PETA
                          // ====================================

                          Positioned.fill(
                            child: CustomPaint(
                              painter: NetworkMapPainter(
                                levelY: levelY,
                                levelX: levelX,
                              ),
                            ),
                          ),

                          // ====================================
                          // DEKORASI JARINGAN
                          // ====================================

                          const Positioned(
                            left: 24,
                            top: 850,
                            child: NetworkDecoration(
                              icon: Icons.router_rounded,
                              label: 'ROUTER',
                            ),
                          ),

                          const Positioned(
                            right: 25,
                            top: 700,
                            child: NetworkDecoration(
                              icon: Icons.wifi_rounded,
                              label: 'WI-FI',
                            ),
                          ),

                          const Positioned(
                            left: 24,
                            top: 470,
                            child: NetworkDecoration(
                              icon: Icons.cable_rounded,
                              label: 'CABLE',
                            ),
                          ),

                          const Positioned(
                            right: 24,
                            top: 300,
                            child: NetworkDecoration(
                              icon: Icons.dns_rounded,
                              label: 'SERVER',
                            ),
                          ),

                          const Positioned(
                            left: 22,
                            top: 190,
                            child: NetworkDecoration(
                              icon: Icons.lan_rounded,
                              label: 'NETWORK',
                            ),
                          ),

                          // ====================================
                          // LABEL START
                          // ====================================

                          Positioned(
                            left: width * 0.5 - 50,
                            top: 1000,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF102A43),
                                borderRadius:
                                    BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      const Color(0xFF21D4FD),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.flag_rounded,
                                    size: 16,
                                    color: Color(0xFF21D4FD),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'START',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeight.w900,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ====================================
                          // SEMUA LEVEL
                          // ====================================

                          for (int i = 0; i < 7; i++)
                            _buildLevel(
                              context,
                              i,
                              width,
                            ),

                          // ====================================
                          // MASKOT BERGERAK
                          // ====================================

                          AnimatedBuilder(
                            animation: mascotAnimation,
                            builder: (context, child) {
                              final bounce =
                                  sin(
                                        mascotAnimation.value *
                                            pi,
                                      ) *
                                      10;

                              final x =
                                  width * levelX[currentLevel];

                              final y =
                                  levelY[currentLevel] -
                                      78 -
                                      bounce;

                              return Positioned(
                                left: x - 42,
                                top: y,
                                child: child!,
                              );
                            },
                            child: _buildMascot(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            // ==================================================
            // PROGRESS
            // ==================================================

            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: widget.store.stars
                                .where((e) => e > 0)
                                .length /
                            7,
                        minHeight: 8,
                        color: const Color(0xFF21D4FD),
                        backgroundColor:
                            const Color(0xFF18344B),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${widget.store.stars.where((e) => e > 0).length}/7',
                      style: const TextStyle(
                        color: Color(0xFF21D4FD),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LEVEL CARD / NODE
  // ============================================================

  Widget _buildLevel(
    BuildContext context,
    int index,
    double width,
  ) {
    final level = index + 1;

    final locked = level > widget.store.unlocked;
    final stars = widget.store.stars[index];

    final x = width * levelX[index];
    final y = levelY[index];

    final isFinal = index == 6;

    return Positioned(
      left: x - 65,
      top: y - 65,
      child: GestureDetector(
        onTap: locked
            ? null
            : () {
                openLevel(level);
              },
        child: SizedBox(
          width: 130,
          child: Column(
            children: [
              // ================================================
              // NODE BULAT
              // ================================================

              Container(
                width: isFinal ? 78 : 68,
                height: isFinal ? 78 : 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: locked
                      ? const Color(0xFF132D42)
                      : levelColor(index, locked),
                  border: Border.all(
                    color: locked
                        ? const Color(0xFF31516A)
                        : Colors.white,
                    width: 3,
                  ),
                  boxShadow: [
                    if (!locked)
                      BoxShadow(
                        color: isFinal
                            ? const Color(0x88B8FF2C)
                            : const Color(0x6621D4FD),
                        blurRadius: 22,
                        spreadRadius: 3,
                      ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      locked
                          ? Icons.lock_rounded
                          : getLevelIcon(index),
                      size: isFinal ? 32 : 28,
                      color: locked
                          ? Colors.white38
                          : const Color(0xFF062033),
                    ),

                    if (isFinal && !locked)
                      const Positioned(
                        top: -5,
                        child: Icon(
                          Icons.workspace_premium_rounded,
                          size: 25,
                          color: Colors.amber,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              // ================================================
              // LABEL LEVEL
              // ================================================

              Container(
                width: 130,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xE6102A43),
                  borderRadius:
                      BorderRadius.circular(12),
                  border: Border.all(
                    color: locked
                        ? const Color(0xFF244B68)
                        : isFinal
                            ? const Color(0xFFB8FF2C)
                            : const Color(0xFF21D4FD),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'LEVEL $level',
                      style: TextStyle(
                        color: locked
                            ? Colors.white38
                            : isFinal
                                ? const Color(0xFFB8FF2C)
                                : const Color(0xFF21D4FD),
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      levelNames[index],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: locked
                            ? Colors.white38
                            : Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    if (stars > 0 && !locked)
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 2),
                        child: Text(
                          '★' * stars,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 13,
                          ),
                        ),
                      ),

                    if (isFinal)
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 2),
                        child: Text(
                          'FINAL MISSION',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 8,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MASKOT
  // ============================================================

  Widget _buildMascot() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF102A43),
            border: Border.all(
              color: const Color(0xFFB8FF2C),
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x7721D4FD),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ],
          ),
          child: ClipOval(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                mascotImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 4),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFB8FF2C),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'KAMU DI SINI',
            style: TextStyle(
              color: Color(0xFF062033),
              fontSize: 8,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

// ==================================================================
// DEKORASI JARINGAN
// ==================================================================

class NetworkDecoration extends StatelessWidget {
  final IconData icon;
  final String label;

  const NetworkDecoration({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.65,
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF167AA5),
              ),
              color: const Color(0xFF09243A),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFF21D4FD),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF397A99),
              fontSize: 7,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// PAINTER PETA JARINGAN
// ==================================================================

class NetworkMapPainter extends CustomPainter {
  final List<double> levelY;
  final List<double> levelX;

  NetworkMapPainter({
    required this.levelY,
    required this.levelX,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ==============================================================
    // GRID HALUS
    // ==============================================================

    final gridPaint = Paint()
      ..color = const Color(0xFF0B3048)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 24) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    for (double y = 0; y < size.height; y += 24) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // ==============================================================
    // JALAN UTAMA
    // ==============================================================

    final road = Path();

    for (int i = 0; i < levelY.length; i++) {
      final point = Offset(
        size.width * levelX[i],
        levelY[i],
      );

      if (i == 0) {
        road.moveTo(point.dx, point.dy);
      } else {
        final previous = Offset(
          size.width * levelX[i - 1],
          levelY[i - 1],
        );

        final middleY =
            (previous.dy + point.dy) / 2;

        road.cubicTo(
          previous.dx,
          middleY,
          point.dx,
          middleY,
          point.dx,
          point.dy,
        );
      }
    }

    // ==============================================================
    // BADAN JALAN
    // ==============================================================

    final roadBase = Paint()
      ..color = const Color(0xFF102A43)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 28
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(road, roadBase);

    // ==============================================================
    // TEPI JALAN
    // ==============================================================

    final roadBorder = Paint()
      ..color = const Color(0xFF167AA5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(road, roadBorder);

    // ==============================================================
    // GARIS NEON BIRU DI TENGAH
    // ==============================================================

    final roadCenter = Paint()
      ..color = const Color(0xFF21D4FD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(road, roadCenter);

    // ==============================================================
    // GARIS PUTUS-PUTUS DI JALAN
    // ==============================================================
    
    final dashPaint = Paint()
      ..color = const Color(0xFFB8FF2C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < levelY.length - 1; i++) {
      final start = Offset(
        size.width * levelX[i],
        levelY[i],
      );

      final end = Offset(
        size.width * levelX[i + 1],
        levelY[i + 1],
      );

      final dx = end.dx - start.dx;
      final dy = end.dy - start.dy;

      final distance = sqrt(
        dx * dx + dy * dy,
      );

      final steps = (distance / 25).floor();

      for (int j = 0; j < steps; j += 2) {
        final t1 = j / steps;
        final t2 = min(
          (j + 1) / steps,
          1.0,
        );

        canvas.drawLine(
          Offset(
            start.dx + dx * t1,
            start.dy + dy * t1,
          ),
          Offset(
            start.dx + dx * t2,
            start.dy + dy * t2,
          ),
          dashPaint,
        );
      }
    }

    // ==============================================================
    // NODE KECIL DI SEKITAR JALAN
    // ==============================================================

    final nodePaint = Paint()
      ..color = const Color(0xFF21D4FD)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < levelY.length; i++) {
      final x = size.width * levelX[i];
      final y = levelY[i];

      canvas.drawCircle(
        Offset(x - 45, y + 30),
        3,
        nodePaint,
      );

      canvas.drawCircle(
        Offset(x + 48, y - 28),
        3,
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant NetworkMapPainter oldDelegate,
  ) {
    return oldDelegate.levelY != levelY ||
        oldDelegate.levelX != levelX;
  }
}