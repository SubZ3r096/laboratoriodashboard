import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_table_2/data_table_2.dart';
import '../controllers/menu_admin_controller.dart';
import '../models/menu_item.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_layout.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<MenuAdminController>().loadMenu();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MenuAdminController>();

    return AdminLayout(
      currentRoute: '/menu',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Text(
                  'Gestión de Menú',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _showAddDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar Item'),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: '🍽️ Platillos'),
              Tab(text: '🥤 Bebidas'),
              Tab(text: '🍰 Postres'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMenuTable(controller, MenuCategory.platillo),
                _buildMenuTable(controller, MenuCategory.bebida),
                _buildMenuTable(controller, MenuCategory.postre),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTable(MenuAdminController controller, MenuCategory category) {
    final items = controller.getByCategory(category);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: DataTable2(
        columnSpacing: 20,
        minWidth: 600,
        columns: const [
          DataColumn2(label: Text('Nombre'), size: ColumnSize.L),
          DataColumn2(label: Text('Descripción'), size: ColumnSize.L),
          DataColumn2(label: Text('Precio'), size: ColumnSize.M),
          DataColumn2(label: Text('Estado'), size: ColumnSize.S),
          DataColumn2(label: Text('Acciones'), size: ColumnSize.S),
        ],
        rows: items.map((item) {
          return DataRow2(
            cells: [
              DataCell(Text(item.name)),
              DataCell(Text(item.description, maxLines: 1, overflow: TextOverflow.ellipsis)),
              DataCell(Text('₡${item.price.toStringAsFixed(0)}')),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: item.isAvailable ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.isAvailable ? 'Disponible' : 'No disponible',
                    style: TextStyle(
                      color: item.isAvailable ? AppColors.success : AppColors.error,
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
                    IconButton(
                      icon: Icon(
                        item.isAvailable ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: () => controller.toggleAvailability(item.id),
                      tooltip: item.isAvailable ? 'Desactivar' : 'Activar',
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _showEditDialog(context, item),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20, color: AppColors.error),
                      onPressed: () => _confirmDelete(context, item),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const _MenuItemDialog(),
    );
  }

  void _showEditDialog(BuildContext context, MenuItem item) {
    showDialog(
      context: context,
      builder: (ctx) => _MenuItemDialog(item: item),
    );
  }

  void _confirmDelete(BuildContext context, MenuItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Item'),
        content: Text('¿Está seguro de eliminar "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MenuAdminController>().deleteItem(item.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item eliminado')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _MenuItemDialog extends StatefulWidget {
  final MenuItem? item;

  const _MenuItemDialog({this.item});

  @override
  State<_MenuItemDialog> createState() => _MenuItemDialogState();
}

class _MenuItemDialogState extends State<_MenuItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late MenuCategory _category;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descController = TextEditingController(text: widget.item?.description ?? '');
    _priceController = TextEditingController(text: widget.item?.price.toString() ?? '');
    _category = widget.item?.category ?? MenuCategory.platillo;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Agregar Item' : 'Editar Item'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 2,
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<MenuCategory>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: MenuCategory.values.map((c) {
                  return DropdownMenuItem(value: c, child: Text(c.name));
                }).toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final price = double.tryParse(_priceController.text) ?? 0;
              final item = MenuItem(
                id: widget.item?.id ?? 'm${DateTime.now().millisecondsSinceEpoch}',
                name: _nameController.text,
                description: _descController.text,
                category: _category,
                price: price,
                isAvailable: widget.item?.isAvailable ?? true,
              );
              if (widget.item == null) {
                context.read<MenuAdminController>().addItem(item);
              } else {
                context.read<MenuAdminController>().updateItem(item);
              }
              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(context);
              messenger.showSnackBar(
                SnackBar(content: Text(widget.item == null ? 'Item agregado' : 'Item actualizado')),
              );
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
