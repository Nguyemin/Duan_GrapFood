import 'package:flutter/material.dart';
import 'package:shop_lap_top/home/about_page.dart';
import 'package:shop_lap_top/home/cart_page.dart';
import 'package:shop_lap_top/login/login_page.dart';
import 'package:shop_lap_top/login/profile_screen.dart';
import 'package:shop_lap_top/model/food.dart';
import 'package:shop_lap_top/setting/setting.dart';
import 'package:shop_lap_top/sever/api_food.dart';
import 'package:shop_lap_top/home/detail_page.dart';

class HomePage extends StatefulWidget {
  final String accessToken;

  const HomePage({super.key, required this.accessToken});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Food>> futureFoods;
  List<CartItem> cartItems = [];

  void addToCart(Food food, int quantity, List<Addon> addons) {
    setState(() {
      cartItems.add(CartItem(food: food, quantity: quantity, addons: addons));
    });
  }

  String selectedCategory = "all";
  String searchText = "";

  @override
  void initState() {
    super.initState();
    futureFoods = api.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(accessToken: widget.accessToken),

      backgroundColor: Colors.transparent,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true, // ✅ căn giữa chữ
        foregroundColor: Colors.white, // ✅ chữ + icon màu trắng nổi bật
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF611D), // màu chính
                Color(0xFF982121), // màu phụ
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        title: const Text(
          "MN Food",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white, // ✅ chữ trắng nổi bật
          ),
        ),

        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(cartItems: cartItems),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),

              if (cartItems.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade700, // ✅ badge vàng nổi bật
                      borderRadius: BorderRadius.circular(20),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // màu chính
              Color(0xFFFF611D), // màu phụ
              Color(0xFF982121),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<List<Food>>(
            future: futureFoods,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Không có sản phẩm"));
              }

              final foods = snapshot.data!;

              final filteredFoods = foods.where((food) {
                final matchCategory =
                    selectedCategory == "all" ||
                    food.category.name == selectedCategory;

                final matchSearch = food.name.toLowerCase().contains(
                  searchText.toLowerCase(),
                );

                return matchCategory && matchSearch;
              }).toList();

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ✅ Địa chỉ giao hàng
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red.shade600),
                        const SizedBox(width: 8),
                        Text(
                          "Giao đến: 2/91 kiệt 131 Trần Phú - TP Huế",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ✅ Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => searchText = value),
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm món ăn...",
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey.shade600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ Category icon
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        categoryIcon("all", Icons.apps, "Tất cả"),
                        categoryIcon("burgers", Icons.lunch_dining, "Burger"),
                        categoryIcon("salads", Icons.eco, "Salad"),
                        categoryIcon("sides", Icons.fastfood, "Món phụ"),
                        categoryIcon("desserts", Icons.cake, "Tráng miệng"),
                        categoryIcon("drink", Icons.local_drink, "Đồ uống"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ Grid sản phẩm đẹp
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredFoods.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                    itemBuilder: (context, index) {
                      final food = filteredFoods[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(food: food, addToCart: addToCart),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✅ Ảnh + Badge giảm giá
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1.1,
                                      child: Image.network(
                                        food.networkImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // ✅ Badge giảm giá
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        "-20%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // ✅ Tên món
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  food.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // ✅ Giá + Rating
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Giá
                                    Text(
                                      "${food.price.toStringAsFixed(2)} \$",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade600,
                                      ),
                                    ),

                                    // Rating
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber.shade600,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ✅ Danh mục dạng icon giống GrabFood
  Widget categoryIcon(String value, IconData icon, String label) {
    final bool isSelected = selectedCategory == value;

    return GestureDetector(
      onTap: () {
        setState(() => selectedCategory = value);
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: isSelected ? Colors.teal : Colors.grey.shade300,
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
//✅ Drawer dùng chung
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
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage(accessToken: '',)),
              );
            },
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
