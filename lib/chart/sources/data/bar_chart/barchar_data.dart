import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'barchar_model.dart';

class DuLieuBieuDoTangTruong {
  List<charts.Series<MoHinhBieuDoTangTruong, String>> seriesBarData;
  taoDuLieuBieuDoTangTruong(dataList) {
    seriesBarData = <charts.Series<MoHinhBieuDoTangTruong, String>>[];
    seriesBarData.add(
      charts.Series(
        // ---- Cột x -------
        domainFn: (MoHinhBieuDoTangTruong khachHangs, _) =>
            khachHangs.year.toString(),
        // ---- Cột y -------
        measureFn: (MoHinhBieuDoTangTruong khachHangs, _) => khachHangs.number,
        // ---- màu cột -------
        colorFn: (MoHinhBieuDoTangTruong khachHangs, _) =>
            charts.ColorUtil.fromDartColor(
                Color(int.parse(khachHangs.valueCol))),
        // ---- Tên trên bảng -------
        id: 'Khách hàng',
        // ---- Dữ liệu đầu vào -------
        data: dataList,
        labelAccessorFn: (MoHinhBieuDoTangTruong row, _) => "${row.year}",
      ),
    );
    return seriesBarData;
  }
}
