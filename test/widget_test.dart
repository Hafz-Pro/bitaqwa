import 'package:flutter_test/flutter_test.dart';
import 'package:bitaqwa/main.dart';

void main() {
  testWidgets('Bitaqwa menampilkan dashboard', (tester) async {
    await tester.pumpWidget(const BitaqwaApp());
    expect(find.text('Bitaqwa'), findsOneWidget);
    expect(find.text('Menu Utama'), findsOneWidget);
  });
}
