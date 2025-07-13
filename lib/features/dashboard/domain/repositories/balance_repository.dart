import '../entities/balance.dart';

abstract class BalanceRepository {
  Future<Balance> fetchBalance();
}
