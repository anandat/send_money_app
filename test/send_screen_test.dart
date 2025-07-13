import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:send_money_app/core/network/dio_client.dart';
import 'package:send_money_app/features/send_money/presentation/bloc/send_money_bloc.dart';
import 'package:send_money_app/features/send_money/presentation/bloc/send_money_event.dart';
import 'package:send_money_app/features/send_money/presentation/bloc/send_money_state.dart';


class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late SendMoneyBloc bloc;

  setUpAll(() {

    registerFallbackValue(RequestOptions(path: ''));
  });

  setUp(() {
    mockDio = MockDio();
    DioClient.instance = mockDio;
    bloc = SendMoneyBloc(dio: mockDio);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is SendMoneyInitial', () {
    expect(bloc.state, isA<SendMoneyInitial>());
  });

  blocTest<SendMoneyBloc, SendMoneyState>(
    'emits [SendMoneyLoading, SendMoneySuccess] when POST returns 201',
    build: () {
      when(() => mockDio.post(
        '/api/users',
        data: {
          'name': 'Send Money',
          'job': 'Sent ₱100.0',
        },
      )).thenAnswer((_) async => Response<void>(
        statusCode: 201,
        requestOptions: RequestOptions(path: '/api/users'),
      ));
      return SendMoneyBloc(dio: mockDio);
    },
    act: (bloc) => bloc.add(SubmitAmount(amount: 100.0)),
    expect: () => [
      SendMoneyLoading(),
      SendMoneySuccess(),
    ],
  );

  blocTest<SendMoneyBloc, SendMoneyState>(
    'emits [SendMoneyLoading, SendMoneyFailure] when POST returns non-201',
    build: () {
      when(() => mockDio.post(
        '/api/users',
        data: {
          'name': 'Send Money',
          'job': 'Sent ₱50.0',
        },
      )).thenAnswer((_) async => Response<void>(
        statusCode: 400,
        requestOptions: RequestOptions(path: '/api/users'),
      ));
      return SendMoneyBloc(dio: mockDio);
    },
    act: (bloc) => bloc.add(SubmitAmount(amount: 50.0)),
    expect: () => [
      SendMoneyLoading(),
      isA<SendMoneyFailure>()
          .having((f) => f.message, 'message', 'Failed to send money'),
    ],
  );

  blocTest<SendMoneyBloc, SendMoneyState>(
    'emits [SendMoneyLoading, SendMoneyFailure] when Dio throws',
    build: () {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: '/api/users'),
          error: 'Network error',
        ),
      );
      return SendMoneyBloc(dio: mockDio);
    },
    act: (bloc) => bloc.add(SubmitAmount(amount: 200.0)),
    expect: () => [
      SendMoneyLoading(),
      isA<SendMoneyFailure>().having(
            (f) => f.message,
        'message',
        startsWith('Error:'),
      ),
    ],
  );
}
