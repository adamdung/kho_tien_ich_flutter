import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:kho_tien_ich_flutter/chart/sources/data/bar_chart/barchar_model.dart';

Widget WidgetBieuDoDangCot(context,
    List<charts.Series<MoHinhBieuDoTangTruong, String>> _seriesBarData) {
  return charts.BarChart(
    _seriesBarData,
    animate: true,
    animationDuration: Duration(seconds: 1),
    // ------ Thay đổi kiểu hiển thị của các cột trong biểu đò ở đây -----
    barGroupingType: charts.BarGroupingType.groupedStacked,

    behaviors: [
      charts.SeriesLegend(
        outsideJustification: charts.OutsideJustification.endDrawArea,
        horizontalFirst: false,
        desiredMaxRows: 2,
        cellPadding: EdgeInsets.only(right: 4, bottom: 4),
        entryTextStyle: charts.TextStyleSpec(
          color: charts.MaterialPalette.black,
          fontSize: 14,
        ),
      )
    ],
  );
}
