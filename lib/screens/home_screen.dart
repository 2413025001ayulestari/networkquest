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
    if (!mounted) {
      return;
    }

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
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            22,
            16,
            22,
            32,
          ),
          children: [
            // ==================================================
            // HEADER
            // ==================================================

            Row(
              children: [
                const Icon(
                  Icons.hub_rounded,
                  color: cyan,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'NETWORK QUEST',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ScoreChip(
                  score: widget.store.totalScore,
                ),
              ],
            ),

            const SizedBox(height: 38),

            // ==================================================
            // MASKOT YANG DIPILIH
            // ==================================================

            Center(
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.96,
                  end: 1.04,
                ).animate(
                  CurvedAnimation(
                    parent: pulse,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: Image.asset(
                  mascotImage,
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return const Icon(
                      Icons.smart_toy_rounded,
                      size: 100,
                      color: cyan,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // JUDUL
            // ==================================================

            const Text(
              'TAKLUKKAN\nDUNIA JARINGAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38,
                height: 1.02,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Belajar jaringan komputer lewat misi, eksperimen, '
              'dan tantangan seru.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9DB5C8),
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // MULAI PETUALANGAN
            // ==================================================

            FilledButton.icon(
              onPressed: () {
                open(
                  MapScreen(
                    store: widget.store,
                  ),
                );
              },
              icon: const Icon(
                Icons.play_arrow_rounded,
              ),
              label: const Text(
                'MULAI PETUALANGAN',
              ),
            ),

            const SizedBox(height: 12),

            // ==================================================
            // MENU ATAS
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: MenuTile(
                    icon: Icons.menu_book_rounded,
                    label: 'PANDUAN',
                    onTap: () {
                      open(
                        const GuideScreen(),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: MenuTile(
                    icon: Icons.sports_esports_rounded,
                    label: 'GAME ZONE',
                    onTap: () {
                      open(
                        GameZone(
                          store: widget.store,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ==================================================
            // MENU BAWAH
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: MenuTile(
                    icon: Icons.smart_toy_rounded,
                    label: 'MASKOT',
                    onTap: () {
                      open(
                        MascotScreen(
                          store: widget.store,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: MenuTile(
                    icon: Icons.settings_rounded,
                    label: 'PENGATURAN',
                    onTap: () {
                      open(
                        SettingsScreen(
                          store: widget.store,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ==================================================
            // PROGRESS LEVEL
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: widget.store.stars
                            .where((e) => e > 0)
                            .length /
                        7,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                    color: lime,
                    backgroundColor: const Color(0xFF244B68),
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  '${widget.store.stars.where((e) => e > 0).length}/7 LEVEL',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cyan,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}