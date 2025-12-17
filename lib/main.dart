import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_lap_top/login/login_page.dart';
import 'package:shop_lap_top/model/restaurant.dart';
import 'package:shop_lap_top/setting/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => Restaurant()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Food',
      theme: themeProvider.themeData,
      home: LoginPage(),
    );
  }
}
