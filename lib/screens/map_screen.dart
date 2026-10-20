
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
    with TickerProviderStateMixin {
  late final AnimationController _bobController;
  late final AnimationController _moveController;

  int _mascotLevel = 1;
  int _previousLevel = 1;

  static const List<Offset> _levelPoints = [
    Offset(.47, .865),
    Offset(.78, .745),
    Offset(.24, .65),
    Offset(.73, .515),
    Offset(.27, .445),
    Offset(.325, .27),
    Offset(.76, .325),
  ];

  static const List<String> _levelNames = [
    'Perangkat',
    'Penyusunan Jaringan',
    'IP Address',
    'Ping',
    'Troubleshooting',
    'Topologi & Subnetting',
    'Ujian Akhir',
  ];

  @override
  void initState() {
    super.initState();

    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..repeat(reverse: true);

    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );

    _mascotLevel = _currentLevel;
    _previousLevel = _mascotLevel;

    widget.store.addListener(_onStoreChanged);
  }

  int get _currentLevel =>
      widget.store.unlocked.clamp(1, 7);

  String get _mascotAsset {
    if (widget.store.mascot == 'PIXEL') {
      return 'assets/images/Foto Pixel.png';
    }

    return 'assets/images/Foto Netto.png';
  }

  void _onStoreChanged() {
    if (!mounted) return;

    final nextLevel = _currentLevel;

    if (nextLevel != _mascotLevel) {
      _previousLevel = _mascotLevel;
      _mascotLevel = nextLevel;
      _moveController.forward(from: 0);
    }

    setState(() {});
  }

  @override
  void dispose() {
    widget.store.removeListener(_onStoreChanged);
    _bobController.dispose();
    _moveController.dispose();
    super.dispose();
  }

  Future<void> _openLevel(int level) async {
    if (level > _currentLevel) {
      _showLockedMessage(level);
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

    if (!mounted) return;
    setState(() {});
  }

  void _showLockedMessage(int level) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Level $level masih terkunci. '
            'Selesaikan level sebelumnya!',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF09243A),
        ),
      );
  }

  // KEMBALI KE MENU SEBELUMNYA / BERANDA
  void _backToHome() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      // Jika halaman peta menjadi halaman pertama,
      // gunakan halaman beranda sebagai halaman awal aplikasi.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Halaman beranda tidak tersedia di navigation stack.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final unlocked = _currentLevel;

    final completedLevels = widget.store.stars
        .where((stars) => stars > 0)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFF03132F),

      // Area peta dibuat setinggi layar yang tersedia.
      body: SafeArea(
        top: true,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, screenConstraints) {
            final mapWidth = screenConstraints.maxWidth;
            final mapHeight = screenConstraints.maxHeight;

            return SizedBox.expand(
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // BACKGROUND PETA FULL SCREEN
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/map_reference.png',
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      errorBuilder: (_, __, ___) {
                        return const _MapAssetFallback();
                      },
                    ),
                  ),

                  // TOMBOL KEMBALI DI KIRI ATAS
                  Positioned(
                    top: 10,
                    left: 12,
                    child: Material(
                      color: const Color(0xDD061B35),
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: Color(0xFF21D4FD),
                          width: 1.5,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: _backToHome,
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // LEVEL YANG BELUM TERBUKA
                  for (int i = 0; i < 7; i++)
                    if (i + 1 > unlocked)
                      _buildLockOverlay(
                        level: i + 1,
                        mapWidth: mapWidth,
                        mapHeight: mapHeight,
                      ),

                  // AREA KLIK SETIAP LEVEL
                  for (int i = 0; i < 7; i++)
                    _buildLevelHitArea(
                      level: i + 1,
                      mapWidth: mapWidth,
                      mapHeight: mapHeight,
                    ),

                  // MASKOT BERGERAK ANTAR LEVEL
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _bobController,
                      _moveController,
                    ]),
                    builder: (context, child) {
                      final from =
                          _levelPoints[_previousLevel - 1];

                      final to =
                          _levelPoints[_mascotLevel - 1];

                      final t =
                          Curves.easeInOutCubic.transform(
                        _moveController.value,
                      );

                      final x =
                          from.dx + (to.dx - from.dx) * t;

                      final y =
                          from.dy + (to.dy - from.dy) * t;

                      final bob =
                          sin(_bobController.value * pi) * 5;

                      return Positioned(
                        left: x * mapWidth - 30,
                        top: y * mapHeight - 68 - bob,
                        child: IgnorePointer(
                          child: _buildMascot(),
                        ),
                      );
                    },
                  ),

                  // PROGRESS DI BAGIAN BAWAH PETA
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 12,
                    child: SafeArea(
                      top: false,
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: completedLevels / 7,
                                minHeight: 7,
                                color: const Color(0xFF21D4FD),
                                backgroundColor:
                                    const Color(0xFF18344B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$completedLevels/7',
                            style: const TextStyle(
                              color: Color(0xFF21D4FD),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // AREA SENTUH LEVEL
  Widget _buildLevelHitArea({
    required int level,
    required double mapWidth,
    required double mapHeight,
  }) {
    final point = _levelPoints[level - 1];

    final width = mapWidth * .39;
    final height = mapHeight * .085;

    return Positioned(
      left: (point.dx * mapWidth - width / 2)
          .clamp(0.0, mapWidth - width),
      top: (point.dy * mapHeight - height / 2)
          .clamp(0.0, mapHeight - height),
      width: width,
      height: height,
      child: Semantics(
        button: true,
        label: 'Level $level: ${_levelNames[level - 1]}',
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _openLevel(level),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  // GEMBOK LEVEL TERKUNCI
  Widget _buildLockOverlay({
    required int level,
    required double mapWidth,
    required double mapHeight,
  }) {
    final point = _levelPoints[level - 1];

    return Positioned(
      left: point.dx * mapWidth - 15,
      top: point.dy * mapHeight - 16,
      child: IgnorePointer(
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xE6132D42),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF55738A),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_rounded,
            size: 17,
            color: Color(0xFFB5C6D3),
          ),
        ),
      ),
    );
  }

  // MASKOT NETTO ATAU PIXEL
  Widget _buildMascot() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF062033),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF21D4FD),
              width: 2.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xAA21D4FD),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: ClipOval(
            child: Image.asset(
              _mascotAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.face_retouching_natural,
                  color: Color(0xFF21D4FD),
                  size: 35,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF21D4FD),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'KAMU DI SINI',
            style: TextStyle(
              color: Color(0xFF062033),
              fontSize: 7,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

// TAMPILAN CADANGAN JIKA GAMBAR PETA TIDAK DITEMUKAN
class _MapAssetFallback extends StatelessWidget {
  const _MapAssetFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF03132F),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: const Text(
        'Gambar peta tidak ditemukan.\n'
        'Periksa assets/images/map_reference.png '
        'dan pubspec.yaml.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF8FAFC5),
        ),
      ),
    );
  }
}
