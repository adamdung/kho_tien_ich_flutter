import 'package:flutter/material.dart';

// ------ Tăng trưởng khách hàng ------
class MoHinhBieuDoTangTruong {
  String year; //năm
  int number; // số lượng
  String valueCol; // màu của cột biểu đồ

  MoHinhBieuDoTangTruong({this.year, this.number, this.valueCol});

  factory MoHinhBieuDoTangTruong.fromMap(Map<String, dynamic> map) {
    return MoHinhBieuDoTangTruong(
      number: map['saleVal'],
      valueCol: map['colorVal'],
      year: map['saleYear'],
    );
  }
}
// // GrowthOfClients.fromMap(Map<String, dynamic> map)
// //     : assert(map['saleVal'] != null),
// //       assert(map['saleYear'] != null),
// //       assert(map['colorVal'] != null),
// //       number = map['saleVal'],
// //       valueCol = map['colorVal'],
// //       year = map['saleYear'];
