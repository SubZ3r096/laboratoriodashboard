import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import '../core/controllers/users_controller.dart';
import '../core/models/user.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_layout.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersController>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersController>();

    return AdminLayout(
      currentRoute: '/users',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Text(
                  'Gestión de Usuarios',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${controller.users.length} usuarios registrados',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DataTable2(
                columnSpacing: 16,
                minWidth: 700,
                columns: const [
                  DataColumn2(label: Text('Usuario'), size: ColumnSize.L),
                  DataColumn2(label: Text('Email'), size: ColumnSize.L),
                  DataColumn2(label: Text('Rol'), size: ColumnSize.M),
                  DataColumn2(label: Text('Registro'), size: ColumnSize.M),
                  DataColumn2(label: Text('Estado'), size: ColumnSize.S),
                  DataColumn2(label: Text('Acciones'), size: ColumnSize.S),
                ],
                rows: controller.users.map((user) {
                  return DataRow2(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: _getRoleColor(user.role),
                              child: Text(
                                user.name.substring(0, 1).toUpperCase(),
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(user.name),
                          ],
                        ),
                      ),
                      DataCell(Text(user.email)),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getRoleColor(user.role).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            user.roleLabel,
                            style: TextStyle(
                              color: _getRoleColor(user.role),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(DateFormat('dd/MM/yyyy').format(user.createdAt))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: user.isActive ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            user.isActive ? 'Activo' : 'Inactivo',
                            style: TextStyle(
                              color: user.isActive ? AppColors.success : AppColors.error,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            user.isActive ? Icons.block : Icons.check_circle,
                            size: 20,
                            color: user.isActive ? AppColors.warning : AppColors.success,
                          ),
                          onPressed: () => controller.toggleUserStatus(user.id),
                          tooltip: user.isActive ? 'Desactivar' : 'Activar',
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

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return AppColors.error;
      case UserRole.mesero:
        return AppColors.primary;
      case UserRole.cliente:
        return AppColors.success;
    }
  }
}
