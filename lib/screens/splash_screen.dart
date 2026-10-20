
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

  bool _started = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prepareSplash();
    });
  }

  Future<void> _prepareSplash() async {
    if (_started || !mounted) return;
    _started = true;

    try {
      await precacheImage(
        const AssetImage('assets/images/network_quest_splash.png'),
        context,
      );
    } catch (error) {
      debugPrint('Gagal memuat gambar splash: $error');
    }

    if (!mounted) return;

    _loadingController.forward();

    await Future.delayed(const Duration(seconds: 4));

    if (!mounted || _navigated) return;
    _navigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
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
            Positioned.fill(
              child: Image.asset(
                'assets/images/network_quest_splash.png',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('ERROR SPLASH: $error');

                  return const ColoredBox(
                    color: Color(0xFF07152F),
                    child: Center(
                      child: Text(
                        'Gambar splash gagal dimuat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

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

            Positioned(
              left: 0,
              right: 0,
              bottom: 65,
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
                                  .withValues(alpha: 0.45),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.transparent,
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              Color(0xFF35D6FF),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
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

            const Positioned(
              left: 0,
              right: 0,
              bottom: 18,
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
    } else if (progress < 0.50) {
      return 'Menyiapkan perangkat...';
    } else if (progress < 0.75) {
      return 'Memuat misi...';
    } else if (progress < 0.95) {
      return 'Menyiapkan petualangan...';
    }

    return 'Siap bermain!';
  }
}
