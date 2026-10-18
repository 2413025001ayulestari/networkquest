part of '../main.dart';

class GameStore extends ChangeNotifier {
  int unlocked = 1, totalScore = 0;
  String mascot = 'NETTO';
  bool sound = true, animation = true, hard = false;
  List<int> stars = List.filled(7, 0);

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    unlocked = p.getInt('unlocked') ?? 1;
    totalScore = p.getInt('score') ?? 0;
    mascot = p.getString('mascot') ?? 'NETTO';
    sound = p.getBool('sound') ?? true;
    animation = p.getBool('animation') ?? true;
    hard = p.getBool('hard') ?? false;
    final saved = p.getStringList('stars');
    if (saved != null && saved.length == 7) stars = saved.map((e) => int.tryParse(e) ?? 0).toList();
    notifyListeners();
  }

  Future<void> finish(int level, int score, int earnedStars) async {
    stars[level - 1] = max(stars[level - 1], earnedStars);
    totalScore += score;
    unlocked = max(unlocked, min(7, level + 1));
    await save();
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('unlocked', unlocked);
    await p.setInt('score', totalScore);
    await p.setString('mascot', mascot);
    await p.setBool('sound', sound);
    await p.setBool('animation', animation);
    await p.setBool('hard', hard);
    await p.setStringList('stars', stars.map((e) => '$e').toList());
    notifyListeners();
  }

  Future<void> reset() async {
    unlocked = 1; totalScore = 0; stars = List.filled(7, 0);
    await save();
  }
}
