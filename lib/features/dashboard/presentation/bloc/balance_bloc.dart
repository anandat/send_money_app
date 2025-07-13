import 'package:flutter_bloc/flutter_bloc.dart';
import 'balance_event.dart';
import 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(const BalanceState(balance: 500.0, hidden: false)) {
    on<ToggleVisibility>((event, emit) {
      emit(state.copyWith(hidden: !state.hidden));
    });
  }
}
