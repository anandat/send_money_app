import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:send_money_app/widgets/logout_button.dart';


class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late AuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();


    when(() => authBloc.state).thenReturn(AuthInitial());
    when(() => authBloc.stream).thenAnswer((_) => Stream<AuthState>.empty());
  });



  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: const LogoutButton(),
        ),
      ),
    );
  }

  testWidgets('shows confirmation dialog when logout button is tapped', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    expect(find.text('Confirm Sign Out'), findsOneWidget);
    expect(find.text('Are you sure you want to sign out?'), findsOneWidget);
  });

  testWidgets('does not call LogoutRequested if Cancel is tapped', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verifyNever(() => authBloc.add(LogoutRequested()));
  });

  testWidgets('calls LogoutRequested if Sign Out is tapped', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign Out'));
    await tester.pumpAndSettle();

    verify(() => authBloc.add(LogoutRequested())).called(1);
  });
}
