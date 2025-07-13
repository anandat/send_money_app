import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/logout_button.dart';
import '../bloc/send_money_bloc.dart';
import '../bloc/send_money_event.dart';
import '../bloc/send_money_state.dart';

class SendScreen extends StatefulWidget {
  final SendMoneyBloc? injectedBloc;

  const SendScreen({super.key, this.injectedBloc});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen>
    with SingleTickerProviderStateMixin {
  final _ctrl = TextEditingController();
  bool _showSuccess = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  void _triggerSuccessAnimation() async {
    setState(() => _showSuccess = true);
    _animationController.forward();

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      _animationController.reverse();
      setState(() => _showSuccess = false);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendMoneyBloc>(
      create: (_) => widget.injectedBloc ?? SendMoneyBloc(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text(
              'Send Money',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            actions: const [LogoutButton()],
          ),
          body: Stack(
            children: [
              BlocConsumer<SendMoneyBloc, SendMoneyState>(
                listener: (context, state) {
                  if (state is SendMoneySuccess) {
                    _triggerSuccessAnimation();
                    _ctrl.clear();
                  } else if (state is SendMoneyFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter amount to send",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _ctrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Amount in PHP',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: state is SendMoneyLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                            onPressed: () {
                              final amount =
                              double.tryParse(_ctrl.text.trim());
                              if (amount == null || amount <= 0) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content:
                                    Text('Invalid amount')));
                              } else {
                                context.read<SendMoneyBloc>().add(
                                    SubmitAmount(amount: amount));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // ✅ Animated Success Overlay
              if (_showSuccess)
                Center(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, __) {
                      return Opacity(
                        opacity: _animationController.value,
                        child: Transform.scale(
                          scale: _animationController.value,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle,
                                    size: 64, color: Colors.green),
                                SizedBox(height: 12),
                                Text(
                                  'Success!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
