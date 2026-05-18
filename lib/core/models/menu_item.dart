enum MenuCategory { platillo, bebida, postre }

class MenuItem {
  final String id;
  final String name;
  final String description;
  final MenuCategory category;
  final double price;
  final bool isAvailable;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    this.isAvailable = true,
    this.imageUrl = '',
  });

  String get categoryLabel {
    switch (category) {
      case MenuCategory.platillo:
        return 'Platillo';
      case MenuCategory.bebida:
        return 'Bebida';
      case MenuCategory.postre:
        return 'Postre';
    }
  }
}
