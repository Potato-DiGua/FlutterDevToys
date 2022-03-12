import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/darcula.dart';

import '../../utils/device_type.dart';

class JsonFormatPage extends StatefulWidget {
  static const title = 'JSON格式化';

  const JsonFormatPage({Key? key}) : super(key: key);

  @override
  _JsonFormatPageState createState() => _JsonFormatPageState();
}

class _JsonFormatPageState extends State<JsonFormatPage> {
  String _content = '';

  final _controller = TextEditingController();
  late ScrollController _pageScrollerController;

  @override
  void initState() {
    super.initState();
    _pageScrollerController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageScrollerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        controller: _pageScrollerController,
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '输入内容',
                    ),
                    onSaved: (String? content) {},
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 2 << 10,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ElevatedButton(
                  onPressed: onFormatClick,
                  child: const Text('格式化'),
                ),
              ),
              buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildContent() {
    final theme = HashMap.of(darculaTheme);
    theme['root'] = const TextStyle(
        backgroundColor: Colors.transparent, color: Color(0xffbababa));
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            width: double.infinity,
            child: HighlightView(
              // The original code to be highlighted
              _content,
              // Specify language
              // It is recommended to give it a value for performance
              language: 'json',
              // Specify highlight theme
              // All available themes are listed in `themes` folder
              theme: theme,
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          if (_content.isNotEmpty)
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    try {
                      Clipboard.setData(ClipboardData(text: _content));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('复制成功')));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  icon: const Icon(
                    Icons.copy,
                  )),
            )
        ],
      ),
    );
  }

  void onFormatClick() {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('请先填写内容')));
    }

    setState(() {
      try {
        _content = const JsonEncoder.withIndent('    ')
            .convert(const JsonDecoder().convert(_controller.text));
      } catch (e) {
        _content = "";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    });
  }

  AppBar? _buildAppBar() {
    if (DeviceType.isMobile) {
      return null;
    }
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: const Text(JsonFormatPage.title),
    );
  }
}
