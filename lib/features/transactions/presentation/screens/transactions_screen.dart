import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/logout_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionBloc()..add(LoadTransactions()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaction History'),
          actions: const [
            LogoutButton(),
          ],
        ),
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.transactions.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, idx) {
                  final tx = state.transactions[idx];
                  return ListTile(
                    leading:
                        CircleAvatar(backgroundImage: NetworkImage(tx.avatar)),
                    title: Text(tx.name),
                    subtitle: Text('Email: ${tx.email}'),
                  );
                },
              );
            } else if (state is TransactionError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No transactions.'));
            }
          },
        ),
      ),
    );
  }
}
