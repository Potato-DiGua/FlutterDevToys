import 'package:flutter/material.dart';

import '../utils/device_type.dart';

class URLEncodePage extends StatefulWidget {
  const URLEncodePage({Key? key}) : super(key: key);

  @override
  _URLEncodePageState createState() => _URLEncodePageState();
}

class _URLEncodePageState extends State<URLEncodePage> {
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
                    maxLines: 5,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          '请先填写内容',
                          style: TextStyle(fontFamily: 'Noto Sans'),
                        )));
                      }
                      setState(() {
                        try {
                          _content = Uri.encodeComponent(_controller.text);
                        } catch (e) {
                          _content = "";
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            e.toString(),
                            style: const TextStyle(fontFamily: 'Noto Sans'),
                          )));
                        }
                      });
                    },
                    child: const Text('编码'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_controller.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            '请先填写内容',
                            style: TextStyle(fontFamily: 'Noto Sans'),
                          )));
                        }
                        setState(() {
                          try {
                            _content = Uri.decodeComponent(_controller.text);
                          } catch (e) {
                            _content = "";
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                e.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ));
                          }
                        });
                      },
                      child: const Text('解码'),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: double.infinity,
                  child: SelectableText(_content),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar? _buildAppBar() {
    if (DeviceType.isMobile){
      return null;
    }
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: const Text('URL编码/解码'),
    );
  }
}
