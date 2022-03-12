import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/utils/device_type.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String _qrcodeContent = '';

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
                      hintText: '输入二维码的内容',
                    ),
                    onSaved: (String? content) {},
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        '请先填写内容',
                        style: TextStyle(fontFamily: 'Noto Sans'),
                      )));
                    } else {
                      setState(() {
                        _qrcodeContent = _controller.text;
                      });
                    }
                  },
                  child: const Text('生成二维码')),
              if (_qrcodeContent.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: QrImage(
                          data: _qrcodeContent,
                          version: QrVersions.auto,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      if (!DeviceType.isHandSet(context))
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Container(
                                color: Colors.black38,
                                padding: const EdgeInsets.all(8),
                                child: Text(_qrcodeContent)),
                          ),
                        )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar? _buildAppBar() {
    if (DeviceType.isMobile) {
      return null;
    }
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: const Text('二维码'),
    );
  }
}
