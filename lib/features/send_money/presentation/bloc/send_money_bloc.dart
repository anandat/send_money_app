import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/dio_client.dart';
import 'send_money_event.dart';
import 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  final Dio dio;

  SendMoneyBloc({Dio? dio})
      : dio = dio ?? DioClient.instance,
        super(SendMoneyInitial()) {
    on<SubmitAmount>(_onSubmitAmount);
  }

  Future<void> _onSubmitAmount(
      SubmitAmount event,
      Emitter<SendMoneyState> emit,
      ) async {
    emit(SendMoneyLoading());
    try {
      final response = await dio.post(
        '/api/users',
        data: {
          "name": "Send Money",
          "job": "Sent ₱${event.amount}"
        },
      );
      if (response.statusCode == 201) {
        emit(SendMoneySuccess());
      } else {
        emit(SendMoneyFailure('Failed to send money'));
      }
    } catch (e) {
      emit(SendMoneyFailure('Error: ${e.toString()}'));
    }
  }
}