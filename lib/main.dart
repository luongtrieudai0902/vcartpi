import 'package:flutter/material.dart';
import 'package:vcartpi/data/models/product_count_money.dart';
import 'package:vcartpi/presentation/pages/home_page/home_page.dart';
import 'package:vcartpi/presentation/pages/product_page/product_page.dart';
import 'package:vcartpi/presentation/pages/test_page/test_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1024, 600),
    minimumSize: Size(1024, 600),
    maximumSize: Size(1024, 600),
    center: true,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.show();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
