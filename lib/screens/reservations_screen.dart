import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import '../controllers/reservations_controller.dart';
import '../models/reservation.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_layout.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReservationsController>().loadReservations();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReservationsController>();

    return AdminLayout(
      currentRoute: '/reservations',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Text(
                  'Gestión de Reservas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DataTable2(
                columnSpacing: 16,
                minWidth: 800,
                columns: const [
                  DataColumn2(label: Text('ID'), size: ColumnSize.S),
                  DataColumn2(label: Text('Cliente'), size: ColumnSize.L),
                  DataColumn2(label: Text('Teléfono'), size: ColumnSize.M),
                  DataColumn2(label: Text('Fecha'), size: ColumnSize.M),
                  DataColumn2(label: Text('Hora'), size: ColumnSize.S),
                  DataColumn2(label: Text('Personas'), size: ColumnSize.S),
                  DataColumn2(label: Text('Mesa'), size: ColumnSize.S),
                  DataColumn2(label: Text('Estado'), size: ColumnSize.M),
                  DataColumn2(label: Text('Acciones'), size: ColumnSize.M),
                ],
                rows: controller.reservations.map((res) {
                  return DataRow2(
                    cells: [
                      DataCell(Text('#${res.id}')),
                      DataCell(Text(res.customerName)),
                      DataCell(Text(res.customerPhone)),
                      DataCell(Text(DateFormat('dd/MM/yyyy').format(res.date))),
                      DataCell(Text(res.timeFormatted)),
                      DataCell(Text('${res.numberOfGuests}')),
                      DataCell(Text(res.tableNumber)),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(res.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            res.statusLabel,
                            style: TextStyle(
                              color: _getStatusColor(res.status),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (res.status == ReservationStatus.pendiente) ...[
                              IconButton(
                                icon: const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                                onPressed: () => controller.updateReservationStatus(
                                  res.id,
                                  ReservationStatus.confirmada,
                                ),
                                tooltip: 'Confirmar',
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel, color: AppColors.error, size: 20),
                                onPressed: () => controller.updateReservationStatus(
                                  res.id,
                                  ReservationStatus.cancelada,
                                ),
                                tooltip: 'Cancelar',
                              ),
                            ],
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

  Color _getStatusColor(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pendiente:
        return AppColors.warning;
      case ReservationStatus.confirmada:
        return AppColors.primary;
      case ReservationStatus.cancelada:
        return AppColors.error;
      case ReservationStatus.completada:
        return AppColors.success;
    }
  }
}
