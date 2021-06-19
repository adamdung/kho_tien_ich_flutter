import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:kho_tien_ich_flutter/chart/sources/data/bar_chart/barchar_model.dart';

import 'package:kho_tien_ich_flutter/chart/sources/data/circle_bar/phieudanhgia_model.dart';

Widget PhieuDanhGiaWidget(context,
    List<charts.Series<MoHinhBieuDoTangTruong, String>> _seriesPieData) {
  return charts.PieChart(
    _seriesPieData,
    animate: true,
    animationDuration: Duration(seconds: 1),
    behaviors: [
      charts.DatumLegend(
        outsideJustification: charts.OutsideJustification.endDrawArea,
        horizontalFirst: false,
        desiredMaxRows: 2,
        cellPadding: EdgeInsets.only(right: 4, bottom: 4),
        entryTextStyle: charts.TextStyleSpec(
          color: charts.MaterialPalette.purple.shadeDefault,
          fontSize: 14,
        ),
      )
    ],
    defaultRenderer:
        charts.ArcRendererConfig(arcWidth: 100, arcRendererDecorators: [
      charts.ArcLabelDecorator(
        labelPosition: charts.ArcLabelPosition.auto,
      )
    ]),
  );
}
