import 'package:flutter/material.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/data/models/product.dart';

class BillContainer extends StatefulWidget {
  final Stream<List<Product>> Function() streamProducts; // Hàm trả về Stream

  const BillContainer({super.key, required this.streamProducts});

  @override
  State<BillContainer> createState() => _BillContainerState();
}

class _BillContainerState extends State<BillContainer> {
  late Stream<List<Product>> productStream;

  @override
  void initState() {
    super.initState();
    productStream = widget.streamProducts(); // Gọi stream
    AppConfig.loadColors();
    AppConfig.loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
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
          // Danh sách sản phẩm
          Container(
            padding: const EdgeInsets.only(left: 10, top: 15),
            width: 278,
            height: 314,
            child: StreamBuilder<List<Product>>(
              stream: productStream, // Dữ liệu đến liên tục
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi tải dữ liệu"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Không có sản phẩm nào"));
                }

                List<Product> products = snapshot.data!;
                int totalPrice = products.fold(
                    0, (sum, item) => sum + item.price * item.quantity);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: products.map((product) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${product.description} \t\t x${product.quantity}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppConfig.colorOfHomePage["text"],
                                ),
                              ),
                              Text(
                                "${product.price}đ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppConfig.colorOfHomePage["text"],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${AppConfig.textLanguage["total_cost"]!["thanhtien"]} : $totalPrice VND",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppConfig.colorOfHomePage["text"],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10),
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
              child: Text(
                "Xác nhận thanh toán",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
