import '../../domain/entities/transfer.dart';
import '../../domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  @override
  Future<void> sendMoney(Transfer transfer) async {
    await Future.delayed(const Duration(seconds: 1));

  }
}
