import 'package:flutter/material.dart';
import 'package:shop_lap_top/model/food.dart';

class DetailPage extends StatefulWidget {
  final Food food;
  final Function(Food food, int quantity, List<Addon> addons) addToCart;

  const DetailPage({super.key, required this.food, required this.addToCart});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Addon> selectedAddons = [];
  int quantity = 1;

  double getTotalPrice() {
    double addonTotal = selectedAddons.fold(
      0,
      (sum, addon) => sum + addon.price,
    );
    return (widget.food.price + addonTotal) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Scaffold(
      backgroundColor: Colors.transparent,

      // ✅ BOTTOM BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            // ✅ tăng giảm số lượng
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => quantity++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // ✅ Nút thêm vào giỏ hàng
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  widget.addToCart(widget.food, quantity, selectedAddons);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Đã thêm $quantity x ${food.name}")),
                  );

                  Navigator.pop(context);
                },
                child: Text(
                  "Thêm vào giỏ • ${getTotalPrice().toStringAsFixed(2)} \$",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // ✅ NỀN GRADIENT TOÀN MÀN HÌNH
      body: Container(
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
        child: Stack(
          children: [
            // ✅ Ảnh + overlay
            SizedBox(
              height: 330,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    food.networkImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (c, e, s) =>
                        const Icon(Icons.error, size: 80),
                  ),

                  // ✅ overlay gradient đen nhẹ
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  // ✅ nút back
                  Positioned(
                    top: 20,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  // ✅ nút yêu thích
                  Positioned(
                    top: 20,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ✅ DRAGGABLE SHEET
            DraggableScrollableSheet(
              initialChildSize: 0.58,
              minChildSize: 0.58,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(22),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFF611D), // màu chính
                        Color(0xFF982121), // màu phụ
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      // ✅ Tên món
                      Text(
                        food.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black, // ✅ đổi màu chữ cho dễ đọc
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ✅ rating + thời gian
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade300,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "4.8",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.timer, color: Colors.white70, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            "20-25 phút",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // ✅ Giá
                      Text(
                        "${food.price.toStringAsFixed(2)} \$",
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // ✅ Mô tả
                      const Text(
                        "Mô tả sản phẩm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        food.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ✅ Addons
                      if (food.availableAddons.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tùy chọn thêm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 14),

                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: food.availableAddons.map((addon) {
                                final isSelected = selectedAddons.contains(
                                  addon,
                                );

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSelected
                                          ? selectedAddons.remove(addon)
                                          : selectedAddons.add(addon);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.2),
                                    ),
                                    child: Text(
                                      "${addon.name} (+${addon.price.toStringAsFixed(2)} \$)",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 24),

                            // ✅ Tổng tiền
                            Text(
                              "Tổng cộng: ${getTotalPrice().toStringAsFixed(2)} \$",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
