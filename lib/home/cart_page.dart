import 'package:flutter/material.dart';
import 'package:shop_lap_top/pay/payment_page.dart';
import 'package:shop_lap_top/model/food.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class CartItem {
  Food food;
  int quantity;
  List<Addon> addons;

  CartItem({required this.food, this.quantity = 1, this.addons = const []});
}

class _CartPageState extends State<CartPage> {
  double getTotalPrice() {
    double total = 0;

    for (var item in widget.cartItems) {
      double addonPrice = item.addons.fold(
        0,
        (sum, addon) => sum + addon.price,
      );
      total += (item.food.price + addonPrice) * item.quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ✅ Nền gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF611D), // màu chính
              Color(0xFF982121), // màu phụ
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            // ✅ AppBar custom + nút back
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 20,
                    left: 16,
                    right: 16,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF611D), Color(0xFF982121)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Giỏ hàng",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // ✅ Nút back
                Positioned(
                  left: 10,
                  top: 50,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),

            // ✅ Nội dung giỏ hàng
            Expanded(
              child: widget.cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        "Giỏ hàng trống",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✅ Ảnh sản phẩm
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  item.food.networkImage,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 14),

                              // ✅ Thông tin sản phẩm
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.food.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    if (item.addons.isNotEmpty)
                                      Text(
                                        "Thêm: ${item.addons.map((e) => e.name).join(", ")}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),

                                    const SizedBox(height: 10),

                                    Text(
                                      "${item.food.price.toStringAsFixed(2)} \$",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFFFF611D), // ✅ màu chính
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ✅ Nút tăng giảm số lượng
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() => item.quantity++);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFFF611D), // ✅ màu chính
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (item.quantity > 1) {
                                          item.quantity--;
                                        } else {
                                          widget.cartItems.removeAt(index);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF982121), // ✅ màu phụ
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // ✅ Thanh tổng tiền + nút thanh toán
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ Tổng tiền
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tổng cộng",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${getTotalPrice().toStringAsFixed(2)} \$",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF611D), // ✅ màu chính
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ✅ Nút thanh toán gradient
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF611D), Color(0xFF982121)],
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PaymentPage(totalPrice: getTotalPrice()),
                            ),
                          );
                        },
                        child: const Text(
                          "Thanh toán",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
