import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_lap_top/home/home_page.dart';
import 'package:shop_lap_top/login/login_page.dart';
import 'package:shop_lap_top/setting/setting.dart';

class ProfileScreen extends StatefulWidget {
  final String accessToken;

  const ProfileScreen({super.key, required this.accessToken});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final url = Uri.parse('https://dummyjson.com/auth/me');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi tải dữ liệu: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Lỗi kết nối: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AppBar gradient
      appBar: AppBar(
        title: const Text(
          "Hồ sơ của tôi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF611D),
                Color(0xFF982121),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black26,
      ),

      drawer: MyDrawer(accessToken: widget.accessToken),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("Không tải được thông tin user"))
              : ListView(
                  padding: const EdgeInsets.only(bottom: 20),
                  children: [
                    // ✅ Header gradient
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFF611D),
                            Color(0xFF982121),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 36,
                          backgroundImage: NetworkImage(userData!['image']),
                        ),
                      ),
                      accountName: Text(
                        "${userData!['firstName']} ${userData!['lastName']}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Text(
                        userData!['email'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),

                    // ✅ Các mục thông tin
                    _buildProfileItem(
                      icon: Icons.person_outline,
                      title: "Tên đăng nhập",
                      value: userData!['username'],
                    ),

                    _buildProfileItem(
                      icon: Icons.phone,
                      title: "Số điện thoại",
                      value: userData!['phone'] ?? 'Chưa cập nhật',
                    ),

                    _buildProfileItem(
                      icon: Icons.transgender,
                      title: "Giới tính",
                      value: userData!['gender'],
                    ),

                    _buildProfileItem(
                      icon: Icons.cake,
                      title: "Ngày sinh",
                      value: userData!['birthDate'],
                    ),

                    const SizedBox(height: 10),

                    // ✅ Nút đăng xuất
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.redAccent,
                          ),
                          title: const Text(
                            "Đăng Xuất",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  // ✅ Widget con để làm ListTile đẹp hơn
  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          leading: Icon(icon, color: Color(0xFFFF611D), size: 28),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
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