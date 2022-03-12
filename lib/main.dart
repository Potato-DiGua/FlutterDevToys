import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/ui/format/json_format.dart';

import 'ui/encode/base64_encode.dart';
import 'ui/encode/qrcode.dart';
import 'ui/encode/url_encode.dart';
import 'ui/homepage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final Map<String, Widget Function(BuildContext)> routes = {
    "/qrcode": (context) => const QRCodePage(),
    "/url_encode": (context) => const URLEncodePage(),
    "/base64_encode": (context) => const Base64EncodePage(),
    '/json_format': (context) => const JsonFormatPage()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterDevToys',
        theme: ThemeData(
          brightness: Brightness.dark,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        routes: routes);
  }
}
