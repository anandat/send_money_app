import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<List<Transaction>> fetchTransactions() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Transaction(id: '1', description: 'Coffee', amount: 3.5, date: DateTime.now()),
      Transaction(id: '2', description: 'Groceries', amount: 42.0, date: DateTime.now()),
    ];
  }
}
