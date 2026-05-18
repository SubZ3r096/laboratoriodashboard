import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../services/mock_data_service.dart';

class OrdersController extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String _filter = 'all';

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String get filter => _filter;

  List<Order> get filteredOrders {
    if (_filter == 'all') return _orders;
    return _orders.where((o) => o.status.name == _filter).toList();
  }

  void loadOrders() {
    _isLoading = true;
    notifyListeners();
    _orders = List.from(MockDataService.orders);
    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index] = Order(
        id: _orders[index].id,
        customerName: _orders[index].customerName,
        customerEmail: _orders[index].customerEmail,
        type: _orders[index].type,
        status: newStatus,
        items: _orders[index].items,
        total: _orders[index].total,
        createdAt: _orders[index].createdAt,
        tableNumber: _orders[index].tableNumber,
      );
      notifyListeners();
    }
  }
}
