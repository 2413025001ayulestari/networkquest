part of 'main.dart';

class NetworkQuestApp extends StatefulWidget {
  const NetworkQuestApp({super.key});
  @override State<NetworkQuestApp> createState() => _NetworkQuestAppState();
}
class _NetworkQuestAppState extends State<NetworkQuestApp> {
  final store = GameStore();
  @override void initState() { super.initState(); store.load(); }
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Network Quest',
    theme: ThemeData(
      useMaterial3: true, brightness: Brightness.dark,
      scaffoldBackgroundColor: navy,
      colorScheme: ColorScheme.fromSeed(seedColor: cyan, brightness: Brightness.dark, primary: cyan, secondary: lime, surface: const Color(0xFF102A43)),
      fontFamily: 'sans-serif',
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      cardTheme: CardThemeData(color: const Color(0xFF102A43), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Color(0xFF244B68)))),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: lime, foregroundColor: navy, minimumSize: const Size.fromHeight(54), textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
    ),
    home: SplashScreen(store: store),
  );
}
