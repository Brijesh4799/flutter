import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Blue', percent: 1, color: const Color(0xff0293ee)),
    Data(name: 'Orange', percent: 1, color: const Color(0xfff8b250)),
    Data(name: 'Black', percent: 1, color: Colors.black),
  //  Data(name: 'Green', percent: 15, color: const Color(0xff13d38e)),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}