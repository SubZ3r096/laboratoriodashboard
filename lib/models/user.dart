enum UserRole { admin, mesero, cliente }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final DateTime createdAt;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    this.isActive = true,
  });

  String get roleLabel {
    switch (role) {
      case UserRole.admin:
        return 'Administrador';
      case UserRole.mesero:
        return 'Mesero';
      case UserRole.cliente:
        return 'Cliente';
    }
  }
}
