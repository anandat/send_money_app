import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/models/transaction_model.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final response = await DioClient.instance.get('/api/users');
      final list = (response.data['data'] as List)
          .map((item) => TransactionModel.fromJson(item))
          .toList();
      emit(TransactionLoaded(list));
    } catch (e) {
      emit(TransactionError('Failed to fetch transactions'));
    }
  }
}
