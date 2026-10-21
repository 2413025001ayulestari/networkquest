
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
  bool _processing = false;

  int? selected;

  late List<Question> qs;

  final AudioPlayer _audioPlayer = AudioPlayer();

  // ============================================================
  // MEMUTAR AUDIO
  // ============================================================

  Future<void> _playSound(String fileName) async {
    if (!widget.store.sound) {
      debugPrint('Audio nonaktif melalui pengaturan.');
      return;
    }

    try {
      debugPrint('Memutar audio: assets/audio/$fileName');

      await _audioPlayer.stop();

      await _audioPlayer.play(
        AssetSource('audio/$fileName'),
      );

      debugPrint('Audio berhasil dipanggil: $fileName');
    } catch (e, stackTrace) {
      debugPrint('Gagal memutar audio: $fileName');
      debugPrint('Penyebab: $e');
      debugPrint('$stackTrace');
    }
  }

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    // Pastikan nomor level valid.
    if (widget.level < 1 ||
        widget.level > questions.length) {
      qs = [];
      return;
    }

    // Ambil soal berdasarkan level.
    qs = List<Question>.from(
      questions[widget.level - 1],
    );

    // Acak soal jika mode sulit aktif.
    if (widget.store.hard) {
      qs.shuffle();
    }
  }

  // ============================================================
  // MEMILIH JAWABAN
  // ============================================================

  Future<void> pick(int i) async {
    if (answered || _processing || qs.isEmpty) {
      return;
    }

    if (i < 0 || i >= qs[index].options.length) {
      return;
    }

    final bool correct = i == qs[index].answer;

    setState(() {
      selected = i;
      answered = true;

      if (correct) {
        score += 5;
      } else {
        lives--;
      }
    });

    // Jawaban benar.
    if (correct) {
      debugPrint('JAWABAN BENAR');

      await _playSound(
        'ketika_jawaban_benar.mp3',
      );
    }

    // Jawaban salah dan nyawa habis.
    else if (lives <= 0) {
      debugPrint('JAWABAN SALAH: NYAWA HABIS');

      await _playSound(
        'sound_hati_habis.mp3',
      );
    }

    // Jawaban salah, tetapi nyawa masih tersedia.
    else {
      debugPrint('JAWABAN SALAH');

      await _playSound(
        'ketika_jawaban_salah.mp3',
      );
    }
  }

  // ============================================================
  // SOAL BERIKUTNYA DAN HASIL AKHIR
  // ============================================================

  Future<void> next() async {
    if (!answered || _processing || qs.isEmpty) {
      return;
    }

    // Cegah tombol ditekan berulang kali saat proses berjalan.
    _processing = true;

    try {
      // Masih ada soal dan nyawa masih tersedia.
      if (index + 1 < qs.length && lives > 0) {
        if (!mounted) return;

        setState(() {
          index++;
          answered = false;
          selected = null;
        });

        return;
      }

      // Hitung persentase skor.
      final double percentage =
          score / (qs.length * 5);

      // Tentukan jumlah bintang.
      final int stars = percentage >= 0.9
          ? 3
          : percentage >= 0.6
              ? 2
              : percentage > 0
                  ? 1
                  : 0;

      // Simpan hasil hanya jika pemain masih memiliki nyawa.
      if (lives > 0) {
        final int previousUnlocked =
            widget.store.unlocked;

        await widget.store.finish(
          widget.level,
          score,
          stars,
        );

        // Periksa apakah level baru berhasil terbuka.
        final bool unlockedNewLevel =
            widget.level < 7 &&
            widget.level >= previousUnlocked &&
            widget.store.unlocked > previousUnlocked;

        if (unlockedNewLevel) {
          debugPrint('LEVEL BARU TERBUKA');

          await _playSound(
            'sound_naik_level.mp3',
          );
        }
      }

      if (!mounted) return;

      // Tampilkan dialog hasil.
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            backgroundColor: const Color(0xFF102A43),

            title: Text(
              lives > 0 ? 'MISI SELESAI!' : 'NYAWA HABIS',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  lives > 0
                      ? Icons.emoji_events_rounded
                      : Icons.heart_broken_rounded,
                  size: 70,
                  color: lives > 0
                      ? orange
                      : Colors.redAccent,
                ),

                const SizedBox(height: 12),

                Text(
                  lives > 0
                      ? '${'★' * stars}${'☆' * (3 - stars)}\nSkor $score'
                      : 'Nyawamu habis.\nPelajari panduan, lalu coba lagi.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (lives > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Jawaban benar: ${score ~/ 5} dari ${qs.length} soal',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),

            actions: [
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('KEMBALI KE PETA'),
                ),
              ),
            ],
          );
        },
      );

      // Kembali ke peta setelah dialog ditutup.
      if (!mounted) return;

      Navigator.pop(context);
    } catch (e, stackTrace) {
      debugPrint('Gagal menyelesaikan kuis: $e');
      debugPrint('$stackTrace');
    } finally {
      _processing = false;
    }
  }

  // ============================================================
  // DISPOSE AUDIO
  // ============================================================

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    // Pengamanan jika soal untuk level belum tersedia.
    if (qs.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF102A43),
        appBar: AppBar(
          title: const Text('Network Quest'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 60,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Soal untuk level ini belum tersedia.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('KEMBALI'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final q = qs[index];

    return Scaffold(
      body: GridBackground(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            // JUDUL LEVEL

            AppTitle(
              'LEVEL ${widget.level}',
              levelNames[widget.level - 1],
            ),

            const SizedBox(height: 18),

            // SKOR DAN NYAWA

            Row(
              children: [
                ScoreChip(
                  score: score,
                ),

                const Spacer(),

                ...List.generate(
                  3,
                  (i) => Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: i < lives
                          ? Colors.redAccent
                          : Colors.white24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // PROGRESS SOAL

            LinearProgressIndicator(
              value: (index + 1) / qs.length,
              color: lime,
              backgroundColor: const Color(0xFF244B68),
              minHeight: 7,
              borderRadius: BorderRadius.circular(8),
            ),

            const SizedBox(height: 8),

            Text(
              'Soal ${index + 1} dari ${qs.length}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 22),

            // GAMBAR SOAL

            Center(
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  maxHeight: 220,
                  minHeight: 150,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF102A43),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF34617D),
                    width: 2,
                  ),
                ),
                child: q.image != null && q.image!.isNotEmpty
                    ? Image.asset(
                        q.image!,
                        fit: BoxFit.contain,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          debugPrint(
                            'Gagal memuat gambar: ${q.image}',
                          );
                          debugPrint('$error');

                          return Center(
                            child: Text(
                              'Gambar gagal dimuat.\n${q.image}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'Gambar soal belum tersedia.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 13,
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // PERTANYAAN

            Text(
              q.prompt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 24),

            // PILIHAN JAWABAN

            ...List.generate(
              q.options.length,
              (i) {
                final bool correct = i == q.answer;

                Color? color;

                if (answered && correct) {
                  color = lime;
                }

                if (answered &&
                    selected == i &&
                    !correct) {
                  color = Colors.redAccent;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OutlinedButton(
                    onPressed: answered || _processing
                        ? null
                        : () => pick(i),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: color?.withValues(
                        alpha: 0.18,
                      ),
                      foregroundColor: cream,
                      disabledForegroundColor: cream,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            q.options[i],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        if (answered && correct)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: lime,
                          ),

                        if (answered &&
                            selected == i &&
                            !correct)
                          const Icon(
                            Icons.cancel_rounded,
                            color: Colors.redAccent,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // INFORMASI JAWABAN

            if (answered) ...[
              Card(
                color: const Color(0xFF102A43),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        selected == q.answer
                            ? Icons.check_circle_rounded
                            : Icons.info_outline_rounded,
                        color: selected == q.answer
                            ? lime
                            : orange,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          q.fact,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // TOMBOL SOAL BERIKUTNYA / HASIL

              FilledButton(
                onPressed: _processing ? null : next,
                child: Text(
                  index + 1 == qs.length || lives <= 0
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
