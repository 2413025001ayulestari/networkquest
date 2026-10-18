part of '../main.dart';

class SplashScreen extends StatefulWidget {
  final GameStore store;

  const SplashScreen({
    super.key,
    required this.store,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _loadingController;

  @override
  void initState() {
    super.initState();

    // Animasi loading selama 4 detik
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _loadingController.forward();

    // Setelah loading selesai masuk ke Home
    Timer(const Duration(seconds: 4), () {
      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, animation, __) {
            return HomeScreen(
              store: widget.store,
            );
          },
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07152F),
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // =====================================================
            // GAMBAR SPLASH UTAMA
            // =====================================================

            Image.asset(
              'assets/images/network_quest_splash.png',
              fit: BoxFit.cover,
            ),

            // =====================================================
            // OVERLAY GELAP TIPIS
            // =====================================================

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.08),
                  ],
                ),
              ),
            ),

            // =====================================================
            // LOADING BAR
            // =====================================================

            Positioned(
              left: 0,
              right: 0,
              bottom: 72,
              child: Center(
                child: AnimatedBuilder(
                  animation: _loadingController,
                  builder: (context, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // BAR LOADING
                        Container(
                          width: 255,
                          height: 20,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF071A35),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF2F9EFF),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF159DFF)
                                    .withValues(alpha: 0.55),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: _loadingController.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF12BFFF),
                                      Color(0xFF55E8FF),
                                    ],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFF1DBEFF),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // TEXT LOADING
                        Text(
                          _getLoadingText(
                            _loadingController.value,
                          ),
                          style: const TextStyle(
                            color: Color(0xFFB9D9FF),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // =====================================================
            // VERSI GAME
            // =====================================================

            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'NETWORK QUEST • v1.0',
                  style: TextStyle(
                    color: Color(0xFF7598BD),
                    fontSize: 9,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLoadingText(double progress) {
    if (progress < 0.25) {
      return 'Menghubungkan jaringan...';
    }

    if (progress < 0.50) {
      return 'Menyiapkan perangkat...';
    }

    if (progress < 0.75) {
      return 'Memuat misi...';
    }

    if (progress < 0.95) {
      return 'Menyiapkan petualangan...';
    }

    return 'Siap bermain!';
  }
}