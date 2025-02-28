import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vcartpi/core/configs/app_configs.dart';
import 'package:vcartpi/core/utils/api_service.dart';
import 'package:vcartpi/data/models/product_count_money.dart';
import 'package:vcartpi/presentation/pages/discount_page/discount_page.dart';
import 'package:vcartpi/presentation/pages/guide_page/guide_page.dart';
import 'package:vcartpi/presentation/pages/home_page/components/bill_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductCountMoneyModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = _fetchProducts();
    AppConfig.loadColors();
    AppConfig.loadLanguage();
  }

  Future<List<ProductCountMoneyModel>> _fetchProducts() async {
    try {
      final products = await ApiService().fetchProducts();
      return ProductCountMoneyModel.fromJsonList(products);
    } catch (e) {
      debugPrint('Error fetching products: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorOfHomePage["background"],
      body: Column(
        children: [
          _customAppBar(),
          Expanded(
            child: FutureBuilder<List<ProductCountMoneyModel>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi khi tải sản phẩm"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Không có sản phẩm nào"));
                }
                return _buildProductList(snapshot.data!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<ProductCountMoneyModel> products) {
    Map<String, ProductCountMoneyModel> groupedProducts = {};
    for (var product in products) {
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

    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 330,
        childAspectRatio: 1.3,
      ),
      itemCount: groupedProducts.length,
      itemBuilder: (context, index) {},
    );
  }

  Widget _customAppBar() {
    return Container(
      height: 70,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppConfig.colorOfHomePage["appbar"],
        borderRadius: BorderRadius.circular(15),
      ),
      child: _createActionsAppbar(),
    );
  }

  Widget _createActionsAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Switch(
          thumbIcon: AppConfig.thumbIcon,
          value: AppConfig.isDarkMode,
          onChanged: (value) => setState(() => AppConfig.isDarkMode = value),
        ),
        _buildNavButton("menu.svg", "trangchu", () {}),
        _buildNavButton("tag.svg", "khuyenmai", () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => DiscountPage()));
        }),
        _buildNavButton("chamthan.svg", "huongdan", () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => GuidePage()));
        }),
        InkWell(
          onTap: () =>
              setState(() => AppConfig.isVietnamese = !AppConfig.isVietnamese),
          child: SvgPicture.asset(
            AppConfig.isVietnamese
                ? "assets/icons/vnflag.svg"
                : "assets/icons/usflag.svg",
            width: 46,
            height: 46,
          ),
        ),
        Text("${AppConfig.textLanguage["banner"]!["xinchao"]}, Dai Phong",
            style: TextStyle(color: Colors.white)),
        _createAvatar(),
      ],
    );
  }

  Widget _buildNavButton(String iconPath, String textKey, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset("assets/icons/$iconPath"),
          Text("${AppConfig.textLanguage["appbar"]![textKey]}",
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _createAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/icons/avatar.png"),
          radius: 30,
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
