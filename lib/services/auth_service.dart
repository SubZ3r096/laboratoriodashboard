import '../models/user.dart';
import 'mock_data_service.dart';

class AuthService {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final user = MockDataService.users.firstWhere(
      (u) => u.email == email,
      orElse: () => throw Exception('Usuario no encontrado'),
    );
    if (password == 'admin123' || password == 'user123') {
      _currentUser = user;
      return true;
    }
    throw Exception('Contraseña incorrecta');
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }
}
