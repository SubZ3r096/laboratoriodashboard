import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'admin_sidebar.dart';
import 'admin_topbar.dart';
import '../core/theme/app_colors.dart';

class AdminLayout extends StatefulWidget {
  final Widget child;
  final String currentRoute;

  const AdminLayout({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  bool _sidebarCollapsed = false;

  void _navigate(String route) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AdminSidebar(
            currentRoute: widget.currentRoute,
            isCollapsed: _sidebarCollapsed,
            onToggle: () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
            onNavigate: _navigate,
          ),
          Expanded(
            child: Column(
              children: [
                AdminTopbar(
                  onMenuToggle: () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.contentBg,
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
