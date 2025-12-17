import 'package:flutter/material.dart';
import 'package:shop_lap_top/home/home_page.dart';
import 'package:shop_lap_top/login/login_page.dart';
import 'package:shop_lap_top/login/profile_screen.dart';
import 'package:shop_lap_top/setting/setting.dart';

class AboutPage extends StatelessWidget {
  final String accessToken;

  const AboutPage({super.key, required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(accessToken: accessToken),

      // ✅ AppBar gradient
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Giới thiệu ứng dụng",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF611D), Color(0xFF982121)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),

      // ✅ Nền gradient toàn trang
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF611D), Color(0xFF982121)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ✅ Logo / Header
            Center(
              child: Column(
                children: const [
                  Icon(Icons.fastfood, size: 80, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "MN Food App",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ✅ Giới thiệu app
            _buildSection(
              title: "Giới thiệu",
              content:
                  "MN Food là ứng dụng đặt đồ ăn nhanh chóng, tiện lợi và hiện đại. "
                  "Chúng tôi mang đến trải nghiệm đặt món mượt mà, giao hàng nhanh, "
                  "và danh sách món ăn phong phú từ nhiều cửa hàng uy tín.",
            ),

            const SizedBox(height: 20),

            // ✅ Mục đích của app
            _buildSection(
              title: "Mục đích của ứng dụng",
              content:
                  "• Giúp người dùng tìm kiếm và đặt món ăn dễ dàng.\n"
                  "• Cung cấp thông tin món ăn rõ ràng, giá cả minh bạch.\n"
                  "• Hỗ trợ thanh toán nhanh chóng và an toàn.\n"
                  "• Mang đến trải nghiệm đồng bộ, đẹp mắt và tiện lợi.",
            ),

            const SizedBox(height: 20),

            // ✅ Món ăn nổi bật
            const Text(
              "Món ăn nổi bật",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            _buildFoodCard(
              image:
                  "https://images.unsplash.com/photo-1550547660-d9450f859349",
              name: "Pizza Hải Sản",
              desc: "Đậm vị, thơm ngon, topping đầy đặn.",
            ),

            _buildFoodCard(
              image:
                  "https://images.unsplash.com/photo-1550547660-d9450f859349",
              name: "Hamburger Bò",
              desc: "Thịt bò nướng thơm, phô mai tan chảy.",
            ),

            _buildFoodCard(
              image:
                  "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
              name: "Mì Ý Sốt Kem",
              desc: "Mềm mịn, béo ngậy, chuẩn vị Ý.",
            ),

            const SizedBox(height: 30),

            // ✅ Footer
            const Center(
              child: Text(
                "© 2025 MN Food – All rights reserved",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Widget section giới thiệu
  Widget _buildSection({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Card món ăn đẹp
  Widget _buildFoodCard({
    required String image,
    required String name,
    required String desc,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(16),
            ),
            child: Image.network(
              image,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Drawer dùng chung
class MyDrawer extends StatelessWidget {
  final String accessToken;

  const MyDrawer({super.key, required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ✅ Header gradient
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF611D),
                  Color(0xFF982121),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text("Xin chào!"),
            accountEmail: Text("Chúc bạn một ngày tốt lành"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Color(0xFFFF611D)),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFFFF611D)),
            title: const Text("Hồ sơ cá nhân"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(accessToken: accessToken),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFFFF611D)),
            title: const Text("Trang chủ"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(accessToken: accessToken),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFFFF611D)),
            title: const Text("Cài đặt"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFFFF611D)),
            title: const Text("Giới thiệu"),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Đăng xuất", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
