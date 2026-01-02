enum OrderStatus { delivering, completed, canceled }

class Order {
  final String id;
  final DateTime date;
  final double total;
  OrderStatus status;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });
}
