import 'package:flutter/foundation.dart';
import '../services/mock_data_service.dart';

class ReportsController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void loadReports() {
    _isLoading = true;
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

  Map<String, int> getOrdersByCategory() {
    final platillos = MockDataService.menuItems.where((m) => m.category.name == 'platillo').map((m) => m.id).toSet();
    final bebidas = MockDataService.menuItems.where((m) => m.category.name == 'bebida').map((m) => m.id).toSet();
    final postres = MockDataService.menuItems.where((m) => m.category.name == 'postre').map((m) => m.id).toSet();

    int pCount = 0, bCount = 0, poCount = 0;
    for (final order in MockDataService.orders) {
      for (final item in order.items) {
        if (platillos.contains(item.menuItemId)) pCount += item.quantity;
        if (bebidas.contains(item.menuItemId)) bCount += item.quantity;
        if (postres.contains(item.menuItemId)) poCount += item.quantity;
      }
    }
    return {'Platillos': pCount, 'Bebidas': bCount, 'Postres': poCount};
  }

  Map<String, double> getRevenueByCategory() {
    final platillos = MockDataService.menuItems.where((m) => m.category.name == 'platillo').map((m) => m.id).toSet();
    final bebidas = MockDataService.menuItems.where((m) => m.category.name == 'bebida').map((m) => m.id).toSet();
    final postres = MockDataService.menuItems.where((m) => m.category.name == 'postre').map((m) => m.id).toSet();

    double pRev = 0, bRev = 0, poRev = 0;
    for (final order in MockDataService.orders.where((o) => o.status.name == 'entregada')) {
      for (final item in order.items) {
        if (platillos.contains(item.menuItemId)) pRev += item.subtotal;
        if (bebidas.contains(item.menuItemId)) bRev += item.subtotal;
        if (postres.contains(item.menuItemId)) poRev += item.subtotal;
      }
    }
    return {'Platillos': pRev, 'Bebidas': bRev, 'Postres': poRev};
  }

  Map<String, int> getOrdersByStatus() {
    final Map<String, int> result = {};
    for (final order in MockDataService.orders) {
      result[order.statusLabel] = (result[order.statusLabel] ?? 0) + 1;
    }
    return result;
  }

  List<Map<String, dynamic>> getDailyRevenue() {
    final now = DateTime.now();
    final List<Map<String, dynamic>> data = [];
    for (int i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayOrders = MockDataService.orders.where((o) =>
        o.createdAt.year == date.year &&
        o.createdAt.month == date.month &&
        o.createdAt.day == date.day &&
        o.status.name == 'entregada'
      );
      final revenue = dayOrders.fold<double>(0, (sum, o) => sum + o.total);
      data.add({
        'date': date,
        'label': '${date.day}/${date.month}',
        'revenue': revenue,
        'orders': dayOrders.length,
      });
    }
    return data;
  }
}
