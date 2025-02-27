import 'package:flutter/material.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/data/models/product_count_money.dart';

class BillContainer extends StatefulWidget {
  const BillContainer({super.key});

  @override
  State<BillContainer> createState() => _BillContainerState();
}

class _BillContainerState extends State<BillContainer> {
  List<ProductCountMoneyModel> listProducts = [];
  Map<String, ProductCountMoneyModel> groupedProducts = {};

  void _loadProducts() {
    listProducts = ProductCountMoneyModel.loadListProducts();
    // Nhóm sản phẩm trùng nhau theo name
    groupedProducts.clear();
    for (var product in listProducts) {
      if (groupedProducts.containsKey(product.name)) {
        groupedProducts[product.name]!.numbers += 1;
        groupedProducts[product.name]!.value += product.value;
      } else {
        groupedProducts[product.name] = ProductCountMoneyModel(
          name: product.name,
          numbers: 1,
          value: product.value,
          imgUrl: product.imgUrl,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
    AppConfig.loadColors();
    AppConfig.loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
    _loadProducts();
    AppConfig.loadColors();
    AppConfig.loadLanguage();
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      width: 350,
      height: 450,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bill_bg.png")),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            "${AppConfig.textLanguage["total_cost"]!["tongthanhtoan"]}",
            style: TextStyle(
              color: AppConfig.colorOfHomePage["text"],
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          // Đây là hiển thị tên các sản phẩm
          Container(
            padding: const EdgeInsets.only(left: 10, top: 15),
            width: 278,
            height: 314,
            // Đặt SingleChildScrollView bên trong Container
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groupedProducts.entries.map((entry) {
                  String nameProduct = entry.key;
                  ProductCountMoneyModel product = entry.value;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$nameProduct \t\t x${product.numbers}",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppConfig.colorOfHomePage["text"]),
                      ),
                      Text(
                        "${product.value}.000đ",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppConfig.colorOfHomePage["text"]),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Đây là hiển thị tổng tiền
          //SizedBox(height: 10),
          Text(
            "${AppConfig.textLanguage["total_cost"]!["thanhtien"]} : ${listProducts.map((e) => e.value).reduce((a, b) => a + b)}.000 VND",
            style: TextStyle(
                fontSize: 20,
                color: AppConfig.colorOfHomePage["text"],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Đây là nút để xác nhận thanh toán
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: 238,
              height: 39,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 200, 248, 171),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text("Xác nhận thanh toán",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
