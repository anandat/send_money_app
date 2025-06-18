import 'package:equatable/equatable.dart';

abstract class SendMoneyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitAmount extends SendMoneyEvent {
  final double amount;
  SubmitAmount({required double this.amount});

  @override
  List<Object?> get props => [amount];
}
