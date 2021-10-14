import 'package:clypto/app.dart';
import 'package:clypto/presentation/home/view/home.dart';
// import 'package:clypto/presentation/counter/view/counter_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
