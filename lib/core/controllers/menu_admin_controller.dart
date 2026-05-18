import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';
import '../services/mock_data_service.dart';

class MenuAdminController extends ChangeNotifier {
  List<MenuItem> _menuItems = [];
  bool _isLoading = false;

  List<MenuItem> get menuItems => _menuItems;
  bool get isLoading => _isLoading;

  void loadMenu() {
    _isLoading = true;
    notifyListeners();
    _menuItems = List.from(MockDataService.menuItems);
    _isLoading = false;
    notifyListeners();
  }

  List<MenuItem> getByCategory(MenuCategory category) {
    return _menuItems.where((item) => item.category == category).toList();
  }

  void toggleAvailability(String id) {
    final index = _menuItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      _menuItems[index] = MenuItem(
        id: _menuItems[index].id,
        name: _menuItems[index].name,
        description: _menuItems[index].description,
        category: _menuItems[index].category,
        price: _menuItems[index].price,
        isAvailable: !_menuItems[index].isAvailable,
        imageUrl: _menuItems[index].imageUrl,
      );
      notifyListeners();
    }
  }

  void addItem(MenuItem item) {
    _menuItems.add(item);
    notifyListeners();
  }

  void updateItem(MenuItem updatedItem) {
    final index = _menuItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _menuItems[index] = updatedItem;
      notifyListeners();
    }
  }

  void deleteItem(String id) {
    _menuItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
