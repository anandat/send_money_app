import 'package:equatable/equatable.dart';

abstract class SendMoneyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMoneyInitial extends SendMoneyState {}

class SendMoneyLoading extends SendMoneyState {}

class SendMoneySuccess extends SendMoneyState {}

class SendMoneyFailure extends SendMoneyState {
  final String message;
  SendMoneyFailure(this.message);

  @override
  List<Object?> get props => [message];
}

