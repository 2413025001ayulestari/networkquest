
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
  // Lima soal yang tersedia dalam permainan.
  static const Map<String, String> words = {
    'ROUTER': 'Penghubung antarjaringan',
    'SWITCH': 'Penghubung perangkat di LAN',
    'FIREWALL': 'Penyaring lalu lintas jaringan',
    'SUBNET': 'Pembagian jaringan menjadi jaringan kecil',
    'SERVER': 'Penyedia layanan dalam jaringan',
  };

  // Gambar untuk setiap soal.
  static const Map<String, String> images = {
    'ROUTER': 'assets/images/game_zone/router.png',
    'SWITCH': 'assets/images/game_zone/switch.png',
    'FIREWALL': 'assets/images/game_zone/firewall.png',
    'SUBNET': 'assets/images/game_zone/subnet.png',
    'SERVER': 'assets/images/game_zone/server.png',
  };

  late String word;
  late List<String> letters;

  // Urutan soal diacak satu kali agar tidak berulang.
  late List<String> questionOrder;

  int round = 0;
  int score = 0;

  String answer = '';

  // Menyimpan indeks tombol huruf yang telah dipilih.
  final List<int> selectedIndices = [];

  bool isChecking = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();

    // Acak kelima soal satu kali ketika permainan dimulai.
    questionOrder = words.keys.toList()..shuffle();

    newWord();
  }

  // Mengambil soal berdasarkan ronde.
  void newWord() {
    word = questionOrder[round];

    // Huruf pilihan diacak untuk setiap soal.
    letters = word.split('')..shuffle();

    answer = '';
    selectedIndices.clear();
    isChecking = false;
    isCorrect = false;
  }

  // Memilih huruf berdasarkan indeks tombol.
  void tap(int index) {
    if (isChecking ||
        answer.length >= word.length ||
        selectedIndices.contains(index)) {
      return;
    }

    setState(() {
      selectedIndices.add(index);
      answer += letters[index];
    });

    // Memeriksa jawaban setelah seluruh kotak terisi.
    if (answer.length == word.length) {
      setState(() {
        isCorrect = answer == word;
        isChecking = true;

        if (isCorrect) {
          score += 50;
        }
      });

      Future.delayed(
        const Duration(milliseconds: 900),
        () {
          if (!mounted) return;

          if (round == questionOrder.length - 1) {
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
                      onPressed: () {
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
          }
        },
      );
    }
  }

  // Menghapus jawaban dan mengaktifkan kembali semua huruf.
  void resetAnswer() {
    if (isChecking) return;

    setState(() {
      answer = '';
      selectedIndices.clear();
      letters.shuffle();
    });
  }

  // Gambar maskot sesuai pilihan pemain.
  String get mascotImage {
    if (widget.store.mascot == 'PIXEL') {
      return 'assets/images/Foto Pixel.png';
    }

    return 'assets/images/Foto Netto.png';
  }

  @override
  Widget build(BuildContext context) {
    final String? currentImage = images[word];

    return Scaffold(
      body: GridBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const AppTitle(
                'GAME ZONE',
                'Susun istilah jaringan komputer',
              ),

              const SizedBox(height: 20),

              // Informasi ronde dan skor.
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

              // Maskot pemain.
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

              // Gambar perangkat sesuai soal.
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

              // Petunjuk soal.
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

              // Kotak jawaban.
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

              // Hasil pemeriksaan jawaban.
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

              // Pilihan huruf.
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 9,
                runSpacing: 9,
                children: List.generate(
                  letters.length,
                  (index) {
                    final letter = letters[index];

                    // Identitas tombol ditentukan oleh indeks.
                    final used =
                        selectedIndices.contains(index);

                    return SizedBox(
                      width: 48,
                      height: 48,
                      child: FilledButton(
                        onPressed: !used &&
                                answer.length < word.length &&
                                !isChecking
                            ? () => tap(index)
                            : null,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor:
                              const Color(0xFF176B87),
                          disabledBackgroundColor:
                              const Color(0xFF263746),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10),
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

              // Tombol hapus jawaban.
              OutlinedButton.icon(
                onPressed:
                    !isChecking ? resetAnswer : null,
                icon: const Icon(
                  Icons.backspace_outlined,
                ),
                label: const Text('HAPUS JAWABAN'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: cyan,
                  side: const BorderSide(color: cyan),
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
