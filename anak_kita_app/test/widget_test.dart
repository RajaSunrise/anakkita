import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anak_kita_app/main.dart';

void main() {
  testWidgets('App starts at Login Screen', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that Login Screen is displayed
    expect(find.text('Masukkan PIN Orang Tua'), findsOneWidget);
    expect(find.text('Anak Kita'), findsOneWidget);
  });
}
