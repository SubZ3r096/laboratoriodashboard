import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/menu_item.dart';
import '../models/order.dart';
import '../models/reservation.dart';
import '../models/notification.dart';

class MockDataService {
  static List<User> get users => [
    User(id: 'u1', name: 'Carlos Admin', email: 'admin@restaurante.com', role: UserRole.admin, createdAt: DateTime(2024, 1, 15)),
    User(id: 'u2', name: 'Maria Mesero', email: 'maria@restaurante.com', role: UserRole.mesero, createdAt: DateTime(2024, 2, 10)),
    User(id: 'u3', name: 'Juan Mesero', email: 'juan@restaurante.com', role: UserRole.mesero, createdAt: DateTime(2024, 3, 5)),
    User(id: 'u4', name: 'Ana Cliente', email: 'ana@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 4, 20)),
    User(id: 'u5', name: 'Pedro Cliente', email: 'pedro@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 5, 12)),
    User(id: 'u6', name: 'Laura Cliente', email: 'laura@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 6, 8)),
    User(id: 'u7', name: 'Diego Cliente', email: 'diego@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 7, 3)),
    User(id: 'u8', name: 'Sofia Cliente', email: 'sofia@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 8, 15)),
    User(id: 'u9', name: 'Roberto Cliente', email: 'roberto@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 9, 22)),
    User(id: 'u10', name: 'Valeria Cliente', email: 'valeria@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 10, 1)),
    User(id: 'u11', name: 'Fernando Cliente', email: 'fernando@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 10, 10)),
    User(id: 'u12', name: 'Camila Cliente', email: 'camila@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 11, 5)),
    User(id: 'u13', name: 'Andres Cliente', email: 'andres@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 11, 20)),
    User(id: 'u14', name: 'Isabella Cliente', email: 'isabella@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 12, 1)),
    User(id: 'u15', name: 'Mateo Cliente', email: 'mateo@email.com', role: UserRole.cliente, createdAt: DateTime(2024, 12, 15)),
  ];

  static List<MenuItem> get menuItems => [
    MenuItem(id: 'm1', name: 'Ensalada César', description: 'Lechuga romana, crutones, parmesano, aderezo César', category: MenuCategory.platillo, price: 8500),
    MenuItem(id: 'm2', name: 'Sopa del Día', description: 'Sopa preparada con ingredientes frescos del día', category: MenuCategory.platillo, price: 6500),
    MenuItem(id: 'm3', name: 'Filete de Res', description: 'Filete de res a la parrilla con guarnición de vegetales', category: MenuCategory.platillo, price: 18500),
    MenuItem(id: 'm4', name: 'Pasta Alfredo', description: 'Fettuccine en salsa Alfredo con pollo grillado', category: MenuCategory.platillo, price: 12000),
    MenuItem(id: 'm5', name: 'Hamburguesa Clásica', description: 'Carne de res, queso cheddar, lechuga, tomate, papas', category: MenuCategory.platillo, price: 10500),
    MenuItem(id: 'm6', name: 'Pollo al Horno', description: 'Pollo marinado al horno con arroz y ensalada', category: MenuCategory.platillo, price: 14000),
    MenuItem(id: 'm7', name: 'Tacos al Pastor', description: 'Tres tacos de pastor con piña, cilantro y cebolla', category: MenuCategory.platillo, price: 9000),
    MenuItem(id: 'm8', name: 'Risotto de Champiñones', description: 'Risotto cremoso con champiñones frescos y parmesano', category: MenuCategory.platillo, price: 13500),
    MenuItem(id: 'm9', name: 'Salmón a la Plancha', description: 'Filete de salmón con salsa de limón y hierbas', category: MenuCategory.platillo, price: 21000),
    MenuItem(id: 'm10', name: 'Pizza Margherita', description: 'Pizza artesanal con tomate, mozzarella y albahaca', category: MenuCategory.platillo, price: 11000),
    MenuItem(id: 'm11', name: 'Café Americano', description: 'Café de origen recién preparado', category: MenuCategory.bebida, price: 3000),
    MenuItem(id: 'm12', name: 'Jugo Natural', description: 'Jugo de frutas frescas del día', category: MenuCategory.bebida, price: 4500),
    MenuItem(id: 'm13', name: 'Limonada', description: 'Limonada natural con hierbabuena', category: MenuCategory.bebida, price: 4000),
    MenuItem(id: 'm14', name: 'Cerveza Artesanal', description: 'Cerveza artesanal local IPA', category: MenuCategory.bebida, price: 6500),
    MenuItem(id: 'm15', name: 'Vino Tinto', description: 'Copa de vino tinto Cabernet Sauvignon', category: MenuCategory.bebida, price: 8000),
    MenuItem(id: 'm16', name: 'Agua Mineral', description: 'Agua mineral con o sin gas', category: MenuCategory.bebida, price: 2500),
    MenuItem(id: 'm17', name: 'Smoothie de Frutas', description: 'Smoothie de mango, fresa y plátano', category: MenuCategory.bebida, price: 5500),
    MenuItem(id: 'm18', name: 'Té Helado', description: 'Té negro helado con limón y miel', category: MenuCategory.bebida, price: 3500),
    MenuItem(id: 'm19', name: 'Tiramisú', description: 'Tiramisú clásico italiano con mascarpone', category: MenuCategory.postre, price: 7000),
    MenuItem(id: 'm20', name: 'Brownie con Helado', description: 'Brownie de chocolate caliente con helado de vainilla', category: MenuCategory.postre, price: 6500),
    MenuItem(id: 'm21', name: 'Flan de Caramelo', description: 'Flan casero con salsa de caramelo', category: MenuCategory.postre, price: 5000),
    MenuItem(id: 'm22', name: 'Cheesecake de Fresa', description: 'Cheesecake cremoso con coulis de fresa', category: MenuCategory.postre, price: 7500),
    MenuItem(id: 'm23', name: 'Mousse de Chocolate', description: 'Mousse de chocolate oscuro con frutos rojos', category: MenuCategory.postre, price: 6000),
    MenuItem(id: 'm24', name: 'Helado Artesanal', description: 'Tres bolas de helado artesanal (sabores a elección)', category: MenuCategory.postre, price: 4500),
    MenuItem(id: 'm25', name: 'Crepe de Nutella', description: 'Crepe dulce relleno de Nutella con fresas', category: MenuCategory.postre, price: 5500),
  ];

  static List<Order> get orders {
    final now = DateTime.now();
    return [
      Order(id: 'o1', customerName: 'Ana Cliente', customerEmail: 'ana@email.com', type: OrderType.domicilio, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm3', itemName: 'Filete de Res', quantity: 1, unitPrice: 18500), OrderItem(menuItemId: 'm15', itemName: 'Vino Tinto', quantity: 2, unitPrice: 8000)], total: 34500, createdAt: now.subtract(const Duration(hours: 2))),
      Order(id: 'o2', customerName: 'Pedro Cliente', customerEmail: 'pedro@email.com', type: OrderType.restaurante, status: OrderStatus.enPreparacion, items: [OrderItem(menuItemId: 'm5', itemName: 'Hamburguesa Clásica', quantity: 2, unitPrice: 10500), OrderItem(menuItemId: 'm13', itemName: 'Limonada', quantity: 2, unitPrice: 4000)], total: 29000, createdAt: now.subtract(const Duration(minutes: 30)), tableNumber: '5'),
      Order(id: 'o3', customerName: 'Laura Cliente', customerEmail: 'laura@email.com', type: OrderType.domicilio, status: OrderStatus.pendiente, items: [OrderItem(menuItemId: 'm4', itemName: 'Pasta Alfredo', quantity: 1, unitPrice: 12000), OrderItem(menuItemId: 'm20', itemName: 'Brownie con Helado', quantity: 1, unitPrice: 6500)], total: 18500, createdAt: now.subtract(const Duration(minutes: 15))),
      Order(id: 'o4', customerName: 'Diego Cliente', customerEmail: 'diego@email.com', type: OrderType.restaurante, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm9', itemName: 'Salmón a la Plancha', quantity: 1, unitPrice: 21000), OrderItem(menuItemId: 'm14', itemName: 'Cerveza Artesanal', quantity: 1, unitPrice: 6500)], total: 27500, createdAt: now.subtract(const Duration(hours: 4)), tableNumber: '3'),
      Order(id: 'o5', customerName: 'Sofia Cliente', customerEmail: 'sofia@email.com', type: OrderType.domicilio, status: OrderStatus.enCamino, items: [OrderItem(menuItemId: 'm7', itemName: 'Tacos al Pastor', quantity: 2, unitPrice: 9000), OrderItem(menuItemId: 'm12', itemName: 'Jugo Natural', quantity: 2, unitPrice: 4500)], total: 27000, createdAt: now.subtract(const Duration(minutes: 45))),
      Order(id: 'o6', customerName: 'Roberto Cliente', customerEmail: 'roberto@email.com', type: OrderType.restaurante, status: OrderStatus.pendiente, items: [OrderItem(menuItemId: 'm10', itemName: 'Pizza Margherita', quantity: 1, unitPrice: 11000), OrderItem(menuItemId: 'm1', itemName: 'Ensalada César', quantity: 1, unitPrice: 8500)], total: 19500, createdAt: now.subtract(const Duration(minutes: 10)), tableNumber: '8'),
      Order(id: 'o7', customerName: 'Valeria Cliente', customerEmail: 'valeria@email.com', type: OrderType.domicilio, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm6', itemName: 'Pollo al Horno', quantity: 1, unitPrice: 14000), OrderItem(menuItemId: 'm22', itemName: 'Cheesecake de Fresa', quantity: 1, unitPrice: 7500)], total: 21500, createdAt: now.subtract(const Duration(hours: 5))),
      Order(id: 'o8', customerName: 'Fernando Cliente', customerEmail: 'fernando@email.com', type: OrderType.restaurante, status: OrderStatus.cancelada, items: [OrderItem(menuItemId: 'm8', itemName: 'Risotto de Champiñones', quantity: 1, unitPrice: 13500)], total: 13500, createdAt: now.subtract(const Duration(hours: 3)), tableNumber: '2'),
      Order(id: 'o9', customerName: 'Camila Cliente', customerEmail: 'camila@email.com', type: OrderType.domicilio, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm2', itemName: 'Sopa del Día', quantity: 1, unitPrice: 6500), OrderItem(menuItemId: 'm11', itemName: 'Café Americano', quantity: 1, unitPrice: 3000)], total: 9500, createdAt: now.subtract(const Duration(hours: 6))),
      Order(id: 'o10', customerName: 'Andres Cliente', customerEmail: 'andres@email.com', type: OrderType.restaurante, status: OrderStatus.enPreparacion, items: [OrderItem(menuItemId: 'm3', itemName: 'Filete de Res', quantity: 2, unitPrice: 18500), OrderItem(menuItemId: 'm18', itemName: 'Té Helado', quantity: 2, unitPrice: 3500)], total: 44000, createdAt: now.subtract(const Duration(minutes: 20)), tableNumber: '1'),
      Order(id: 'o11', customerName: 'Isabella Cliente', customerEmail: 'isabella@email.com', type: OrderType.domicilio, status: OrderStatus.pendiente, items: [OrderItem(menuItemId: 'm24', itemName: 'Helado Artesanal', quantity: 2, unitPrice: 4500), OrderItem(menuItemId: 'm25', itemName: 'Crepe de Nutella', quantity: 1, unitPrice: 5500)], total: 14500, createdAt: now.subtract(const Duration(minutes: 5))),
      Order(id: 'o12', customerName: 'Mateo Cliente', customerEmail: 'mateo@email.com', type: OrderType.restaurante, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm5', itemName: 'Hamburguesa Clásica', quantity: 1, unitPrice: 10500), OrderItem(menuItemId: 'm16', itemName: 'Agua Mineral', quantity: 1, unitPrice: 2500)], total: 13000, createdAt: now.subtract(const Duration(hours: 7)), tableNumber: '6'),
      Order(id: 'o13', customerName: 'Ana Cliente', customerEmail: 'ana@email.com', type: OrderType.domicilio, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm1', itemName: 'Ensalada César', quantity: 1, unitPrice: 8500), OrderItem(menuItemId: 'm17', itemName: 'Smoothie de Frutas', quantity: 1, unitPrice: 5500)], total: 14000, createdAt: now.subtract(const Duration(hours: 8))),
      Order(id: 'o14', customerName: 'Pedro Cliente', customerEmail: 'pedro@email.com', type: OrderType.restaurante, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm9', itemName: 'Salmón a la Plancha', quantity: 1, unitPrice: 21000), OrderItem(menuItemId: 'm19', itemName: 'Tiramisú', quantity: 1, unitPrice: 7000)], total: 28000, createdAt: now.subtract(const Duration(hours: 1)), tableNumber: '4'),
      Order(id: 'o15', customerName: 'Laura Cliente', customerEmail: 'laura@email.com', type: OrderType.domicilio, status: OrderStatus.enCamino, items: [OrderItem(menuItemId: 'm7', itemName: 'Tacos al Pastor', quantity: 3, unitPrice: 9000), OrderItem(menuItemId: 'm14', itemName: 'Cerveza Artesanal', quantity: 3, unitPrice: 6500)], total: 46500, createdAt: now.subtract(const Duration(minutes: 50))),
      Order(id: 'o16', customerName: 'Diego Cliente', customerEmail: 'diego@email.com', type: OrderType.restaurante, status: OrderStatus.pendiente, items: [OrderItem(menuItemId: 'm10', itemName: 'Pizza Margherita', quantity: 2, unitPrice: 11000)], total: 22000, createdAt: now.subtract(const Duration(minutes: 8)), tableNumber: '7'),
      Order(id: 'o17', customerName: 'Sofia Cliente', customerEmail: 'sofia@email.com', type: OrderType.domicilio, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm6', itemName: 'Pollo al Horno', quantity: 1, unitPrice: 14000), OrderItem(menuItemId: 'm21', itemName: 'Flan de Caramelo', quantity: 1, unitPrice: 5000)], total: 19000, createdAt: now.subtract(const Duration(hours: 9))),
      Order(id: 'o18', customerName: 'Roberto Cliente', customerEmail: 'roberto@email.com', type: OrderType.domicilio, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm4', itemName: 'Pasta Alfredo', quantity: 2, unitPrice: 12000), OrderItem(menuItemId: 'm15', itemName: 'Vino Tinto', quantity: 1, unitPrice: 8000)], total: 32000, createdAt: now.subtract(const Duration(hours: 10))),
      Order(id: 'o19', customerName: 'Valeria Cliente', customerEmail: 'valeria@email.com', type: OrderType.restaurante, status: OrderStatus.entregada, items: [OrderItem(menuItemId: 'm8', itemName: 'Risotto de Champiñones', quantity: 1, unitPrice: 13500), OrderItem(menuItemId: 'm12', itemName: 'Jugo Natural', quantity: 1, unitPrice: 4500)], total: 18000, createdAt: now.subtract(const Duration(hours: 11)), tableNumber: '9'),
      Order(id: 'o20', customerName: 'Fernando Cliente', customerEmail: 'fernando@email.com', type: OrderType.domicilio, status: OrderStatus.pendiente, items: [OrderItem(menuItemId: 'm3', itemName: 'Filete de Res', quantity: 1, unitPrice: 18500), OrderItem(menuItemId: 'm23', itemName: 'Mousse de Chocolate', quantity: 1, unitPrice: 6000)], total: 24500, createdAt: now.subtract(const Duration(minutes: 12))),
    ];
  }

  static List<Reservation> get reservations {
    final now = DateTime.now();
    return [
      Reservation(id: 'r1', customerName: 'Ana Cliente', customerEmail: 'ana@email.com', customerPhone: '8888-1111', date: now.add(const Duration(days: 1)), time: const TimeOfDay(hour: 19, minute: 0), numberOfGuests: 4, tableNumber: '1', status: ReservationStatus.confirmada),
      Reservation(id: 'r2', customerName: 'Pedro Cliente', customerEmail: 'pedro@email.com', customerPhone: '8888-2222', date: now.add(const Duration(days: 1)), time: const TimeOfDay(hour: 20, minute: 30), numberOfGuests: 2, tableNumber: '3', status: ReservationStatus.pendiente),
      Reservation(id: 'r3', customerName: 'Laura Cliente', customerEmail: 'laura@email.com', customerPhone: '8888-3333', date: now.add(const Duration(days: 2)), time: const TimeOfDay(hour: 12, minute: 0), numberOfGuests: 6, tableNumber: '5', status: ReservationStatus.confirmada),
      Reservation(id: 'r4', customerName: 'Diego Cliente', customerEmail: 'diego@email.com', customerPhone: '8888-4444', date: now.add(const Duration(days: 2)), time: const TimeOfDay(hour: 13, minute: 0), numberOfGuests: 3, tableNumber: '2', status: ReservationStatus.pendiente),
      Reservation(id: 'r5', customerName: 'Sofia Cliente', customerEmail: 'sofia@email.com', customerPhone: '8888-5555', date: now.add(const Duration(days: 3)), time: const TimeOfDay(hour: 19, minute: 30), numberOfGuests: 5, tableNumber: '7', status: ReservationStatus.confirmada),
      Reservation(id: 'r6', customerName: 'Roberto Cliente', customerEmail: 'roberto@email.com', customerPhone: '8888-6666', date: now.subtract(const Duration(days: 1)), time: const TimeOfDay(hour: 20, minute: 0), numberOfGuests: 2, tableNumber: '4', status: ReservationStatus.completada),
      Reservation(id: 'r7', customerName: 'Valeria Cliente', customerEmail: 'valeria@email.com', customerPhone: '8888-7777', date: now.subtract(const Duration(days: 2)), time: const TimeOfDay(hour: 12, minute: 30), numberOfGuests: 4, tableNumber: '6', status: ReservationStatus.completada),
      Reservation(id: 'r8', customerName: 'Fernando Cliente', customerEmail: 'fernando@email.com', customerPhone: '8888-8888', date: now.add(const Duration(days: 4)), time: const TimeOfDay(hour: 18, minute: 0), numberOfGuests: 8, tableNumber: '8', status: ReservationStatus.pendiente),
      Reservation(id: 'r9', customerName: 'Camila Cliente', customerEmail: 'camila@email.com', customerPhone: '8888-9999', date: now.subtract(const Duration(days: 3)), time: const TimeOfDay(hour: 19, minute: 0), numberOfGuests: 3, tableNumber: '9', status: ReservationStatus.cancelada),
      Reservation(id: 'r10', customerName: 'Andres Cliente', customerEmail: 'andres@email.com', customerPhone: '8888-0000', date: now.add(const Duration(days: 5)), time: const TimeOfDay(hour: 20, minute: 0), numberOfGuests: 2, tableNumber: '1', status: ReservationStatus.confirmada),
      Reservation(id: 'r11', customerName: 'Isabella Cliente', customerEmail: 'isabella@email.com', customerPhone: '8888-1234', date: now.add(const Duration(days: 1)), time: const TimeOfDay(hour: 21, minute: 0), numberOfGuests: 4, tableNumber: '10', status: ReservationStatus.pendiente),
      Reservation(id: 'r12', customerName: 'Mateo Cliente', customerEmail: 'mateo@email.com', customerPhone: '8888-5678', date: now.add(const Duration(days: 3)), time: const TimeOfDay(hour: 12, minute: 0), numberOfGuests: 6, tableNumber: '5', status: ReservationStatus.confirmada),
    ];
  }

  static List<AppNotification> get notifications {
    final now = DateTime.now();
    return [
      AppNotification(id: 'n1', title: 'Nueva orden', message: 'Orden #o3 pendiente de preparación', type: NotificationType.order, createdAt: now.subtract(const Duration(minutes: 15)), icon: Icons.shopping_bag),
      AppNotification(id: 'n2', title: 'Reserva confirmada', message: 'Ana Cliente confirma reserva para mañana', type: NotificationType.reservation, createdAt: now.subtract(const Duration(minutes: 30)), icon: Icons.event),
      AppNotification(id: 'n3', title: 'Orden entregada', message: 'Orden #o1 entregada exitosamente', type: NotificationType.order, createdAt: now.subtract(const Duration(hours: 2)), icon: Icons.check_circle),
      AppNotification(id: 'n4', title: 'Stock bajo', message: 'Ingredientes para Salmón a la Plancha por agotarse', type: NotificationType.alert, createdAt: now.subtract(const Duration(hours: 3)), icon: Icons.warning),
      AppNotification(id: 'n5', title: 'Nuevo usuario', message: 'Mateo Cliente se registró en la plataforma', type: NotificationType.info, createdAt: now.subtract(const Duration(hours: 5)), icon: Icons.person_add),
    ];
  }

  static Map<String, dynamic> getDashboardStats() {
    final now = DateTime.now();
    final todayOrders = orders.where((o) => o.createdAt.isAfter(now.subtract(const Duration(days: 1)))).toList();
    final pendingOrders = orders.where((o) => o.status == OrderStatus.pendiente).toList();
    final activeReservations = reservations.where((r) => r.status == ReservationStatus.confirmada || r.status == ReservationStatus.pendiente).toList();
    final totalRevenue = orders.where((o) => o.status == OrderStatus.entregada).fold<double>(0, (sum, o) => sum + o.total);
    final activeUsers = users.where((u) => u.isActive).length;

    return {
      'todayOrders': todayOrders.length,
      'pendingOrders': pendingOrders.length,
      'activeReservations': activeReservations.length,
      'totalRevenue': totalRevenue,
      'activeUsers': activeUsers,
      'totalMenuItems': menuItems.length,
    };
  }
}
