import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/mock_data_service.dart';

class UsersController extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  void loadUsers() {
    _isLoading = true;
    notifyListeners();
    _users = List.from(MockDataService.users);
    _isLoading = false;
    notifyListeners();
  }

  void toggleUserStatus(String id) {
    final index = _users.indexWhere((u) => u.id == id);
    if (index != -1) {
      _users[index] = User(
        id: _users[index].id,
        name: _users[index].name,
        email: _users[index].email,
        role: _users[index].role,
        createdAt: _users[index].createdAt,
        isActive: !_users[index].isActive,
      );
      notifyListeners();
    }
  }
}
