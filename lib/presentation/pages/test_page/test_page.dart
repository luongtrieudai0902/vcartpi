import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/core/utils/api_service.dart';
import 'package:vcartpi/data/models/product_count_money.dart';
import 'package:vcartpi/presentation/pages/discount_page/discount_page.dart';
import 'package:vcartpi/presentation/pages/guide_page/guide_page.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Future<List<dynamic>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sản phẩm")),
      body: FutureBuilder<List<dynamic>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Không có dữ liệu"));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index]['title']),
                subtitle: Text("Giá: ${products[index]['price']}"),
              );
            },
          );
        },
      ),
    );
  }
}
