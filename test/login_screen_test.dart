
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:send_money_app/features/auth/presentation/screens/login_screen.dart';


class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  group('LoginScreen Widget Tests', () {
    late MockAuthBloc mockBloc;

    setUp(() {
      mockBloc = MockAuthBloc();

      whenListen(
        mockBloc,
        Stream<AuthState>.value(AuthInitial()),
        initialState: AuthInitial(),
      );
    });

    testWidgets(
        'renders username, password fields and login button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: mockBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byKey(const Key('loginButton')), findsOneWidget);
    });

    testWidgets(
        'shows loading indicator when state is AuthLoading', (tester) async {
      whenListen(
        mockBloc,
        Stream<AuthState>.value(AuthLoading()),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: mockBloc,
            child: const LoginScreen(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays SnackBar on login failure', (tester) async {
      whenListen(
        mockBloc,
        Stream<AuthState>.fromIterable([
          AuthInitial(),
          AuthLoading(),
          AuthFailure('Invalid credentials'),
        ]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: mockBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.enterText(find
          .byType(TextField)
          .first, 'foo');
      await tester.enterText(find
          .byType(TextField)
          .last, 'bar');
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Invalid credentials'), findsOneWidget);
    });

    testWidgets('navigates to /dashboard on login success', (tester) async {
      whenListen(
        mockBloc,
        Stream<AuthState>.fromIterable([
          AuthInitial(),
          AuthLoading(),
          AuthSuccess(),
        ]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/dashboard': (_) => const Scaffold(body: Text('Dashboard'))
          },
          home: BlocProvider<AuthBloc>.value(
            value: mockBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.enterText(find
          .byType(TextField)
          .first, 'user');
      await tester.enterText(find
          .byType(TextField)
          .last, '1234');
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Dashboard'), findsOneWidget);
    });
  });
}