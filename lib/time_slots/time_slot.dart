import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimeSlot(),
    );
  }
}

class TimeSlot extends StatefulWidget {
  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  var _isExpanded = false;
  int _expandedIndex = 10;
  String time = '';
  var id;
  var slots = [
    Slot('09:00AM', 0),
    Slot('10:00AM', 0),
    Slot('11:00AM', 0),
    Slot('12:00PM', 0),
    //... Rest of the items
  ];

  doiMau(index, soKhachDat) {
    if (_expandedIndex == index && soKhachDat < 4) {
      return Colors.blue;
    } else if (soKhachDat == 4) {
      return Colors.red;
    } else {
      return Colors.blue[100];
    }
  }

  String trangThai = '';
  String thayDoiTrangThai(soKhachDat) {
    if (soKhachDat < 4) return trangThai = 'Còn trống';
    return trangThai = 'Full';
  }

  List<int> soKhachDat = [0, 0, 0];
  var ID;

  void updateDataFirebase() async {
    await FirebaseFirestore.instance
        .collection('datLich')
        .doc(ID)
        .update({'soKhachDat': soKhachDat[_expandedIndex]});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pick time'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('datLich')
                    .orderBy('thoiGian')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.hasError)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          childAspectRatio: 3 / 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        var docIndex = snapshot.data.docs[index];
                        return GestureDetector(
                          child: Container(
                            color: doiMau(index, docIndex['soKhachDat']),
                            // _expandedIndex == index &&
                            //         snapshot.data.docs[index]['soKhachDat'] < 4
                            //     ? Colors.blue
                            //     : Colors.blue[100],
                            child: Column(
                              children: [
                                Text(docIndex['thoiGian']),
                                Text(thayDoiTrangThai(docIndex['soKhachDat'])),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _expandedIndex = index;

                              if (docIndex['soKhachDat'] < 4) {
                                time = docIndex['thoiGian'];
                                soKhachDat[index]++;
                                ID = docIndex.id;
                                // updateDataFirebase(
                                //     snapshot.data.docs[index].id, index);
                              }
                              // if (slots[index].soKhachDat < 4) {
                              //   slots[index].soKhachDat++;
                              //   time = slots[index].time;
                              //   print(slots[index].soKhachDat);
                              // }
                            });
                          },
                        );
                      },
                    ),
                  );
                }),
            Expanded(
                child: Text(
              time,
              style: TextStyle(color: Colors.red, fontSize: 30),
            )),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    updateDataFirebase();
                  });
                },
                child: Text('Đặt lich')),
          ],
        ));
  }
}

class Slot {
  String time;
  int soKhachDat;
  bool isSelected;

  Slot(this.time, this.soKhachDat);
}
