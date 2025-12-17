import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addon {
  final String name;
  final double price;

  Addon({required this.name, required this.price});
}

class Food {
  final String name;
  final double price;

  Food({required this.name, required this.price});

  String? get networkImage => null;
}

class CartItem {
  final Food food;
  int quantity;
  List<Addon> selectedAddons;

  CartItem({
    required this.food,
    this.quantity = 1,
    this.selectedAddons = const [],
  });
}

class Restaurant extends ChangeNotifier {
  final List<CartItem> _cart = [];

  String lastReceipt = "";

  // Expose cart if needed
  List<CartItem> get cart => List.unmodifiable(_cart);

  // Add item to cart
  void addToCart(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Count total items
  int getTotalItemCount() {
    int total = 0;
    for (var item in _cart) {
      total += item.quantity;
    }
    return total;
  }

  // Calculate total price
  double getTotalPrice() {
    double total = 0;
    for (var item in _cart) {
      total += item.food.price * item.quantity;

      for (var addon in item.selectedAddons) {
        total += addon.price * item.quantity;
      }
    }
    return total;
  }

  // Generate receipt text
  String displayCartReceipt() {
    final receipt = StringBuffer();

    receipt.writeln("Đây là biên lai của bạn.");
    receipt.writeln();

    String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------------");

    for (final cartItem in _cart) {
      receipt.writeln(
        "${cartItem.quantity}x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}",
      );

      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln(
          "   Tiện ích bổ sung: ${_formatAddons(cartItem.selectedAddons)}",
        );
      }

      receipt.writeln();
    }

    receipt.writeln("-----------------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  // Save last receipt at payment time
  void saveReceipt() {
    lastReceipt = displayCartReceipt();
    notifyListeners();
  }

  // Format price
  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  // Format addons
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
