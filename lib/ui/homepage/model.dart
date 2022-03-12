import 'package:flutter/cupertino.dart';

class BtnItem {
  final String title;
  final String routeName;

  const BtnItem(this.title, this.routeName);
}

class BtnGroup {
  final String title;
  final List<BtnItem> children;
  final IconData? icon;

  const BtnGroup(this.title, this.children, {this.icon});
}
