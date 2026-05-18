import 'package:flutter/foundation.dart';
import '../services/mock_data_service.dart';

class DashboardController extends ChangeNotifier {
  Map<String, dynamic> _stats = {};
  bool _isLoading = false;

  Map<String, dynamic> get stats => _stats;
  bool get isLoading => _isLoading;

  void loadStats() {
    _isLoading = true;
    notifyListeners();
    _stats = MockDataService.getDashboardStats();
    _isLoading = false;
    notifyListeners();
  }

  double getRevenueByCategory(String category) {
    final orders = MockDataService.orders.where((o) => o.status.name == 'entregada');
    double total = 0;
    for (final order in orders) {
      for (final item in order.items) {
        final menuItem = MockDataService.menuItems.firstWhere(
          (m) => m.id == item.menuItemId,
          orElse: () => throw Exception('Item not found'),
        );
        if (menuItem.category.name == category) {
          total += item.subtotal;
        }
      }
    }
    return total;
  }

  int getOrderCountByCategory(String category) {
    final orders = MockDataService.orders;
    int count = 0;
    for (final order in orders) {
      for (final item in order.items) {
        final menuItem = MockDataService.menuItems.firstWhere(
          (m) => m.id == item.menuItemId,
          orElse: () => throw Exception('Item not found'),
        );
        if (menuItem.category.name == category) {
          count += item.quantity;
        }
      }
    }
    return count;
  }

  List<Map<String, dynamic>> getDailyRevenue() {
    final now = DateTime.now();
    final List<Map<String, dynamic>> data = [];
    for (int i = 6; i >= 0; i--) {
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

  List<Map<String, dynamic>> getTopMenuItems() {
    final Map<String, int> itemCounts = {};
    for (final order in MockDataService.orders) {
      for (final item in order.items) {
        itemCounts[item.itemName] = (itemCounts[item.itemName] ?? 0) + item.quantity;
      }
    }
    final sorted = itemCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(5).map((e) => {'name': e.key, 'count': e.value}).toList();
  }
}
