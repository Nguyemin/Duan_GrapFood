import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_lap_top/model/restaurant.dart'; // Đảm bảo import đúng đường dẫn đến Restaurant Model của bạn

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    // ⭐️ ĐỌC CHUỖI BIÊN LAI ĐÃ LƯU
    final receiptText = context.watch<Restaurant>().lastReceipt;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          children: [
            const Text(
              "Biên lai của bạn",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF982121),
              ),
            ),
            const SizedBox(height: 15),

            // ⭐️ HIỂN THỊ CHUỖI BIÊN LAI
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                // Dùng SelectableText để dễ dàng copy nội dung
                receiptText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily:
                      'monospace', // Dùng font monospace để định dạng dễ nhìn
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Container cho thông tin ước tính thời gian giao hàng (Nếu có)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Địa chỉ giao hàng (Bạn có thể thêm Provider để lấy)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.location_on),
                ),
                const SizedBox(width: 10),
                const Text("Địa chỉ giao hàng", style: TextStyle(fontSize: 16)),

                const Spacer(),

                // Nút liên hệ tài xế
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF982121),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.phone, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
