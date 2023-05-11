import 'package:flutter/material.dart';
import 'package:rick_and_cards/pages/detail/detail_page.dart';
import 'package:rick_and_cards/pages/home/home_page.dart';
import 'package:rick_and_cards/pages/splash/splash_page.dart';

void main() {
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
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}
