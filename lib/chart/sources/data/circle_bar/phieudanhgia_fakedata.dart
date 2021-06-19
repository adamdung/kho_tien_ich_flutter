import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:kho_tien_ich_flutter/chart/sources/data/circle_bar/phieudanhgia_model.dart';

class PhieuDanhGiaFakeData {
  List<charts.Series<PhieuDanhGiaModel, String>> seriesPieData =
      <charts.Series<PhieuDanhGiaModel, String>>[];

  generateData() {
    var pieDataGrowthClientsNoi = [
      PhieuDanhGiaModel(xeploai: 'Rất Tốt', tyle: 5, mau: Colors.blue),
      PhieuDanhGiaModel(xeploai: 'Tốt', tyle: 20, mau: Colors.orange),
      PhieuDanhGiaModel(xeploai: 'Khá', tyle: 50, mau: Colors.green),
      PhieuDanhGiaModel(xeploai: 'Trung Bình', tyle: 30, mau: Colors.pink),
      PhieuDanhGiaModel(xeploai: 'Yếu', tyle: 15, mau: Colors.purple),
    ];
//----------đưa dữ lie
    seriesPieData.add(
      charts.Series(
          data: pieDataGrowthClientsNoi,
          // ---- Cột x -------
          domainFn: (PhieuDanhGiaModel phieuDanhGiaModel, _) =>
              phieuDanhGiaModel.xeploai,
          // ------- Cột y -----
          measureFn: (PhieuDanhGiaModel phieuDanhGiaModel, _) =>
              phieuDanhGiaModel.tyle,
          // ------ Màu của cột -----
          colorFn: (PhieuDanhGiaModel phieuDanhGiaModel, _) =>
              charts.ColorUtil.fromDartColor(phieuDanhGiaModel.mau),
          id: 'XepLoai'),
    );
  }
}
