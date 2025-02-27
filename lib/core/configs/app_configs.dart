import 'package:flutter/material.dart';

class AppConfig {
  static Map<String, Color> colorOfHomePage = {};
  static Map<String, Map<String, String>> textLanguage = {};
  static bool isDarkMode = false;
  static bool isVietnamese = true;
  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.light_mode),
      WidgetState.any: Icon(Icons.dark_mode),
    },
  );

  static void loadLanguage() {
    AppConfig.textLanguage = (AppConfig.isVietnamese)
        ? {
            "appbar": {
              "trangchu": "Trang Chủ",
              "khuyenmai": "Khuyến Mãi",
              "huongdan": "Hướng dẫn"
            },
            "banner": {"xinchao": "Xin chào"},
            "categories": {"tatca": "Tất cả", "loai": ""},
            "total_cost": {
              "tongthanhtoan": "Tổng thanh toán",
              "thanhtien": "Thành tiền"
            }
          }
        : {
            "appbar": {
              "trangchu": "Home",
              "khuyenmai": "Discount",
              "huongdan": "Guide"
            },
            "banner": {"xinchao": "Hello"},
            "categories": {"tatca": "All", "loai": ""},
            "total_cost": {
              "tongthanhtoan": "Total Payment",
              "thanhtien": "Total"
            }
          };
  }

  static void loadColors() {
    AppConfig.colorOfHomePage = (AppConfig.isDarkMode == false)
        ? {
            "background": Colors.white,
            "appbar": Color(0xFF4FE94D),
            "grid": Colors.grey,
            "categorie_grid": Colors.greenAccent,
            "text": Colors.black,
          }
        : {
            "background": Color.fromARGB(255, 61, 61, 60),
            "appbar": Color(0xFF4FE94D),
            "grid": Colors.white,
            "categorie_grid": Color.fromARGB(255, 29, 58, 44),
            "text": Colors.white,
          };
  }
}
