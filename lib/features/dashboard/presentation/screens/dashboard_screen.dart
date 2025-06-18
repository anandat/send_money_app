import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/logout_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/balance_bloc.dart';
import '../bloc/balance_event.dart';
import '../bloc/balance_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BalanceBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wallet Dashboard'),
          actions: const [
            LogoutButton(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              BlocBuilder<BalanceBloc, BalanceState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.hidden
                            ? 'Balance: ******'
                            : 'Balance: ${state?.balance.toStringAsFixed(2)} PHP',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(state.hidden
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            context.read<BalanceBloc>().add(ToggleVisibility()),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/send'),
                child: const Text('Send Money'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/transactions'),
                child: const Text('View Transactions'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
