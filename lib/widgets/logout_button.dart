import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:send_money_app/features/auth/presentation/bloc/auth_event.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Sign Out',
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Confirm Sign Out'),
            content: Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel')),
              TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Sign Out')),
            ],
          ),
        );

        if (confirmed == true) {
          context.read<AuthBloc>().add(LogoutRequested());
        }
      },

    );
  }
}
