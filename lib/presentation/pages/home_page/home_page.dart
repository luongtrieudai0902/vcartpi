import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/core/utils/api_service.dart';
import 'package:vcartpi/data/models/product.dart';
import 'package:vcartpi/presentation/pages/discount_page/discount_page.dart';
import 'package:vcartpi/presentation/pages/guide_page/guide_page.dart';
import 'package:vcartpi/presentation/pages/home_page/components/bill_container.dart';
import 'package:vcartpi/presentation/pages/home_page/components/product_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, Product> groupedProducts = {};

  late Future<List<Product>> listProducts;

  void _loadProducts() {
    listProducts = ApiService().fetchProducts();
  }

  Stream<List<Product>> _streamProducts() async* {
    while (true) {
      List<Product> products = await ApiService().fetchProducts();
      yield products; // Cập nhật dữ liệu mới vào Stream
      await Future.delayed(Duration(seconds: 5)); // Cập nhật mỗi 5 giây
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
    return Scaffold(
      backgroundColor: AppConfig.colorOfHomePage["background"],
      body: Column(
        children: [
          _customAppBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Đây là nơi hiển thị thông tin các sản phẩm đang trong giỏ hàng
              Container(
                margin: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 5),
                padding: EdgeInsets.all(5),
                width: 620,
                height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Nơi đây hiển thị Categories và Filter
                    SizedBox(
                      width: 650,
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Đây là nơi hiển thị và sinh categories
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 420,
                            height: 42,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  10,
                                  (int index) => InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () {
                                      print("Clicked on $index");
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.greenAccent),
                                      ),
                                      child: Text(
                                        (index == 0)
                                            ? "${AppConfig.textLanguage["categories"]?["tatca"]}"
                                            : "Loại Tùm lum $index",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppConfig
                                                .colorOfHomePage["text"]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Nơi đây là nơi ăn tiền - hiển thị các sản phẩm trên giỏ hàng
                    const SizedBox(height: 10),
                    Expanded(
                      child: StreamBuilder<List<Product>>(
                        stream: _streamProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("Lỗi khi tải dữ liệu"));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text("Không có sản phẩm nào"));
                          } else {
                            List<Product> products = snapshot.data!;
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ProductContainer(
                                  product: products[index],
                                  numbers: 1,
                                  colorInUsed: {
                                    "grid": Colors.grey.shade300,
                                    "text": Colors.black,
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Đây là nơi hiển thị bill tính tiền
              BillContainer(streamProducts: ApiService().streamProducts),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customAppBar() {
    return Expanded(
      child: Container(
          width: 984,
          height: 70,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 5),
          decoration: BoxDecoration(
              color: AppConfig.colorOfHomePage["appbar"],
              borderRadius: BorderRadius.circular(15)),
          child: _createActionsAppbar()),
    );
  }

  SizedBox _createActionsAppbar() {
    return SizedBox(
      child: Row(
        children: [
          // Switcher
          Switch(
              thumbIcon: AppConfig.thumbIcon,
              value: AppConfig.isDarkMode,
              onChanged: (value) {
                setState(() {
                  AppConfig.isDarkMode = value;
                });
              }),
          SizedBox(width: 200),
          // Buttons
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(top: 5),
              width: 73,
              height: 52,
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/menu.svg",
                      semanticsLabel: 'Icon'),
                  Text("${AppConfig.textLanguage["appbar"]!["trangchu"]}",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DiscountPage()));
            },
            child: Container(
              padding: EdgeInsets.only(top: 5),
              width: 90,
              height: 52,
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/tag.svg"),
                  Text(
                    "${AppConfig.textLanguage["appbar"]!["khuyenmai"]}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GuidePage()));
            },
            child: Container(
              padding: EdgeInsets.only(top: 5),
              width: 90,
              height: 52,
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/chamthan.svg"),
                  Text(
                    "${AppConfig.textLanguage["appbar"]!["huongdan"]}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 100),
          // Flag
          InkWell(
            onTap: () {
              setState(() {
                AppConfig.isVietnamese = !AppConfig.isVietnamese;
              });
            },
            child: SizedBox(
              width: 46,
              height: 46,
              child: SvgPicture.asset(
                  (AppConfig.isVietnamese)
                      ? "assets/icons/vnflag.svg"
                      : "assets/icons/usflag.svg",
                  semanticsLabel: 'Icon'),
            ),
          ),
          SizedBox(width: 20),
          Text("${AppConfig.textLanguage["banner"]!["xinchao"]}, Dai Phong",
              style: TextStyle(color: Colors.white)),
          SizedBox(width: 20),
          _createAvatar()
        ],
      ),
    );
  }

  Stack _createAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          child: Image.asset("assets/icons/avatar.png", width: 60, height: 60),
        ),
        Container(
          width: 40,
          height: 30,
          alignment: Alignment.topRight,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 2, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
