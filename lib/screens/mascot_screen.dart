part of '../main.dart';

class MascotScreen extends StatefulWidget {
  final GameStore store;

  const MascotScreen({
    super.key,
    required this.store,
  });

  @override
  State<MascotScreen> createState() => _MascotScreenState();
}

class _MascotScreenState extends State<MascotScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: GridBackground(
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const AppTitle(
                'PILIH MASKOT',
                'Siapa yang menemani petualanganmu?',
              ),

              const SizedBox(height: 24),

              ...['NETTO', 'PIXEL'].map((name) {
                final chosen = widget.store.mascot == name;

                final imagePath = name == 'NETTO'
                    ? 'assets/images/Foto Netto.png'
                    : 'assets/images/Foto Pixel.png';

                return Card(
                  child: InkWell(
                    onTap: () async {
                      widget.store.mascot = name;
                      await widget.store.save();
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              imagePath,
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                Text(
                                  name == 'NETTO'
                                      ? 'Si jagoan router'
                                      : 'Si jago atur IP',
                                  style: const TextStyle(
                                    color: Color(0xFF9DB5C8),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  chosen
                                      ? 'DIPAKAI'
                                      : 'KETUK UNTUK PILIH',
                                  style: TextStyle(
                                    color: chosen ? lime : cyan,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (chosen)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: lime,
                              size: 30,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
}