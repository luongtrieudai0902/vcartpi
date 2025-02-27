import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/data/models/product_count_money.dart';
import 'package:vcartpi/presentation/pages/guide_page/guide_page.dart';
import 'package:vcartpi/presentation/pages/home_page/home_page.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _GuidePageState();
}

class _GuidePageState extends State<DiscountPage> {
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
          Row(),
        ],
      ),
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
            onTap: () {},
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
