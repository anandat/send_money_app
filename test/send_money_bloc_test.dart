import 'package:flutter_test/flutter_test.dart';


void main() {
  group('FakeSendMoneyService', () {
    late FakeSendMoneyService service;

    setUp(() {
      service = FakeSendMoneyService();
    });

    test('should return success and deduct balance for valid amount', () async {
      final response = await service.sendMoney(100);
      expect(response['status'], equals('success'));
      expect(response['new_balance'], equals(400));
    });

    test('should return error for insufficient balance', () async {
      final response = await service.sendMoney(1000);
      expect(response['status'], equals('error'));
      expect(response['message'], equals('Insufficient balance.'));
    });

    test('should correctly update internal balance', () async {
      await service.sendMoney(50);
      expect(service.currentBalance, equals(450));
    });
  });
}


class FakeSendMoneyService {
  double _balance = 500.00;

  Future<Map<String, dynamic>> sendMoney(double amount) async {
    await Future.delayed(const Duration(milliseconds: 10));
    if (amount > _balance) {
      return {
        'status': 'error',
        'message': 'Insufficient balance.',
      };
    }
    _balance -= amount;
    return {
      'status': 'success',
      'message': 'Money sent successfully.',
      'new_balance': _balance,
    };
  }

  double get currentBalance => _balance;
}
