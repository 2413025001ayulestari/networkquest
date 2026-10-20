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

  // Jalur perjalanan maskot mengikuti jalan berkelok pada peta.
  // Koordinat menggunakan persentase lebar dan tinggi layar.
  static const List<List<Offset>> _routeSegments = [
    // Level 1 -> Level 2
    [
      Offset(.47, .865),
      Offset(.40, .845),
      Offset(.34, .815),
      Offset(.31, .785),
      Offset(.34, .760),
      Offset(.43, .742),
      Offset(.54, .742),
      Offset(.65, .755),
      Offset(.78, .745),
    ],

    // Level 2 -> Level 3
    [
      Offset(.78, .745),
      Offset(.69, .725),
      Offset(.59, .700),
      Offset(.49, .680),
      Offset(.40, .662),
      Offset(.31, .655),
      Offset(.24, .650),
    ],

    // Level 3 -> Level 4
    [
      Offset(.24, .650),
      Offset(.31, .620),
      Offset(.40, .595),
      Offset(.49, .575),
      Offset(.56, .555),
      Offset(.59, .540),
      Offset(.64, .525),
      Offset(.73, .515),
    ],

    // Level 4 -> Level 5
    [
      Offset(.73, .515),
      Offset(.65, .495),
      Offset(.56, .478),
      Offset(.46, .465),
      Offset(.36, .455),
      Offset(.27, .445),
    ],

    // Level 5 -> Level 6
    [
      Offset(.27, .445),
      Offset(.32, .420),
      Offset(.40, .400),
      Offset(.48, .380),
      Offset(.52, .355),
      Offset(.46, .330),
      Offset(.39, .295),
      Offset(.325, .270),
    ],

    // Level 6 -> Level 7
    [
      Offset(.325, .270),
      Offset(.42, .270),
      Offset(.52, .282),
      Offset(.62, .300),
      Offset(.70, .315),
      Offset(.76, .325),
    ],
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

  static const Color _background = Color(0xFF03132F);
  static const Color _cyan = Color(0xFF21D4FD);

  int get _currentLevel => widget.store.unlocked.clamp(1, 7);

  String get _mascotAsset {
    if (widget.store.mascot == 'PIXEL') {
      return 'assets/images/Foto Pixel.png';
    }

    return 'assets/images/Foto Netto.png';
  }

  @override
  void initState() {
    super.initState();

    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..repeat(reverse: true);

    // Durasi perjalanan dibuat lebih lama agar maskot terlihat berjalan.
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    _mascotLevel = _currentLevel;
    _previousLevel = _mascotLevel;

    widget.store.addListener(_onStoreChanged);
  }

  void _onStoreChanged() {
    if (!mounted) return;

    final nextLevel = _currentLevel;

    if (nextLevel != _mascotLevel) {
      _previousLevel = _mascotLevel;
      _mascotLevel = nextLevel;

      // Mulai animasi perjalanan saat level bertambah.
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

  // Mengambil jalur perjalanan berdasarkan level sebelumnya
  // dan level tujuan.
  List<Offset> _routeForMove() {
    if (_mascotLevel == _previousLevel) {
      return [_levelPoints[_mascotLevel - 1]];
    }

    final start = _previousLevel;
    final end = _mascotLevel;

    if (end == start + 1 &&
        start >= 1 &&
        start <= _routeSegments.length) {
      return _routeSegments[start - 1];
    }

    // Pengaman jika progres bertambah lebih dari satu level.
    return [
      _levelPoints[start - 1],
      _levelPoints[end - 1],
    ];
  }

  // Menghitung posisi maskot sepanjang jalur.
  // Maskot melewati titik-titik jalur, bukan bergerak
  // lurus dari level awal menuju level tujuan.
  Offset _pointAlongRoute(
    List<Offset> route,
    double progress,
  ) {
    if (route.length < 2) {
      return route.first;
    }

    double totalLength = 0;
    final lengths = <double>[];

    for (int i = 0; i < route.length - 1; i++) {
      final dx = route[i + 1].dx - route[i].dx;
      final dy = route[i + 1].dy - route[i].dy;

      final length = sqrt(dx * dx + dy * dy);

      lengths.add(length);
      totalLength += length;
    }

    if (totalLength == 0) {
      return route.last;
    }

    double remaining =
        progress.clamp(0.0, 1.0) * totalLength;

    for (int i = 0; i < lengths.length; i++) {
      final length = lengths[i];

      if (remaining <= length || i == lengths.length - 1) {
        final t = length == 0
            ? 1.0
            : (remaining / length).clamp(0.0, 1.0);

        return Offset(
          route[i].dx +
              (route[i + 1].dx - route[i].dx) * t,
          route[i].dy +
              (route[i + 1].dy - route[i].dy) * t,
        );
      }

      remaining -= length;
    }

    return route.last;
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

  void _backToHome() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Halaman beranda tidak tersedia.'),
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

    final safeTop = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: _background,
      body: SizedBox.expand(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mapWidth = constraints.maxWidth;
            final mapHeight = constraints.maxHeight;

            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // GAMBAR PETA
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/map_reference.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (_, __, ___) {
                      return const _MapAssetFallback();
                    },
                  ),
                ),

                // LAPISAN GELAP TIPIS
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(
                          alpha: 0.04,
                        ),
                      ),
                    ),
                  ),
                ),

                // TOMBOL KEMBALI
                Positioned(
                  top: safeTop + 8,
                  left: 14,
                  child: Material(
                    color: const Color(0xDD061B35),
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: _cyan,
                        width: 1.5,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _backToHome,
                      child: const SizedBox(
                        width: 42,
                        height: 42,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),

                // JUMLAH LEVEL SELESAI
                Positioned(
                  top: safeTop + 12,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xEE06233F),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _cyan,
                        width: 1.2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x5521D4FD),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFD600),
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$completedLevels/7',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // GEMBOK LEVEL YANG BELUM TERBUKA
                for (int i = 0; i < 7; i++)
                  if (i + 1 > unlocked)
                    _buildLockOverlay(
                      level: i + 1,
                      mapWidth: mapWidth,
                      mapHeight: mapHeight,
                    ),

                // AREA SENTUH LEVEL
                for (int i = 0; i < 7; i++)
                  _buildLevelHitArea(
                    level: i + 1,
                    mapWidth: mapWidth,
                    mapHeight: mapHeight,
                  ),

                // MASKOT BERGERAK MENGIKUTI JALUR
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _bobController,
                    _moveController,
                  ]),
                  builder: (context, child) {
                    final route = _routeForMove();

                    final t =
                        Curves.easeInOutCubic.transform(
                      _moveController.value,
                    );

                    final position = _pointAlongRoute(
                      route,
                      t,
                    );

                    final x = position.dx;
                    final y = position.dy;

                    final bob =
                        sin(_bobController.value * pi) * 4;

                    final mascotSize =
                        (mapWidth * 0.15).clamp(48.0, 60.0);

                    return Positioned(
                      left: (x * mapWidth - mascotSize / 2)
                          .clamp(
                        0.0,
                        mapWidth - mascotSize,
                      ),
                      top: (y * mapHeight -
                              mascotSize -
                              8 -
                              bob)
                          .clamp(
                        safeTop + 45,
                        mapHeight - mascotSize - 35,
                      ),
                      child: IgnorePointer(
                        child: _buildMascot(mascotSize),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // AREA SENTUH SETIAP LEVEL
  Widget _buildLevelHitArea({
    required int level,
    required double mapWidth,
    required double mapHeight,
  }) {
    final point = _levelPoints[level - 1];

    final width = mapWidth * 0.39;
    final height = mapHeight * 0.085;

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
      left: (point.dx * mapWidth - 15)
          .clamp(0.0, mapWidth - 30),
      top: (point.dy * mapHeight - 16)
          .clamp(0.0, mapHeight - 32),
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
  Widget _buildMascot(double size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF062033),
            shape: BoxShape.circle,
            border: Border.all(
              color: _cyan,
              width: 2.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xAA21D4FD),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              _mascotAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.face_retouching_natural,
                  color: _cyan,
                  size: 32,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: _cyan,
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