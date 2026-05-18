enum OrderStatus { pendiente, enPreparacion, enCamino, entregada, cancelada }
enum OrderType { domicilio, restaurante }

class Order {
  final String id;
  final String customerName;
  final String customerEmail;
  final OrderType type;
  final OrderStatus status;
  final List<OrderItem> items;
  final double total;
  final DateTime createdAt;
  final String? tableNumber;

  Order({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.type,
    required this.status,
    required this.items,
    required this.total,
    required this.createdAt,
    this.tableNumber,
  });

  String get statusLabel {
    switch (status) {
      case OrderStatus.pendiente:
        return 'Pendiente';
      case OrderStatus.enPreparacion:
        return 'En preparación';
      case OrderStatus.enCamino:
        return 'En camino';
      case OrderStatus.entregada:
        return 'Entregada';
      case OrderStatus.cancelada:
        return 'Cancelada';
    }
  }

  String get typeLabel {
    switch (type) {
      case OrderType.domicilio:
        return 'Domicilio';
      case OrderType.restaurante:
        return 'Restaurante';
    }
  }
}

class OrderItem {
  final String menuItemId;
  final String itemName;
  final int quantity;
  final double unitPrice;

  OrderItem({
    required this.menuItemId,
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
  });

  double get subtotal => quantity * unitPrice;
}
