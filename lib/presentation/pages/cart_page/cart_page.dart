import 'package:flutter/material.dart';
import 'package:vcartpi/core/utils/api_service.dart';
import 'package:vcartpi/core/utils/format_str.dart';
import 'package:vcartpi/data/models/product.dart';
import 'package:vcartpi/presentation/pages/cart_page/components/product_card.dart';
import 'package:vcartpi/presentation/pages/plu_page/plu_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Stream<List<Product>> _streamProducts() async* {
    while (true) {
      List<Product> products = await ApiService().fetchProducts();
      yield products;
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 229, 229),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Buttons Action
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Question action
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 3.0,
                                spreadRadius: 0.8,
                                offset: Offset(
                                  1.0,
                                  2.0,
                                ),
                                color: Colors.black)
                          ],
                          color: const Color.fromARGB(255, 66, 66, 66),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.question_mark,
                          color: Colors.white,
                        )),
                  ),
                  // User Profile action
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 3.0,
                                spreadRadius: 0.8,
                                offset: Offset(
                                  1.0,
                                  2.0,
                                ),
                                color: Colors.black)
                          ],
                          color: const Color.fromARGB(255, 66, 66, 66),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                  ),
                  // Notification action
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 3.0,
                                spreadRadius: 0.8,
                                offset: Offset(
                                  1.0,
                                  2.0,
                                ),
                                color: Colors.black)
                          ],
                          color: const Color.fromARGB(255, 66, 66, 66),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            // Products view
            Stack(
              children: [
                // Nội dung chính
                Container(
                    width: 960,
                    height: 325,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 7.0,
                              spreadRadius: 0.2,
                              offset: Offset(
                                1.0,
                                2.0,
                              ),
                              color: Colors.black)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: StreamBuilder<List<Product>>(
                        stream: _streamProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text("Lỗi khi tải dữ liệu"));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text("Không có sản phẩm nào"));
                          } else {
                            List<Product> products = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  products.length,
                                  (index) =>
                                      ProductCard(productInfo: products[index]),
                                ),
                              ),
                            );
                          }
                        })),
                // Khung xương định hình
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.bottomCenter,
                  width: 960,
                  height: 350,
                  // Nút xử lý sản phẩm PLU
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      width: 320,
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1.0,
                                spreadRadius: 0.2,
                                offset: Offset(
                                  1.0,
                                  5.0,
                                ),
                                color: Colors.black)
                          ],
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(5),
                              width: 50,
                              height: 50,
                              child: Image.network(
                                  "https://cdn1.iconfinder.com/data/icons/fruit-cartoon-flat-cute-fruity/512/mangosteen-1024.png")),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DashCartPLUScreen()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: const Text(
                                "Add PLU Item",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Information view
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: const Column(
                    children: [
                      Text("Done Shopping ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      Text(
                        "Exit to the Dash cart lane, please",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                miniBillContainer(streamProducts: ApiService().streamProducts)
              ],
            )
          ],
        ),
      ),
    );
  }

  Container miniBillContainer(
      {required Stream<List<Product>> Function() streamProducts}) {
    Stream<List<Product>> productStream = streamProducts();
    return Container(
      padding: const EdgeInsets.all(10),
      child: StreamBuilder<List<Product>>(
        stream: productStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Product> products = snapshot.data!;
          int totalPrice =
              products.fold(0, (sum, item) => sum + item.price * item.quantity);
          int numbersOfItems =
              products.fold(0, (sum, item) => sum + item.quantity);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Items
              Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("ITEMS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black)),
                    Text("$numbersOfItems",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black))
                  ],
                ),
              ),
              const SizedBox(width: 50),
              // Total Cost
              Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black)),
                    Text("${formatCurrency(totalPrice)} Đ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black))
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
