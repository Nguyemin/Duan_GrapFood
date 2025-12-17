import 'package:flutter/material.dart';
import 'package:shop_lap_top/pay/my_receipt.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -50,
      end: 250,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color _ = Color(0xFFFF611D); // màu chính
    const Color subColor = Color(0xFF982121); // màu phụ

    return Scaffold(
      appBar: AppBar(
        title: const Text("Đang giao hàng"),
        elevation: 0,
      ),

      // ✅ NỀN GRADIENT TOÀN TRANG
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

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Animation xe giao hàng
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_animation.value, 0),
                        child: const Icon(
                          Icons.local_shipping,
                          size: 80,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Thông báo giao hàng
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: const [
                        Text(
                          "Đơn hàng của bạn đang được giao...",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: subColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Vui lòng chờ trong giây lát",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Thanh tiến trình
                  Column(
                    children: [
                      LinearProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation(subColor),
                        backgroundColor: Colors.white.withOpacity(0.5),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Đang xử lý giao hàng...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Biên lai
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const MyReceipt(),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
