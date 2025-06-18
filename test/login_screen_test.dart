import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/features/auth/presentation/screens/login_screen.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  testWidgets('LoginScreen shows username and password fields and login button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
          child: const LoginScreen(),
        ),
      ),
    );


    expect(find.byType(TextField), findsNWidgets(2));


    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
