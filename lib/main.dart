import 'package:flutter/material.dart';
import 'package:socnet_leewr/pages/home.dart';
import 'package:socnet_leewr/style/lib_color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData.from(colorScheme: lightColorScheme),
      darkTheme: ThemeData.from(colorScheme: darkColorScheme),
      //theme: ThemeData(colorSchemeSeed: Colors.orange),
      //darkTheme: ThemeData(colorSchemeSeed: Colors.orange, brightness: Brightness.dark),
      //theme: ThemeData.from(colorScheme: const ColorScheme.light()),
      //darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark()),
      home: Home(),
    );
  }
}
