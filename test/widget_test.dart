import 'package:flutter_test/flutter_test.dart';
import 'package:network_quest/main.dart';
void main(){testWidgets('menu utama tampil',(tester)async{await tester.pumpWidget(const NetworkQuestApp());await tester.pumpAndSettle();expect(find.text('NETWORK QUEST'),findsOneWidget);expect(find.text('MULAI PETUALANGAN'),findsOneWidget);});}
