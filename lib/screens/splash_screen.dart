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
  late final AnimationController _loadingController;

  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _loadingController.forward();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomeScreen(store: widget.store);
        },
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
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
            // GAMBAR UTAMA SPLASH SCREEN
            Positioned.fill(
              child: Image.asset(
                'assets/images/network_quest_splash.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                gaplessPlayback: true,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Gagal memuat splash screen: $error');

                  return const ColoredBox(
                    color: Color(0xFF07152F),
                    child: Center(
                      child: Text(
                        'NETWORK QUEST',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF55E8FF),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // OVERLAY TIPIS
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.18),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ANIMASI LOADING
            Positioned(
              left: 0,
              right: 0,
              bottom: 72,
              child: AnimatedBuilder(
                animation: _loadingController,
                builder: (context, child) {
                  final progress = _loadingController.value;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 255,
                        height: 20,
                        padding: const EdgeInsets.all(3),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: progress,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF12BFFF),
                                      Color(0xFF55E8FF),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        _loadingText(progress),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFB9D9FF),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
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

            // VERSI APLIKASI
            const Positioned(
              left: 0,
              right: 0,
              bottom: 20,
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

  String _loadingText(double progress) {
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

