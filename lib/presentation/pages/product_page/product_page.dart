import 'package:flutter/material.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/core/utils/api_service.dart';
import 'package:vcartpi/data/models/product.dart';
import 'package:vcartpi/presentation/pages/product_page/components/product_container.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
    AppConfig.loadColors();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig.loadColors();
    return Scaffold(
      appBar: AppBar(title: Text("Sản phẩm")),
      body: FutureBuilder<List<Product>>(
        // Đổi kiểu dữ liệu về List<Product>
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
              return ProductContainer(
                  product: products[index],
                  numbers: 1,
                  colorInUsed: AppConfig.colorOfHomePage);
            },
          );
        },
      ),
    );
  }
}
