import 'package:dio/dio.dart';
import 'package:shop_lap_top/model/food.dart';

class API {
  Future<List<Food>> getAllProducts() async {
    try {
      var dio = Dio();
      var url = 'https://693a740a9b80ba7262c9fb15.mockapi.io/Food';

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((json) => Food.fromJson(json)).toList();
      } else {
        print("Lỗi server: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Lỗi API: $e");
      return [];
    }
  }
}

final api = API();
