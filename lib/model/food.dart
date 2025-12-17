
class Food {
  String name;
  String description;
  String networkImage;
  double price;
  FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.networkImage,
    required this.price,
    required this.category,
    required this.availableAddons,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      networkImage: json['networkImage'] ?? '',
      price: _parseDouble(json['price']),
      category: _parseCategory(json['category']),
      availableAddons: json['availableAddons'] is List
          ? (json['availableAddons'] as List)
              .map((addonJson) => Addon.fromJson(addonJson))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'networkImage': networkImage,
      'price': price,
      'category': category.name,
      'availableAddons': availableAddons.map((e) => e.toJson()).toList(),
    };
  }

  static double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static FoodCategory _parseCategory(dynamic value) {
    if (value is String) {
      return FoodCategory.values.firstWhere(
        (e) => e.name == value,
        orElse: () => FoodCategory.burgers,
      );
    }
    return FoodCategory.burgers;
  }
}

enum FoodCategory { burgers, salads, sides, desserts, drink }

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      name: json['name'] ?? '',
      price: Food._parseDouble(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
