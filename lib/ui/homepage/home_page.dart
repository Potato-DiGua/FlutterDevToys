import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/ui/homepage/model.dart';
import 'package:flutter_dev_toys/utils/device_type.dart';

import '../../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<BtnGroup> data = [
    BtnGroup(
        '转换',
        [
          BtnItem('URL编码/解码', '/url_encode'),
          BtnItem('二维码', '/qrcode'),
        ],
        icon: Icons.sync_alt)
  ];
  List<String> pageNames =
      data.expand((group) => group.children.map((e) => e.routeName)).toList();

  List<bool> expandState = List.generate(data.length, (index) => false);

  int index = 0;
  bool showDrawer = false;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    showDrawer = DeviceType.isHandSet(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Row(
        children: [if (!showDrawer) _buildSideBar(context), _buildContent()],
      ),
      drawer: Drawer(child: _buildSideBar(context)),
    );
  }

  Container _buildSideBar(BuildContext context) {
    return Container(
      color: Colors.black26,
      width: 300,
      padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).padding.top, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildNavigation(context),
      ),
    );
  }

  AppBar? _buildAppBar() {
    if (!showDrawer) {
      return null;
    } else {
      return AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('FlutterDevToys'),
      );
    }
  }

  List<Widget> _buildNavigation(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0, len = data.length; i < len; i++) {
      final group = data[i];

      widgets.add(Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: group.icon != null ? Icon(group.icon) : null,
          title:
              Text(group.title, style: Theme.of(context).textTheme.titleMedium),
          trailing:
              Icon(expandState[i] ? Icons.expand_less : Icons.expand_more),
          onTap: () {
            setState(() {
              expandState[i] = !expandState[i];
            });
          },
        ),
      ));
      if (expandState[i]) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Column(
            children: group.children.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(item.routeName);
                    final find = pageNames.indexOf(item.routeName);
                    if (find >= 0) {
                      setState(() {
                        index = find;
                      });
                      if (showDrawer) {
                        Navigator.of(context).pop();
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ));
      }
    }
    return widgets;
  }

  Widget _buildContent() {
    return Expanded(
      flex: 1,
      child: IndexedStack(
        index: index,
        children:
            pageNames.map((name) => MyApp.routes[name]!(context)).toList(),
      ),
    );
  }
}
