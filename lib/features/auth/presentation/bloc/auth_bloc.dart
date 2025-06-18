import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>((event, emit) => emit(AuthInitial()));
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (event.username == 'user' && event.password == '1234') {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure('Invalid credentials'));
    }
  }
}
