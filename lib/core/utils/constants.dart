class AppConstants {
  static const String appName = 'Restaurante Admin';
  static const String appVersion = '1.0.0';

  static const String adminEmail = 'admin@restaurante.com';
  static const String adminPassword = 'admin123';

  static const double sidebarWidth = 260;
  static const double sidebarCollapsedWidth = 72;
  static const double topbarHeight = 64;

  static String formatCurrency(double amount) {
    return '₡${amount.toStringAsFixed(0)}';
  }
}
