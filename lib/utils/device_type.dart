import 'dart:io';

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DeviceType {
  static bool isWeb = kIsWeb;

  static bool isIOS = !isWeb && Platform.isIOS;
  static bool isAndroid = !isWeb && Platform.isAndroid;
  static bool isMacOS = !isWeb && Platform.isMacOS;
  static bool isLinux = !isWeb && Platform.isLinux;
  static bool isWindows = !isWeb && Platform.isWindows;

  static bool get isDesktop => isWindows || isMacOS || isLinux;

  static bool get isMobile => isAndroid || isIOS;

  static bool get isDesktopOrWeb => isDesktop || isWeb;

  static bool get isMobileOrWeb => isMobile || isWeb;

  static bool isHandSet(BuildContext context) {
    final device = Breakpoint.fromMediaQuery(context).device;
    return device == LayoutClass.mediumHandset ||
        device == LayoutClass.smallHandset ||
        device == LayoutClass.largeHandset;
  }

}
