import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../controllers/reports_controller.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_layout.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/pie_chart_widget.dart';
import '../widgets/line_chart_widget.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReportsController>().loadReports();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReportsController>();

    return AdminLayout(
      currentRoute: '/reports',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Reportes y Estadísticas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _generatePdf(context),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Exportar PDF'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BarChartWidget(
                    data: controller.getOrdersByCategory(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PieChartWidget(
                    data: controller.getRevenueByCategory(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const LineChartWidget(
              data: [],
            ),
            const SizedBox(height: 24),
            _buildStatusReport(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusReport(ReportsController controller) {
    final statusData = controller.getOrdersByStatus();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Órdenes por Estado',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ...statusData.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getStatusColor(entry.key),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(entry.key, style: const TextStyle(fontSize: 14)),
                    const Spacer(),
                    Text(
                      '${entry.value}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pendiente':
        return AppColors.warning;
      case 'En preparación':
        return AppColors.primary;
      case 'En camino':
        return AppColors.info;
      case 'Entregada':
        return AppColors.success;
      case 'Cancelada':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Future<void> _generatePdf(BuildContext context) async {
    final controller = context.read<ReportsController>();
    final revenue = controller.getRevenueByCategory();
    final ordersByCategory = controller.getOrdersByCategory();
    final statusData = controller.getOrdersByStatus();
    final totalRevenue = revenue.values.fold<double>(0, (sum, v) => sum + v);
    final totalOrders = statusData.values.fold(0, (sum, v) => sum + v);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Reporte de Restaurante',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Generado: ${DateTime.now().toString().split('.')[0]}',
              style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
            ),
            pw.SizedBox(height: 24),
            pw.Text('Resumen General', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Text('Total de Ingresos: ₡${totalRevenue.toStringAsFixed(0)}'),
            pw.Text('Total de Órdenes: $totalOrders'),
            pw.SizedBox(height: 24),
            pw.Text('Ingresos por Categoría', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...revenue.entries.map((e) => pw.Text('${e.key}: ₡${e.value.toStringAsFixed(0)}')),
            pw.SizedBox(height: 24),
            pw.Text('Órdenes por Categoría', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...ordersByCategory.entries.map((e) => pw.Text('${e.key}: ${e.value}')),
            pw.SizedBox(height: 24),
            pw.Text('Órdenes por Estado', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...statusData.entries.map((e) => pw.Text('${e.key}: ${e.value}')),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'reporte_restaurante.pdf',
    );
  }
}
