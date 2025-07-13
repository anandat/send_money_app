import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:send_money_app/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:send_money_app/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:send_money_app/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:send_money_app/features/transactions/data/models/transaction_model.dart';
import 'package:send_money_app/features/transactions/presentation/screens/transactions_screen.dart';

class FakeTransactionEvent extends Fake implements TransactionEvent {}

class MockTransactionBloc extends Mock implements TransactionBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTransactionEvent());
  });

  late TransactionBloc transactionBloc;

  setUp(() {
    transactionBloc = MockTransactionBloc();
    when(() => transactionBloc.close()).thenAnswer((_) async {});
    when(() => transactionBloc.stream).thenAnswer((_) => const Stream<TransactionState>.empty());
    when(() => transactionBloc.add(any())).thenReturn(null);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: TransactionsScreen(bloc: transactionBloc),
    );
  }

  testWidgets('shows loading indicator when state is TransactionLoading', (tester) async {
    when(() => transactionBloc.state).thenReturn(TransactionLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows transaction list when state is TransactionLoaded', (tester) async {
    final mockTransactions = [
      TransactionModel(
        id: 1,
        name: 'Alice Bob',
        email: 'alice@example.com',
        avatar: 'https://example.com/avatar1.png',
      ),
      TransactionModel(
        id: 2,
        name: 'Charlie Doe',
        email: 'charlie@example.com',
        avatar: 'https://example.com/avatar2.png',
      ),
    ];

    when(() => transactionBloc.state).thenReturn(TransactionLoaded(mockTransactions));


    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Alice Bob'), findsOneWidget);
      expect(find.text('Charlie Doe'), findsOneWidget);
    });
  });

  testWidgets('shows error message when state is TransactionError', (tester) async {
    when(() => transactionBloc.state).thenReturn(TransactionError('Something went wrong'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
