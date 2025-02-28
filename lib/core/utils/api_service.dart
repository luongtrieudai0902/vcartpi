import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vcartpi/data/models/product.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8017/v1/products';

  // Hàm lấy danh sách sản phẩm một lần (Future)
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Hàm tạo Stream để cập nhật dữ liệu liên tục
  Stream<List<Product>> streamProducts(
      {Duration interval = const Duration(seconds: 5)}) async* {
    while (true) {
      try {
        List<Product> products = await fetchProducts();
        yield products;
      } catch (e) {
        print("Error fetching products: $e");
      }
      await Future.delayed(
          interval); // Đợi một khoảng thời gian rồi lấy lại dữ liệu
    }
  }
}
