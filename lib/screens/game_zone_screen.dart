
part of '../main.dart';

class GameZone extends StatefulWidget {
  final GameStore store;

  const GameZone({
    super.key,
    required this.store,
  });

  @override
  State<GameZone> createState() => _GameZoneState();
}

class _GameZoneState extends State<GameZone> {
  // ============================================================
  // SOAL GAME ZONE
  // ============================================================

  static const Map<String, String> words = {
    'ROUTER': 'Penghubung antarjaringan',
    'SWITCH': 'Penghubung perangkat di LAN',
    'FIREWALL': 'Penyaring lalu lintas jaringan',
    'SUBNET': 'Pembagian jaringan menjadi jaringan kecil',
    'SERVER': 'Penyedia layanan dalam jaringan',
  };

  // ============================================================
  // GAMBAR SOAL
  // ============================================================

  static const Map<String, String> images = {
    'ROUTER': 'assets/images/game_zone/router.png',
    'SWITCH': 'assets/images/game_zone/switch.png',
    'FIREWALL': 'assets/images/game_zone/firewall.png',
    'SUBNET': 'assets/images/game_zone/subnet.png',
    'SERVER': 'assets/images/game_zone/server.png',
  };

  late String word;
  late List<String> letters;
  late List<String> questionOrder;

  int round = 0;
  int score = 0;

  String answer = '';

  final List<int> selectedIndices = [];

  bool isChecking = false;
  bool isCorrect = false;
  bool _isFinishingRound = false;

  // ============================================================
  // AUDIO PLAYER
  // ============================================================

  final AudioPlayer _gameZonePlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  bool _isMusicPlaying = false;
  bool _isMusicPrepared = false;
  bool _isAudioDisposed = false;

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    questionOrder = words.keys.toList()..shuffle();

    newWord();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _playGameZoneMusic();
    });
  }

  // ============================================================
  // SOAL BARU
  // ============================================================

  void newWord() {
    word = questionOrder[round];

    letters = word.split('')..shuffle();

    answer = '';

    selectedIndices.clear();

    isChecking = false;
    isCorrect = false;
  }

  // ============================================================
  // MUSIK GAME ZONE
  // ============================================================

  Future<void> _playGameZoneMusic() async {
    if (!mounted ||
        _isAudioDisposed ||
        !widget.store.sound ||
        _isMusicPlaying) {
      return;
    }

    try {
      if (!_isMusicPrepared) {
        await _gameZonePlayer.setReleaseMode(
          ReleaseMode.loop,
        );

        await _gameZonePlayer.setVolume(1.0);

        await _gameZonePlayer.setSource(
          AssetSource('audio/sound_gamezone.mp3'),
        );

        _isMusicPrepared = true;
      }

      if (!mounted || _isAudioDisposed) return;

      await _gameZonePlayer.resume();

      _isMusicPlaying = true;

      debugPrint('MUSIK GAME ZONE BERJALAN');
    } catch (e) {
      _isMusicPlaying = false;
      debugPrint('ERROR MUSIK GAME ZONE: $e');
    }
  }

  // ============================================================
  // PAUSE MUSIK GAME ZONE
  // ============================================================

  Future<void> _stopGameZoneMusic() async {
    try {
      if (_isMusicPlaying && !_isAudioDisposed) {
        await _gameZonePlayer.pause();

        _isMusicPlaying = false;
      }

      debugPrint('MUSIK GAME ZONE DI-PAUSE');
    } catch (e) {
      debugPrint('ERROR PAUSE MUSIK: $e');
    }
  }

  // ============================================================
  // SOUND EFFECT BENAR / SALAH
  // ============================================================

  Future<void> _playEffectAndWait(String fileName) async {
    if (!mounted ||
        _isAudioDisposed ||
        !widget.store.sound) {
      return;
    }

    try {
      await _effectPlayer.stop();

      await _effectPlayer.setReleaseMode(
        ReleaseMode.stop,
      );

      await _effectPlayer.setVolume(1.0);

      final completed = _effectPlayer.onPlayerComplete.first;

      await _effectPlayer.play(
        AssetSource('audio/$fileName'),
      );

      debugPrint('SOUND EFFECT DIPUTAR: $fileName');

      await completed.timeout(
        const Duration(seconds: 30),
      );

      debugPrint('SOUND EFFECT SELESAI');
    } catch (e) {
      debugPrint('ERROR SOUND EFFECT: $e');

      try {
        if (!_isAudioDisposed) {
          await _effectPlayer.stop();
        }
      } catch (_) {}
    }
  }

  // ============================================================
  // MEMILIH HURUF
  // ============================================================

  Future<void> tap(int index) async {
    if (isChecking ||
        _isFinishingRound ||
        answer.length >= word.length ||
        selectedIndices.contains(index)) {
      return;
    }

    setState(() {
      selectedIndices.add(index);
      answer += letters[index];
    });

    // Musik tetap berjalan ketika memilih huruf.
    if (answer.length != word.length) {
      return;
    }

    setState(() {
      isCorrect = answer == word;
      isChecking = true;

      if (isCorrect) {
        score += 50;
      }
    });

    await _finishRound();
  }

  // ============================================================
  // PROSES JAWABAN
  // ============================================================

  Future<void> _finishRound() async {
    if (_isFinishingRound) return;

    _isFinishingRound = true;

    try {
      // Pause musik sebelum sound effect.
      await _stopGameZoneMusic();

      if (!mounted) return;

      // Putar suara sesuai hasil jawaban.
      if (isCorrect) {
        await _playEffectAndWait(
          'ketika_jawaban_benar.mp3',
        );
      } else {
        await _playEffectAndWait(
          'ketika_jawaban_salah.mp3',
        );
      }

      if (!mounted) return;

      // Lanjutkan musik dari posisi sebelumnya.
      await _playGameZoneMusic();

      if (!mounted) return;

      // Soal terakhir.
      if (round == questionOrder.length - 1) {
        _isFinishingRound = false;

        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) {
            return AlertDialog(
              backgroundColor: const Color(0xFF102A43),
              title: const Text(
                'GAME ZONE SELESAI',
                style: TextStyle(
                  color: lime,
                  fontWeight: FontWeight.w900,
                ),
              ),
              content: Text(
                'Skor bonusmu: $score',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              actions: [
                FilledButton(
                  onPressed: () async {
                    await _stopGameZoneMusic();

                    if (!mounted) return;

                    Navigator.pop(dialogContext);
                    Navigator.pop(context);
                  },
                  child: const Text('SELESAI'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          round++;
          newWord();
        });

        _isFinishingRound = false;
      }
    } catch (e) {
      debugPrint('ERROR PROSES JAWABAN: $e');

      _isFinishingRound = false;

      if (mounted) {
        await _playGameZoneMusic();
      }
    }
  }

  // ============================================================
  // RESET JAWABAN
  // ============================================================

  void resetAnswer() {
    if (isChecking || _isFinishingRound) {
      return;
    }

    setState(() {
      answer = '';
      selectedIndices.clear();
      letters.shuffle();
    });

    // Tidak menghentikan musik.
  }

  // ============================================================
  // GAMBAR MASKOT
  // ============================================================

  String get mascotImage {
    if (widget.store.mascot == 'PIXEL') {
      return 'assets/images/Foto Pixel.png';
    }

    return 'assets/images/Foto Netto.png';
  }

  // ============================================================
  // DISPOSE AUDIO
  // ============================================================

  @override
  void dispose() {
    _isAudioDisposed = true;
    _isMusicPlaying = false;

    _gameZonePlayer.dispose();
    _effectPlayer.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final String? currentImage = images[word];

    return Scaffold(
      body: GridBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              // JUDUL
              const AppTitle(
                'GAME ZONE',
                'Susun istilah jaringan komputer',
              ),

              const SizedBox(height: 20),

              // RONDE DAN SKOR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RONDE ${round + 1}/5',
                    style: const TextStyle(
                      color: lime,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'SKOR: $score',
                    style: const TextStyle(
                      color: cyan,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // MASKOT PEMAIN
              Center(
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    mascotImage,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint(
                        'Gagal memuat maskot: $mascotImage',
                      );

                      return const Icon(
                        Icons.person,
                        size: 65,
                        color: cyan,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // GAMBAR PERANGKAT
              Container(
                width: double.infinity,
                height: 220,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF102A43),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: cyan,
                    width: 1.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3322D3EE),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: currentImage == null
                    ? const Center(
                        child: Text(
                          'Gambar tidak ditemukan.',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      )
                    : Image.asset(
                        currentImage,
                        key: ValueKey(currentImage),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint(
                            'Gagal memuat gambar: $currentImage',
                          );

                          return Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.orangeAccent,
                                size: 42,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Gambar gagal dimuat',
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                currentImage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),

              const SizedBox(height: 18),

              // PETUNJUK
              Text(
                words[word]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Susun huruf untuk menemukan jawabannya!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 22),

              // KOTAK JAWABAN
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF102A43),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isChecking
                        ? (isCorrect ? lime : Colors.redAccent)
                        : cyan,
                    width: 1.5,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    answer
                        .padRight(word.length, '_')
                        .split('')
                        .join(' '),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: lime,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // HASIL JAWABAN
              if (isChecking)
                Text(
                  isCorrect
                      ? 'Benar! +50 poin'
                      : 'Belum tepat! Jawaban: $word',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isCorrect ? lime : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

              const SizedBox(height: 18),

              // PILIHAN HURUF
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 9,
                runSpacing: 9,
                children: List.generate(
                  letters.length,
                  (index) {
                    final letter = letters[index];
                    final used = selectedIndices.contains(index);

                    return SizedBox(
                      width: 48,
                      height: 48,
                      child: FilledButton(
                        onPressed:
                            !used &&
                                    answer.length < word.length &&
                                    !isChecking &&
                                    !_isFinishingRound
                                ? () => tap(index)
                                : null,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: const Color(0xFF176B87),
                          disabledBackgroundColor:
                              const Color(0xFF263746),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          letter,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),

              // HAPUS JAWABAN
              OutlinedButton.icon(
                onPressed:
                    !isChecking && !_isFinishingRound
                        ? resetAnswer
                        : null,
                icon: const Icon(
                  Icons.backspace_outlined,
                ),
                label: const Text(
                  'HAPUS JAWABAN',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: cyan,
                  side: const BorderSide(
                    color: cyan,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
