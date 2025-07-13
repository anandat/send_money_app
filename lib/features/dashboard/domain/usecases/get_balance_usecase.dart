import '../entities/balance.dart';
import '../repositories/balance_repository.dart';

class GetBalanceUseCase {
  final BalanceRepository repository;

  GetBalanceUseCase(this.repository);

  Future<Balance> execute() => repository.fetchBalance();
}
