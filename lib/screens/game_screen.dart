part of '../main.dart';

class QuizScreen extends StatefulWidget {
  final GameStore store;
  final int level;

  const QuizScreen({
    super.key,
    required this.store,
    required this.level,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int lives = 3;
  int score = 0;
  bool answered = false;
  int? selected;
  late List<Question> qs;

  @override
  void initState() {
    super.initState();

    qs = [...questions[widget.level - 1]];

    if (widget.store.hard) {
      qs.shuffle();
    }
  }

  void pick(int i) {
    if (answered) {
      return;
    }

    final ok = i == qs[index].answer;

    setState(() {
      selected = i;
      answered = true;

      if (ok) {
        score += 5;
      } else {
        lives--;
      }
    });
  }

  Future<void> next() async {
    if (index + 1 < qs.length && lives > 0) {
      setState(() {
        index++;
        answered = false;
        selected = null;
      });
    } else {
      final pct = score / (qs.length * 100);
      final s = pct >= .9
          ? 3
          : pct >= .6
              ? 2
              : pct > 0
                  ? 1
                  : 0;

      if (lives > 0) {
        await widget.store.finish(
          widget.level,
          score,
          s,
        );
      }

      if (!mounted) {
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) => AlertDialog(
          backgroundColor: const Color(0xFF102A43),
          title: Text(
            lives > 0 ? 'MISI SELESAI!' : 'NYAWA HABIS',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                lives > 0
                    ? Icons.emoji_events_rounded
                    : Icons.heart_broken_rounded,
                size: 70,
                color: lives > 0 ? orange : Colors.redAccent,
              ),
              const SizedBox(height: 12),
              Text(
                lives > 0
                    ? '${'★' * s}${'☆' * (3 - s)}\nSkor $score'
                    : 'Pelajari panduan lalu coba lagi.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(c);
                Navigator.pop(context);
              },
              child: const Text('KEMBALI KE PETA'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = qs[index];

    return Scaffold(
      body: GridBackground(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            AppTitle(
              'LEVEL ${widget.level}',
              levelNames[widget.level - 1],
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                ScoreChip(score: score),
                const Spacer(),
                ...List.generate(
                  3,
                  (i) => Icon(
                    Icons.favorite_rounded,
                    color: i < lives
                        ? Colors.redAccent
                        : Colors.white24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            LinearProgressIndicator(
              value: (index + 1) / qs.length,
              color: lime,
              backgroundColor: const Color(0xFF244B68),
              minHeight: 7,
              borderRadius: BorderRadius.circular(8),
            ),

            const SizedBox(height: 26),

            Icon(
              levelIcons[widget.level - 1],
              color: cyan,
              size: 76,
            ),

            const SizedBox(height: 20),

            Text(
              q.prompt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 24),

            ...List.generate(
              q.options.length,
              (i) {
                final correct = i == q.answer;

                Color? color;

                if (answered && correct) {
                  color = lime;
                }

                if (answered && selected == i && !correct) {
                  color = Colors.redAccent;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OutlinedButton(
                    onPressed: () => pick(i),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: color?.withValues(alpha: .18),
                      foregroundColor: cream,
                      side: BorderSide(
                        color: color ??
                            const Color(0xFF34617D),
                        width: 2,
                      ),
                      minimumSize: const Size.fromHeight(54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      q.options[i],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            if (answered) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        selected == q.answer
                            ? Icons.check_circle
                            : Icons.info,
                        color: selected == q.answer
                            ? lime
                            : orange,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(q.fact),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              FilledButton(
                onPressed: next,
                child: Text(
                  index + 1 == qs.length || lives == 0
                      ? 'LIHAT HASIL'
                      : 'SOAL BERIKUTNYA',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}