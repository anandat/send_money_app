import 'package:equatable/equatable.dart';

abstract class BalanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleVisibility extends BalanceEvent {}
