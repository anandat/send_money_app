import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';
import 'features/send_money/presentation/screens/send_screen.dart';
import 'features/transactions/presentation/screens/transactions_screen.dart';

void main() {
  runApp(const SendMoneyApp());
}

class SendMoneyApp extends StatelessWidget {
  const SendMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginUseCase = LoginUseCase(AuthRepositoryImpl());
    return BlocProvider(
      create: (_) => AuthBloc(loginUseCase),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Send Money App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const LoginScreen(),
          '/dashboard': (_) => BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }
            }
            ,
            child: const DashboardScreen(),
          ),
          '/send': (_) => const SendScreen(),
          '/transactions': (_) => const TransactionsScreen(),
        },
      ),
    );
  }
}
