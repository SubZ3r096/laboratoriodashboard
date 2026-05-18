import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_table_2/data_table_2.dart';
import '../controllers/orders_controller.dart';
import '../models/order.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_layout.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersController>().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrdersController>();

    return AdminLayout(
      currentRoute: '/orders',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Text(
                  'Gestión de Órdenes',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: 8,
                  children: [
                    _FilterChip('all', 'Todas', controller),
                    _FilterChip('pendiente', 'Pendientes', controller),
                    _FilterChip('enPreparacion', 'En preparación', controller),
                    _FilterChip('enCamino', 'En camino', controller),
                    _FilterChip('entregada', 'Entregadas', controller),
                    _FilterChip('cancelada', 'Canceladas', controller),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DataTable2(
                columnSpacing: 16,
                minWidth: 900,
                columns: const [
                  DataColumn2(label: Text('ID'), size: ColumnSize.S),
                  DataColumn2(label: Text('Cliente'), size: ColumnSize.L),
                  DataColumn2(label: Text('Tipo'), size: ColumnSize.S),
                  DataColumn2(label: Text('Items'), size: ColumnSize.L),
                  DataColumn2(label: Text('Total'), size: ColumnSize.M),
                  DataColumn2(label: Text('Estado'), size: ColumnSize.M),
                  DataColumn2(label: Text('Mesa'), size: ColumnSize.S),
                  DataColumn2(label: Text('Acciones'), size: ColumnSize.M),
                ],
                rows: controller.filteredOrders.map((order) {
                  return DataRow2(
                    cells: [
                      DataCell(Text('#${order.id}')),
                      DataCell(Text(order.customerName)),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: order.type == OrderType.domicilio
                                ? AppColors.info.withOpacity(0.1)
                                : AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            order.typeLabel,
                            style: TextStyle(
                              color: order.type == OrderType.domicilio ? AppColors.info : AppColors.success,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          order.items.map((i) => '${i.itemName} x${i.quantity}').join(', '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataCell(Text('₡${order.total.toStringAsFixed(0)}')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order.statusLabel,
                            style: TextStyle(
                              color: _getStatusColor(order.status),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(order.tableNumber ?? '-')),
                      DataCell(
                        PopupMenuButton<OrderStatus>(
                          icon: const Icon(Icons.more_vert, size: 20),
                          onSelected: (status) => controller.updateOrderStatus(order.id, status),
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: OrderStatus.pendiente, child: Text('Pendiente')),
                            const PopupMenuItem(value: OrderStatus.enPreparacion, child: Text('En preparación')),
                            const PopupMenuItem(value: OrderStatus.enCamino, child: Text('En camino')),
                            const PopupMenuItem(value: OrderStatus.entregada, child: Text('Entregada')),
                            const PopupMenuItem(value: OrderStatus.cancelada, child: Text('Cancelada')),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pendiente:
        return AppColors.warning;
      case OrderStatus.enPreparacion:
        return AppColors.primary;
      case OrderStatus.enCamino:
        return AppColors.info;
      case OrderStatus.entregada:
        return AppColors.success;
      case OrderStatus.cancelada:
        return AppColors.error;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String value;
  final String label;
  final OrdersController controller;

  const _FilterChip(this.value, this.label, this.controller);

  @override
  Widget build(BuildContext context) {
    final isActive = controller.filter == value;
    return FilterChip(
      label: Text(label),
      selected: isActive,
      onSelected: (_) => controller.setFilter(value),
      selectedColor: AppColors.primary.withOpacity(0.2),
    );
  }
}
