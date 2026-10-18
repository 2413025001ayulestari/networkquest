
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

part 'core/theme.dart';
part 'data/game_store.dart';
part 'app.dart';
part 'widgets/grid_background.dart';
part 'widgets/common_widgets.dart';
part 'screens/home_screen.dart';
part 'data/levels.dart';
part 'screens/map_screen.dart';
part 'data/questions.dart';
part 'screens/game_screen.dart';
part 'screens/guide_screen.dart';
part 'screens/mascot_screen.dart';
part 'screens/settings_screen.dart';
part 'screens/game_zone_screen.dart';
part 'screens/splash_screen.dart';

final AudioPlayer tapPlayer = AudioPlayer();

Future<void> playTapSound() async {
  await tapPlayer.setVolume(1.0);
  await tapPlayer.stop();

  await tapPlayer.play(
    AssetSource('audio/sound_tab_layar.wav'),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NetworkQuestApp());
}