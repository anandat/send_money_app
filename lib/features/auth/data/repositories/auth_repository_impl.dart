import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'user' && password == '1234') {
      return User(username: username);
    }
    return null;
  }
}
