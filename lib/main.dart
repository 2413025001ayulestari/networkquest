import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void main() => runApp(const NetworkQuestApp());
