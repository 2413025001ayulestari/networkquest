
part of '../main.dart';

class HomeScreen extends StatefulWidget {
  final GameStore store;

  const HomeScreen({
    super.key,
    required this.store,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController pulse;

  static const Color cyan = Color(0xFF00DFFF);
  static const Color blue = Color(0xFF087DFF);
  static const Color purple = Color(0xFFCC50FF);
  static const Color green = Color(0xFF38FF9D);
  static const Color navy = Color(0xFF031B36);

  @override
  void initState() {
    super.initState();

    pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    widget.store.addListener(refresh);
  }

  void refresh() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    widget.store.removeListener(refresh);
    pulse.dispose();
    super.dispose();
  }

  void open(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Tetap terhubung dengan pilihan maskot di GameStore.
  String get mascotImage {
    if (widget.store.mascot == 'PIXEL') {
      return 'assets/images/Foto Pixel.png';
    }

    return 'assets/images/Foto Netto.png';
  }

  // Dekorasi awan di belakang konten.
  Widget cloud({
    double size = 100,
    double opacity = 0.55,
  }) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: Icon(
          Icons.cloud_rounded,
          size: size,
          color: const Color(0xFF397DFF),
          shadows: const [
            Shadow(
              color: Color(0xFF075BFF),
              blurRadius: 22,
            ),
          ],
        ),
      ),
    );
  }

  // Menu neon dengan area sentuh yang tetap nyaman.
  Widget menuTile({
    required IconData icon,
    required String label,
    required Color accent,
    required VoidCallback onTap,
    required double scale,
  }) {
    return Container(
      height: 82 * scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17 * scale),
        border: Border.all(
          color: accent,
          width: 1.7,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF105087),
            Color(0xFF062448),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.18),
            blurRadius: 12 * scale,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(17 * scale),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(17 * scale),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 9 * scale,
              vertical: 9 * scale,
            ),
            child: Row(
              children: [
                Container(
                  width: 43 * scale,
                  height: 43 * scale,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.17),
                    borderRadius:
                        BorderRadius.circular(12 * scale),
                    border: Border.all(
                      color: accent,
                      width: 1.4,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 25 * scale,
                    color: accent,
                  ),
                ),
                SizedBox(width: 7 * scale),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 21 * scale,
                  color: accent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHomeContent(double scale) {
    final completedLevels =
        widget.store.stars.where((e) => e > 0).length;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        18 * scale,
        8 * scale,
        18 * scale,
        20 * scale,
      ),
      children: [
        // HEADER: hanya skor di kanan atas.
        Align(
          alignment: Alignment.centerRight,
          child: ScoreChip(
            score: widget.store.totalScore,
          ),
        ),

        SizedBox(height: 8 * scale),

        // MASKOT DAN EFEK WIFI.
        Center(
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.98,
              end: 1.025,
            ).animate(
              CurvedAnimation(
                parent: pulse,
                curve: Curves.easeInOut,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wifi_rounded,
                  color: cyan,
                  size: 49 * scale,
                  shadows: const [
                    Shadow(
                      color: cyan,
                      blurRadius: 20,
                    ),
                  ],
                ),

                SizedBox(height: 1 * scale),

                Container(
                  width: 174 * scale,
                  height: 174 * scale,
                  padding: EdgeInsets.all(8 * scale),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF087DFF)
                            .withOpacity(0.22),
                        navy.withOpacity(0.05),
                      ],
                    ),
                    border: Border.all(
                      color: cyan.withOpacity(0.72),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: cyan.withOpacity(0.13),
                        blurRadius: 25 * scale,
                        spreadRadius: 4 * scale,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    mascotImage,
                    fit: BoxFit.contain,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Icon(
                        Icons.smart_toy_rounded,
                        size: 95 * scale,
                        color: cyan,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10 * scale),

        // JUDUL UTAMA.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'NETWORK',
            maxLines: 1,
            style: TextStyle(
              fontSize: 43 * scale,
              height: 0.98,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.5,
              color: const Color(0xFF8DEEFF),
              shadows: const [
                Shadow(
                  color: cyan,
                  blurRadius: 17,
                ),
                Shadow(
                  color: Color(0xFF005BFF),
                  offset: Offset(2, 4),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),

        Center(
          child: Text(
            'QUEST',
            style: TextStyle(
              fontSize: 44 * scale,
              height: 1.03,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: const Color(0xFFFFCB42),
              shadows: const [
                Shadow(
                  color: Color(0xFFFF8A00),
                  offset: Offset(2, 4),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 8 * scale),

        // SUBJUDUL DENGAN GARIS CYAN.
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 9 * scale,
            horizontal: 4 * scale,
          ),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: cyan.withOpacity(0.8),
                width: 1.5,
              ),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Taklukkan Dunia dan Jaringan',
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFFBFEFFF),
                fontSize: 16 * scale,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        SizedBox(height: 18 * scale),

        // TOMBOL MULAI PETUALANGAN.
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40 * scale),
            border: Border.all(
              color: green,
              width: 1.8,
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFB7FF46),
                Color(0xFF3CF28B),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: green.withOpacity(0.23),
                blurRadius: 17 * scale,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(40 * scale),
            child: InkWell(
              borderRadius: BorderRadius.circular(40 * scale),
              onTap: () {
                open(MapScreen(store: widget.store));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12 * scale,
                  vertical: 15 * scale,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      size: 29 * scale,
                      color: const Color(0xFF003B42),
                    ),
                    SizedBox(width: 7 * scale),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'MULAI PETUALANGAN',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF003B42),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5 * scale),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 25 * scale,
                      color: const Color(0xFF003B42),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 17 * scale),

        // MENU BARIS PERTAMA.
        Row(
          children: [
            Expanded(
              child: menuTile(
                icon: Icons.menu_book_rounded,
                label: 'PANDUAN',
                accent: cyan,
                scale: scale,
                onTap: () {
                  open(const GuideScreen());
                },
              ),
            ),
            SizedBox(width: 11 * scale),
            Expanded(
              child: menuTile(
                icon: Icons.sports_esports_rounded,
                label: 'GAME ZONE',
                accent: purple,
                scale: scale,
                onTap: () {
                  open(GameZone(store: widget.store));
                },
              ),
            ),
          ],
        ),

        SizedBox(height: 10 * scale),

        // MENU BARIS KEDUA.
        Row(
          children: [
            Expanded(
              child: menuTile(
                icon: Icons.smart_toy_rounded,
                label: 'MASKOT',
                accent: cyan,
                scale: scale,
                onTap: () {
                  open(MascotScreen(store: widget.store));
                },
              ),
            ),
            SizedBox(width: 11 * scale),
            Expanded(
              child: menuTile(
                icon: Icons.settings_rounded,
                label: 'PENGATURAN',
                accent: green,
                scale: scale,
                onTap: () {
                  open(SettingsScreen(store: widget.store));
                },
              ),
            ),
          ],
        ),

        SizedBox(height: 17 * scale),

        // PROGRESS LEVEL DARI GAMESTORE.
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10 * scale,
            vertical: 10 * scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13 * scale),
            border: Border.all(
              color: cyan,
              width: 1.3,
            ),
            color: const Color(0xFF052C56).withOpacity(0.94),
          ),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: completedLevels / 7,
                    minHeight: 10 * scale,
                    color: const Color(0xFF62FF72),
                    backgroundColor: const Color(0xFF164C91),
                  ),
                ),
              ),
              SizedBox(width: 9 * scale),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$completedLevels/7 LEVEL',
                  maxLines: 1,
                  style: TextStyle(
                    color: cyan,
                    fontWeight: FontWeight.w900,
                    fontSize: 11 * scale,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridBackground(
        child: LayoutBuilder(
          builder: (context, outerConstraints) {
            return Stack(
              children: [
                // CAHAYA LATAR.
                Positioned(
                  top: 70,
                  right: -45,
                  child: IgnorePointer(
                    child: Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            cyan.withOpacity(0.10),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // AWAN KIRI ATAS.
                Positioned(
                  top: 95,
                  left: -38,
                  child: cloud(
                    size: 110,
                    opacity: 0.57,
                  ),
                ),

                // AWAN KANAN.
                Positioned(
                  top: 260,
                  right: -42,
                  child: cloud(
                    size: 100,
                    opacity: 0.42,
                  ),
                ),

                // AWAN KIRI BAWAH.
                Positioned(
                  bottom: 25,
                  left: -42,
                  child: cloud(
                    size: 125,
                    opacity: 0.62,
                  ),
                ),

                // AWAN KANAN BAWAH.
                Positioned(
                  bottom: 50,
                  right: -42,
                  child: cloud(
                    size: 115,
                    opacity: 0.55,
                  ),
                ),

                // ORNAMEN JARINGAN.
                Positioned(
                  left: 12,
                  bottom: 75,
                  child: IgnorePointer(
                    child: Icon(
                      Icons.hub_rounded,
                      size: 43,
                      color: cyan.withOpacity(0.24),
                    ),
                  ),
                ),

                // LAYOUT RESPONSIF.
                Positioned.fill(
                  child: SafeArea(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Skala menyesuaikan tinggi area layar.
                        // Pada layar pendek, konten mengecil.
                        // Pada layar tinggi, ukuran tetap dibatasi.
                        final scale = (constraints.maxHeight / 780)
                            .clamp(0.76, 1.0)
                            .toDouble();

                        return buildHomeContent(scale);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
