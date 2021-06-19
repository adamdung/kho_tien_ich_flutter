import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kho_tien_ich_flutter/chart/sources/data/bar_chart/barchar_data.dart';
import 'package:kho_tien_ich_flutter/chart/sources/data/bar_chart/barchar_model.dart';
import 'package:kho_tien_ich_flutter/chart/sources/data/circle_bar/phieudanhgia_fakedata.dart';
import 'package:kho_tien_ich_flutter/chart/sources/data/circle_bar/phieudanhgia_model.dart';
import 'package:kho_tien_ich_flutter/chart/widgets/barchar_widget.dart';
import 'package:kho_tien_ich_flutter/chart/widgets/piechar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ----- Tạo một biến lớp FakeData ----
  var duLieuBieuDoTangTruong = DuLieuBieuDoTangTruong();

  var phieuDanhGiaFakeData = PhieuDanhGiaFakeData();
  Stream stream = FirebaseFirestore.instance.collection('sales').snapshots();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream;
  }

  // List<charts.Series<GrowthOfClients, String>> _seriesBarData;
  // List<GrowthOfClients> mydata;
  // _generateData(mydata) {
  //   _seriesBarData = List<charts.Series<GrowthOfClients, String>>();
  //   _seriesBarData.add(
  //     charts.Series(
  //       domainFn: (GrowthOfClients sales, _) => sales.year.toString(),
  //       measureFn: (GrowthOfClients sales, _) => sales.number,
  //       colorFn: (GrowthOfClients sales, _) =>
  //           charts.ColorUtil.fromDartColor(Color(int.parse(sales.valueCol))),
  //       id: 'Sales',
  //       data: mydata,
  //       labelAccessorFn: (GrowthOfClients row, _) => "${row.year}",
  //     ),
  //   );
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   // ------ Nạp data ------
  //   growthOfClientsFakeData.seriesBarData =
  //       <charts.Series<GrowthOfClients, String>>[];
  //
  //   phieuDanhGiaFakeData.seriesPieData =
  //       <charts.Series<PhieuDanhGiaModel, String>>[];
  //   phieuDanhGiaFakeData.generateData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Example'),
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child:

                  // Stream lấy dữ liệu từ firebase ra widget
                  StreamBuilder<QuerySnapshot>(
                      stream: stream,
                      builder: (context, snapShot) {
                        if (!snapShot.hasData || snapShot.hasError)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        // --------- Chuyển dữ liệu thành list -------->>>
                        //--------Cách 1
                        List<MoHinhBieuDoTangTruong> dataList = snapShot
                            .data.docs
                            .map((documentSnapshot) =>
                                MoHinhBieuDoTangTruong.fromMap(
                                    documentSnapshot.data()))
                            .toList();
                        //--------Cách 2
                        List<MoHinhBieuDoTangTruong> dataList2 = [];
                        snapShot.data.docs.forEach((doc) {
                          // ------- Lấy ra map dữ liệu ---------
                          Map<String, dynamic> mapDocument = doc.data();

                          // ------- tạo ra list gồm các GrowthOfClients-------
                          dataList2
                              .add(MoHinhBieuDoTangTruong.fromMap(mapDocument));
                        });
                        //   <<<-------------------------------------------

                        duLieuBieuDoTangTruong
                            .taoDuLieuBieuDoTangTruong(dataList2);

                        return KhoiWidgetBieuDoDangCot(
                            context, duLieuBieuDoTangTruong);

                        // ---------------------------------------------
                      }),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child:

                  // Stream lấy dữ liệu từ firebase
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('sales')
                          .snapshots(),
                      builder: (context, taskSnapShot) {
                        if (!taskSnapShot.hasData || taskSnapShot.hasError)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        // --------- Chuyển dữ liệu thành list --------
                        List<MoHinhBieuDoTangTruong> dataList = taskSnapShot
                            .data.docs
                            .map((documentSnapshot) =>
                                MoHinhBieuDoTangTruong.fromMap(
                                    documentSnapshot.data()))
                            .toList();

                        duLieuBieuDoTangTruong
                            .taoDuLieuBieuDoTangTruong(dataList);
                        return chartPhieuDanhGia(
                            context, duLieuBieuDoTangTruong);

                        // ---------------------------------------------
                      }),
            ),
          ],
        ),
      ]),
    );
  }

  // Widget chartStandingStock(context, List<GrowthOfClients> dataList) {
  //   mydata = dataList;
  //   _generateData(mydata);
  //   return Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: Container(
  //       child: Center(
  //         child: Column(
  //           children: <Widget>[
  //             Text(
  //               'Chart và firebase',
  //               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
  //             ),
  //             SizedBox(
  //               height: 10.0,
  //             ),
  //             Expanded(
  //               child: charts.BarChart(
  //                 _seriesBarData,
  //                 animate: true,
  //                 animationDuration: Duration(seconds: 1),
  //                 behaviors: [
  //                   new charts.DatumLegend(
  //                     entryTextStyle: charts.TextStyleSpec(
  //                         color: charts.MaterialPalette.purple.shadeDefault,
  //                         fontFamily: 'Georgia',
  //                         fontSize: 14),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Center(
  //                 child: Text('Biểu đồ đánh giá của khách hàng',
  //                     style: TextStyle(fontWeight: FontWeight.bold))),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget KhoiWidgetBieuDoDangCot(
      context, DuLieuBieuDoTangTruong growthOfClientsFakeData) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: WidgetBieuDoDangCot(
                context, growthOfClientsFakeData.seriesBarData),
          ),
          // ------- Legend of charts --------
          Center(
            child: Text('Biểu đồ tăng trưởng khách hàng',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget chartPhieuDanhGia(
      context, DuLieuBieuDoTangTruong growthOfClientsFakeData) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: PhieuDanhGiaWidget(
                context, growthOfClientsFakeData.seriesBarData),
          ),
          // ------- Legend of charts --------
          Center(
            child: Text('Biểu đánh giá của khách hàng',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
