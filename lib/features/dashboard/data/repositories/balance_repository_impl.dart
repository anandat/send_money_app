import '../../domain/entities/balance.dart';
import '../../domain/repositories/balance_repository.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  @override
  Future<Balance> fetchBalance() async {
    await Future.delayed(const Duration(seconds: 1));
    return Balance(1000.0);
  }
}
