import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/data/models/product_count_money.dart';
import 'package:vcartpi/presentation/pages/discount_page/discount_page.dart';
import 'package:vcartpi/presentation/pages/guide_page/components/discount_part.dart';
import 'package:vcartpi/presentation/pages/home_page/home_page.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  List<ProductCountMoneyModel> listProducts = [];

  void _loadProducts() {
    listProducts = ProductCountMoneyModel.loadListProducts();
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
    AppConfig.loadColors();
    AppConfig.loadLanguage();
    return Scaffold(
      backgroundColor: AppConfig.colorOfHomePage["background"],
      body: Column(
        children: [
          _customAppBar(),
          // Đây là toàn bộ nội dung của cả trang
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: 935,
              height: 440,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFD9D9D9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nơi đây chứa hai cột chính của trang
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      width: 471,
                      height: 386,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        // Mỗi một stack là một ô hướng dẫn
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            stackGuideBlock(
                                "1", "Bỏ sản phẩm muốn mua vào giỏ hàng"),
                            stackGuideBlock("2",
                                "Chờ cho đến khi thông tin sản phẩm được hiển thị lên màn hình"),
                            stackGuideBlock("3",
                                "Kiểm tra thông tin thanh toán và xác nhận thanh toán"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Nơi để banner hướng dẫn
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 372,
                      height: 386,
                      child: Container(
                        width: 327,
                        height: 372,
                        decoration: BoxDecoration(
                            color: Color(0xFF938F8F),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: DiscountPart(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack stackGuideBlock(String idx, String textGuide) {
    return Stack(
      children: [
        // Đây là nơi hiển thị nội dung hướng dẫn
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.centerLeft,
              width: 421,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFA29D9D),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  textGuide,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              )),
        ),
        // Hiển thị thứ tự block
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Container(
              alignment: Alignment.center,
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: Text(idx,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ))),
        ),
      ],
    );
  }

  Widget _customAppBar() {
    return Container(
        width: 984,
        height: 70,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
        decoration: BoxDecoration(
            color: AppConfig.colorOfHomePage["appbar"],
            borderRadius: BorderRadius.circular(15)),
        child: _createActionsAppbar());
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
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
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
            onTap: () {},
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
