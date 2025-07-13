import '../entities/transfer.dart';
import '../repositories/transfer_repository.dart';

class SendMoneyUseCase {
  final TransferRepository repository;

  SendMoneyUseCase(this.repository);

  Future<void> execute(Transfer transfer) => repository.sendMoney(transfer);
}
