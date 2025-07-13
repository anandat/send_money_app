import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:send_money_app/features/dashboard/presentation/bloc/balance_bloc.dart';
import 'package:send_money_app/features/dashboard/presentation/bloc/balance_event.dart';
import 'package:send_money_app/features/dashboard/presentation/bloc/balance_state.dart';
import 'package:send_money_app/features/dashboard/presentation/screens/dashboard_screen.dart';


void main() {
  group('BalanceBloc', () {
    test('initial state is BalanceState(balance: 500.0, hidden: false)', () {
      final bloc = BalanceBloc();
      expect(bloc.state, const BalanceState(balance: 500.0, hidden: false));
    });

    blocTest<BalanceBloc, BalanceState>(
      'emits [hidden: true] when ToggleVisibility is added',
      build: () => BalanceBloc(),
      act: (bloc) => bloc.add(ToggleVisibility()),
      expect: () => [const BalanceState(balance: 500.0, hidden: true)],
    );

    blocTest<BalanceBloc, BalanceState>(
      'toggles back to visible when ToggleVisibility added twice',
      build: () => BalanceBloc(),
      act: (bloc) {
        bloc.add(ToggleVisibility());
        bloc.add(ToggleVisibility());
      },
      expect: () => [
        const BalanceState(balance: 500.0, hidden: true),
        const BalanceState(balance: 500.0, hidden: false),
      ],
    );
  });

  group('DashboardScreen Widget Tests', () {
    testWidgets('displays initial balance and visibility icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const DashboardScreen(),
        ),
      );
      expect(find.text('Balance: ₱500.00'), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets('toggles balance visibility when visibility icon is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const DashboardScreen(),
        ),
      );
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();
      expect(find.text('Balance: ******'), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });
}
