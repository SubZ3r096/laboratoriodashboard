import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class AdminSidebar extends StatelessWidget {
  final String currentRoute;
  final bool isCollapsed;
  final VoidCallback onToggle;
  final Function(String) onNavigate;

  const AdminSidebar({
    super.key,
    required this.currentRoute,
    this.isCollapsed = false,
    required this.onToggle,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 72 : 260,
      decoration: BoxDecoration(
        color: AppColors.sidebarBg,
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000),
            blurRadius: 16,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(color: Color(0xFF1E293B), height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              children: [
                _buildNavItem('/dashboard', Icons.dashboard_rounded, 'Dashboard'),
                _buildNavItem('/menu', Icons.restaurant_rounded, 'Menú'),
                _buildNavItem('/orders', Icons.shopping_bag_rounded, 'Órdenes'),
                _buildNavItem('/reservations', Icons.event_rounded, 'Reservas'),
                _buildNavItem('/users', Icons.people_rounded, 'Usuarios'),
                _buildNavItem('/reports', Icons.bar_chart_rounded, 'Reportes'),
                _buildNavItem('/settings', Icons.settings_rounded, 'Configuración'),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (!isCollapsed) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.sidebarActive.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.restaurant_menu_rounded, color: AppColors.sidebarActive, size: 22),
            ),
            const SizedBox(width: 12),
            const Text(
              'SCLab',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
          if (isCollapsed)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.sidebarActive.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.restaurant_menu_rounded, color: AppColors.sidebarActive, size: 22),
            ),
          if (!isCollapsed) const Spacer(),
          IconButton(
            icon: Icon(
              isCollapsed ? Icons.chevron_right_rounded : Icons.chevron_left_rounded,
              color: AppColors.sidebarText,
              size: 20,
            ),
            onPressed: onToggle,
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String route, IconData icon, String label) {
    final isActive = currentRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onNavigate(route),
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? AppColors.sidebarActive : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.sidebarActive.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: isActive ? AppColors.sidebarActiveText : AppColors.sidebarText,
                  size: 22,
                ),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      color: isActive ? AppColors.sidebarActiveText : AppColors.sidebarText,
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF1E293B), width: 1)),
      ),
      child: isCollapsed
          ? IconButton(
              icon: const Icon(Icons.logout_rounded, color: AppColors.sidebarText),
              onPressed: () => onNavigate('/login'),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onNavigate('/login'),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.logout_rounded, color: AppColors.sidebarText, size: 20),
                      const SizedBox(width: 10),
                      const Text(
                        'Cerrar sesión',
                        style: TextStyle(
                          color: AppColors.sidebarText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
