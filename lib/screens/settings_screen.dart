import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/admin_layout.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'es';
  int _maxTables = 15;

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      currentRoute: '/settings',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configuración',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Apariencia',
              [
                SwitchListTile(
                  title: const Text('Modo Oscuro'),
                  subtitle: const Text('Cambiar entre tema claro y oscuro'),
                  value: _darkMode,
                  onChanged: (v) => setState(() => _darkMode = v),
                  secondary: const Icon(Icons.dark_mode),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Notificaciones',
              [
                SwitchListTile(
                  title: const Text('Notificaciones'),
                  subtitle: const Text('Recibir alertas de nuevas órdenes y reservas'),
                  value: _notificationsEnabled,
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                  secondary: const Icon(Icons.notifications),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Restaurante',
              [
                ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: const Text('Nombre del Restaurante'),
                  subtitle: const Text('Restaurante SCLab'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.table_bar),
                  title: const Text('Número de Mesas'),
                  subtitle: Text('$_maxTables mesas disponibles'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showTablesDialog(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Idioma'),
                  subtitle: Text(_selectedLanguage == 'es' ? 'Español' : 'English'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Información',
              [
                const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Versión'),
                  subtitle: Text('1.0.0'),
                ),
                const ListTile(
                  leading: Icon(Icons.code),
                  title: Text('Tecnologías'),
                  subtitle: Text('Flutter Web, Provider, GoRouter, fl_chart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  void _showTablesDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Número de Mesas'),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Mesas'),
          controller: TextEditingController(text: _maxTables.toString()),
          onChanged: (v) {
            final n = int.tryParse(v);
            if (n != null) _maxTables = n;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(ctx);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
