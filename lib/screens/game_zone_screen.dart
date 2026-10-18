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
  static const words = {
    'ROUTER': 'Penghubung antarjaringan',
    'SWITCH': 'Penghubung perangkat di LAN',
    'FIREWALL': 'Penyaring lalu lintas',
    'SUBNET': 'Pembagian jaringan',
    'SERVER': 'Penyedia layanan',
  };

  late String word;
  late List<String> letters;

  int round = 0;
  int score = 0;

  String answer = '';

  @override
  void initState() {
    super.initState();
    newWord();
  }

  void newWord() {
    word = words.keys.elementAt(
      Random().nextInt(words.length),
    );

    letters = word.split('')..shuffle();
    answer = '';
  }

  void tap(String letter) {
    setState(() {
      answer += letter;
    });

    if (answer.length == word.length) {
      if (answer == word) {
        score += 50;
      }

      Timer(
        const Duration(milliseconds: 500),
        () {
          if (!mounted) {
            return;
          }

          if (round == 4) {
            showDialog(
              context: context,
              builder: (c) => AlertDialog(
                title: const Text('GAME ZONE SELESAI'),
                content: Text(
                  'Skor bonusmu: $score',
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(c);
                      Navigator.pop(context);
                    },
                    child: const Text('SELESAI'),
                  ),
                ],
              ),
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
          padding: const EdgeInsets.all(18),
          children: [
            const AppTitle(
              'GAME ZONE',
              'Susun istilah jaringan',
            ),

            const SizedBox(height: 24),

            Text(
              'RONDE ${round + 1}/5',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: lime,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // MASKOT YANG DIPILIH
            // ==================================================

            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFA31A),
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x55FFAA00),
                      blurRadius: 14,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    mascotImage,
                    width: 94,
                    height: 94,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // PETUNJUK KATA
            // ==================================================

            Text(
              words[word]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // JAWABAN
            // ==================================================

            Container(
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF102A43),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: cyan,
                ),
              ),
              child: Text(
                answer
                    .padRight(word.length, '_')
                    .split('')
                    .join(' '),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: lime,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // HURUF
            // ==================================================

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 9,
              runSpacing: 9,
              children: letters.map(
                (letter) {
                  return SizedBox(
                    width: 52,
                    height: 52,
                    child: FilledButton(
                      onPressed: answer.length < word.length
                          ? () => tap(letter)
                          : null,
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // HAPUS JAWABAN
            // ==================================================

            TextButton.icon(
              onPressed: () {
                setState(() {
                  answer = '';
                });
              },
              icon: const Icon(
                Icons.backspace_outlined,
              ),
              label: const Text(
                'HAPUS JAWABAN',
              ),
            ),
          ],
        ),
      ),
    );
  }
}