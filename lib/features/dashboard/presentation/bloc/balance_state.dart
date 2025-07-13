import 'package:equatable/equatable.dart';

class BalanceState extends Equatable {
  final double balance;
  final bool hidden;

  const BalanceState({required this.balance, required this.hidden});

  BalanceState copyWith({double? balance, bool? hidden}) {
    return BalanceState(
      balance: balance ?? this.balance,
      hidden: hidden ?? this.hidden,
    );
  }

  @override
  List<Object?> get props => [balance, hidden];
}
