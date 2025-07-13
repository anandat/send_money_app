// test/balance_bloc_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:send_money_app/features/dashboard/presentation/bloc/balance_bloc.dart';
import 'package:send_money_app/features/dashboard/presentation/bloc/balance_event.dart';
import 'package:send_money_app/features/dashboard/presentation/bloc/balance_state.dart';

void main() {
  group('BalanceBloc', () {
    test('UT-001: initial state is correct', () {
      final bloc = BalanceBloc();
      expect(bloc.state.balance, 500.0);
      expect(bloc.state.hidden, false);
    });

    blocTest<BalanceBloc, BalanceState>(
      'UT-002: toggles hidden on ToggleVisibility',
      build: () => BalanceBloc(),
      act: (b) => b.add(ToggleVisibility()),
      expect: () => [BalanceState(balance: 500.0, hidden: true)],
    );

    blocTest<BalanceBloc, BalanceState>(
      'UT-003: toggles twice returns to original',
      build: () => BalanceBloc(),
      act: (b) {
        b.add(ToggleVisibility());
        b.add(ToggleVisibility());
      },
      expect: () => [
        BalanceState(balance: 500.0, hidden: true),
        BalanceState(balance: 500.0, hidden: false),
      ],
    );
  });
}
