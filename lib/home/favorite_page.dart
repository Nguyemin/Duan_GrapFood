import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_lap_top/model/favorite_service.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteService>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yêu thích"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF611D),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "Chưa có món yêu thích ❤️",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final food = favorites[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        food.networkImage,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      food.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${food.price.toStringAsFixed(2)} \$",
                      style: const TextStyle(
                        color: Color(0xFFFF611D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<FavoriteService>()
                            .toggleFavorite(food);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
