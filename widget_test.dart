import 'package:flutter_test/flutter_test.dart';
import 'package:hostel_expense_tracker/main.dart';

void main() {
  testWidgets('HostelTrack dashboard starts', (tester) async {
    await tester.pumpWidget(const HostelTrackApp());
    await tester.pumpAndSettle();
    expect(find.text('HostelTrack'), findsOneWidget);
    expect(find.text('Recent expenses'), findsOneWidget);
  });
}
