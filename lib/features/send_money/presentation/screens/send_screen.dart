import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/logout_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/send_money_bloc.dart';
import '../bloc/send_money_event.dart';
import '../bloc/send_money_state.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  void _showBottomSheet(BuildContext context, String msg, bool success) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 140,
        color: success ? Colors.green[100] : Colors.red[100],
        child: Center(
          child: Text(
            msg,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: success ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController();

    return BlocProvider(
      create: (_) => SendMoneyBloc(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Send Money'),
            actions: const [
              LogoutButton(),
            ],),
          body: BlocConsumer<SendMoneyBloc, SendMoneyState>(
            listener: (context, state) {
              if (state is SendMoneySuccess) {
                _showBottomSheet(context, 'Money sent successfully!', true);
                ctrl.clear();
              } else if (state is SendMoneyFailure) {
                _showBottomSheet(context, state.message, false);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextField(
                      controller: ctrl,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    state is SendMoneyLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              final amount =
                                  double.tryParse(ctrl.text.trim());
                              if (amount == null || amount <= 0) {
                                _showBottomSheet(context, 'Invalid amount', false);
                              } else {
                                context
                                    .read<SendMoneyBloc>()
                                    .add(SubmitAmount(amount: amount));
                              }
                            },
                            child: const Text('Submit'),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
