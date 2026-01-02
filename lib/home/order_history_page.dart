import 'package:flutter/material.dart';
import 'package:shop_lap_top/pay/delivery_page.dart';
import 'package:shop_lap_top/model/order.dart';
import 'package:shop_lap_top/sever/order_service.dart';

class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({super.key});

  final orders = OrderService().orders;

  Color _statusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.delivering:
        return Colors.orange;
      case OrderStatus.canceled:
        return Colors.red;
    }
  }

  String _statusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return "Đã giao";
      case OrderStatus.delivering:
        return "Đang giao";
      case OrderStatus.canceled:
        return "Đã huỷ";
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử đơn hàng"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF611D),
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                "Chưa có đơn hàng nào",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: _statusColor(order.status),
                      child: const Icon(Icons.receipt, color: Colors.white),
                    ),
                    title: Text(
                      "Mã đơn: ${order.id}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text("Ngày đặt: ${_formatDate(order.date)}"),
                        Text("Tổng tiền: ${order.total.toStringAsFixed(2)} \$"),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _statusText(order.status),
                          style: TextStyle(
                            color: _statusColor(order.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () {
                      if (order.status == OrderStatus.delivering) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DeliveryProgressPage(),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
