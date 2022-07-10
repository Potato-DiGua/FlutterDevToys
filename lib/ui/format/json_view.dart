import 'dart:convert';

import 'package:flutter/material.dart';

class JsonView extends StatelessWidget {
  final String? jsonText;

  const JsonView(this.jsonText, {Key? key}) : super(key: key);
  static const space = 24.0;

  @override
  Widget build(BuildContext context) {
    if (jsonText?.isEmpty ?? false) {
      return Container();
    }
    final json = jsonDecode(jsonText!);
    return _buildMapView(null, json, 1);
  }

  Widget _buildBaseValue(String? key, dynamic value, int level) {
    if (value is String) {
      return _buildValueView(key!, '"$value"', level);
    } else if (value is int) {
      return _buildValueView(key!, value.toString(), level,
          color: Colors.orange);
    } else if (value is double) {
      return _buildValueView(key!, value.toString(), level,
          color: Colors.orange);
    } else if (value is Map) {
      return _buildMapView(key, value, level + 1);
    } else if (value is List) {
      return _buildListView(key, value, level + 1);
    } else {
      throw Exception('暂不支持${value.runtimeType.toString()}');
    }
  }

  Widget _buildValueView(String key, String value, int level,
      {Color color = Colors.white}) {
    return Padding(
      padding: EdgeInsets.only(left: space * level, top: 3, bottom: 3),
      child: Row(children: [
        _buildKeyView(key),
        const Text(":  "),
        Text(
          value,
          style: TextStyle(color: color),
        )
      ]),
    );
  }

  Widget _buildMapView(String? key, Map map, int level) {
    final views =
        map.keys.map((key) => _buildBaseValue('"$key"', map[key], level));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        key == null ? const Text('{') : _buildValueView(key, '{', level - 1),
        ...views,
        Padding(
          padding: EdgeInsets.only(left: space * (level - 1)),
          child: const Text("}"),
        )
      ],
    );
  }

  Widget _buildKeyView(String key) {
    return Text(
      key,
      style: const TextStyle(color: Colors.purpleAccent),
    );
  }

  Widget _buildListView(String? key, List list, int level) {
    final views = List.generate(list.length,
        (index) => _buildBaseValue(index.toString(), list[index], level));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        key == null ? const Text('[') : _buildValueView(key, '[', level - 1),
        ...views,
        Padding(
          padding: EdgeInsets.only(left: space * (level - 1)),
          child: const Text("]"),
        )
      ],
    );
  }
}
