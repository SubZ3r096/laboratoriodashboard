import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/dashboard_controller.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_layout.dart';
import '../widgets/stat_card.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/pie_chart_widget.dart';
import '../widgets/line_chart_widget.dart';
import '../services/mock_data_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardController>().loadStats();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardController>();
    final stats = controller.stats;

    return AdminLayout(
      currentRoute: '/dashboard',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 900;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildStatCards(stats),
                const SizedBox(height: 24),
                _buildChartsRow(isNarrow),
                const SizedBox(height: 24),
                _buildLineChart(),
                const SizedBox(height: 24),
                _buildRecentOrders(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 4,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Resumen General',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildStatCards(Map<String, dynamic> stats) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount;
        if (width >= 1200) {
          crossAxisCount = 4;
        } else if (width >= 800) {
          crossAxisCount = 3;
        } else if (width >= 500) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: _calculateAspectRatio(crossAxisCount),
          children: [
            StatCard(
              title: 'Órdenes Hoy',
              value: '${stats['todayOrders'] ?? 0}',
              icon: Icons.shopping_bag_rounded,
              iconColor: AppColors.primary,
              bgColor: AppColors.primaryBg,
            ),
            StatCard(
              title: 'Ingresos del Mes',
              value: '₡${(stats['totalRevenue'] ?? 0).toStringAsFixed(0)}',
              icon: Icons.attach_money_rounded,
              iconColor: AppColors.success,
              bgColor: AppColors.successBg,
              subtitle: '+12%',
            ),
            StatCard(
              title: 'Reservas Activas',
              value: '${stats['activeReservations'] ?? 0}',
              icon: Icons.event_rounded,
              iconColor: AppColors.warning,
              bgColor: AppColors.warningBg,
            ),
            StatCard(
              title: 'Usuarios Activos',
              value: '${stats['activeUsers'] ?? 0}',
              icon: Icons.people_rounded,
              iconColor: AppColors.info,
              bgColor: AppColors.infoBg,
            ),
          ],
        );
      },
    );
  }

  double _calculateAspectRatio(int columns) {
    switch (columns) {
      case 1:
        return 3.0;
      case 2:
        return 2.2;
      case 3:
        return 1.8;
      default:
        return 1.6;
    }
  }

  Widget _buildChartsRow(bool isNarrow) {
    if (isNarrow) {
      return Column(
        children: [
          _buildBarChart(),
          const SizedBox(height: 16),
          _buildPieChart(),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildBarChart(),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: _buildPieChart(),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    final controller = context.watch<DashboardController>();
    return BarChartWidget(
      data: controller.getOrdersByCategoryData(),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildPieChart() {
    final controller = context.watch<DashboardController>();
    return PieChartWidget(
      data: controller.getRevenueByCategoryData(),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildLineChart() {
    final controller = context.watch<DashboardController>();
    return LineChartWidget(
      data: controller.getDailyRevenue(),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildRecentOrders() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Órdenes Recientes',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _OrdersTable(),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms);
  }
}

class _OrdersTable extends StatelessWidget {
  const _OrdersTable();

  @override
  Widget build(BuildContext context) {
    final orders = context.read<DashboardController>().getRecentOrders();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.contentBg),
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Cliente')),
          DataColumn(label: Text('Tipo')),
          DataColumn(label: Text('Total')),
          DataColumn(label: Text('Estado')),
        ],
        rows: orders.map((order) {
          final Color statusColor;
          switch (order['status']) {
            case 'entregada':
              statusColor = AppColors.success;
              break;
            case 'pendiente':
              statusColor = AppColors.warning;
              break;
            case 'enPreparacion':
              statusColor = AppColors.primary;
              break;
            case 'enCamino':
              statusColor = AppColors.info;
              break;
            default:
              statusColor = AppColors.error;
          }

          return DataRow(cells: [
            DataCell(Text('#${order['id']}', style: const TextStyle(fontWeight: FontWeight.w600))),
            DataCell(Text(order['customer'])),
            DataCell(Text(order['type'])),
            DataCell(Text('₡${order['total'].toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600))),
            DataCell(
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order['statusLabel'],
                  style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }
}

extension on DashboardController {
  Map<String, int> getOrdersByCategoryData() {
    final platillos = getOrderCountByCategory('platillo');
    final bebidas = getOrderCountByCategory('bebida');
    final postres = getOrderCountByCategory('postre');
    return {'Platillos': platillos, 'Bebidas': bebidas, 'Postres': postres};
  }

  Map<String, double> getRevenueByCategoryData() {
    final platillos = getRevenueByCategory('platillo');
    final bebidas = getRevenueByCategory('bebida');
    final postres = getRevenueByCategory('postre');
    return {'Platillos': platillos, 'Bebidas': bebidas, 'Postres': postres};
  }

  List<Map<String, dynamic>> getRecentOrders() {
    final orders = MockDataService.orders
        .where((o) => o.status.name != 'cancelada')
        .take(5)
        .map((o) => {
              'id': o.id,
              'customer': o.customerName,
              'type': o.typeLabel,
              'total': o.total,
              'status': o.status.name,
              'statusLabel': o.statusLabel,
            })
        .toList();
    return orders;
  }
}
