import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:send_money_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:send_money_app/features/auth/domain/entities/user.dart';
import 'package:send_money_app/features/auth/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (username == 'user' && password == '1234') {
      return User(username: username);
    }
    return null;
  }
}

void main() {
  late LoginUseCase loginUseCase;

  setUp(() {
    loginUseCase = LoginUseCase(FakeAuthRepository());
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      final bloc = AuthBloc(loginUseCase);
      expect(bloc.state, isA<AuthInitial>());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () => AuthBloc(loginUseCase),
      act: (bloc) => bloc.add(LoginRequested(username: 'user', password: '1234')),
      wait: const Duration(milliseconds: 200),
      expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when login fails',
      build: () => AuthBloc(loginUseCase),
      act: (bloc) => bloc.add(LoginRequested(username: 'foo', password: 'bar')),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<AuthLoading>(),
        predicate<AuthState>(
              (state) => state is AuthFailure && state.message == 'Invalid credentials',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess, AuthInitial] when login is followed by logout',
      build: () => AuthBloc(loginUseCase),
      act: (bloc) async {
        bloc.add(LoginRequested(username: 'user', password: '1234'));
        await Future.delayed(const Duration(milliseconds: 150));
        bloc.add(LogoutRequested());
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>(),
        isA<AuthInitial>(),
      ],
    );
  });
}
