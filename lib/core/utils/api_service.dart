import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vcartpi/data/models/product.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8017/v1/products';

  // Hàm lấy danh sách sản phẩm
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
