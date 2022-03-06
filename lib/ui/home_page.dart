import 'package:flutter/material.dart';
import 'package:breakpoint/breakpoint.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('FlutterDevToys'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: Breakpoint.fromMediaQuery(context).columns,
          children: _renderBtn(context),
        ),
      ),
    );
  }

  List<Widget> _renderBtn(BuildContext context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/qrcode');
        },
        child: const Text('二维码'),
      ),
    ];
  }
}
