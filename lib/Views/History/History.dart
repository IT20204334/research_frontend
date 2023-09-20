import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/FirebaseStructure.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Views/Widgets/custom_date_selector.dart';

import '../Widgets/custom_button.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  _DiseasesState createState() => _DiseasesState();
}

class _DiseasesState extends State<History> {
  final double topSpace = displaySize.width * 0.4;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  List<dynamic> list = [];

  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  bool useFilters = false;

  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: color6,
      body: SizedBox(
          width: displaySize.width,
          height: displaySize.height,
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(color: color3),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: color6,
                            ),
                          ),
                          Text(
                            "History",
                            style: TextStyle(color: color6),
                          ),
                          GestureDetector(
                            onTap: () async {
                              getData();
                            },
                            child: Icon(
                              Icons.refresh,
                              color: color6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Filter",
                        style: TextStyle(fontSize: 16.0, color: color11),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CustomDateSelectorWithImage(
                            height: 5,
                            hint: 'From',
                            isIconAvailable: false,
                            icon_img: Icons.calendar_month,
                            backgroundColor: color6,
                            type:
                                CustomDateSelectorWithImage.DATE_TIME_SELECTOR,
                            onConfirm: (startDateTime) {
                              start = startDateTime;
                            }),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CustomDateSelectorWithImage(
                            height: 5,
                            hint: 'To',
                            isIconAvailable: false,
                            icon_img: Icons.calendar_month,
                            backgroundColor: color6,
                            type:
                                CustomDateSelectorWithImage.DATE_TIME_SELECTOR,
                            onConfirm: (endDateTime) {
                              end = endDateTime;
                            }),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(color6),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(color3),
                            ),
                            onPressed: () async {
                              useFilters = true;
                              getData();
                            },
                            child: const Text("Filter Records"),
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: color6,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: (isLoading)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ((list.isNotEmpty)
                              ? SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        for (var rec in list)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Card(
                                              child: ExpansionTile(
                                                title: Text(
                                                    rec['value']['status'],
                                                    style: TextStyle(
                                                        color: color11,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Text(
                                                      getDateTime(rec['value']
                                                          ['timestamp']),
                                                      style: TextStyle(
                                                          color: color11,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                                children: [
                                                  Image.network(
                                                    rec['value']['image'],
                                                    filterQuality:
                                                        FilterQuality.low,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      ]),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: displaySize.width * 0.4,
                                          child: Image.asset(empty),
                                        )),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Center(
                                      child: Text(
                                        "No Data Found",
                                        style: TextStyle(
                                            fontSize: 12.0, color: color11),
                                      ),
                                    ),
                                  ],
                                )),
                    ),
                  ))
            ],
          )),
    ));
  }

  Widget getActionIcon(color, icon, method) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          method();
        },
        child: Icon(
          icon,
          color: color,
          size: 18.0,
        ),
      ),
    );
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    _databaseReference
        .child(FirebaseStructure.HISTORY)
        .once()
        .then((DatabaseEvent data) {
      list.clear();
      for (DataSnapshot element in data.snapshot.children) {
        dynamic ele = element.value;
        if (useFilters == true && start != null && end != null) {
          DateTime currentDateTime =
              DateTime.fromMillisecondsSinceEpoch(ele['timestamp']);
          if (currentDateTime.isAfter(start) && currentDateTime.isBefore(end)) {
            list.add({'key': element.key, 'value': element.value});
          }
        } else {
          list.add({'key': element.key, 'value': element.value});
        }
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  String getDateTime(int mills) {
    return DateFormat('yyyy/MM/dd hh:mm a')
        .format(DateTime.fromMillisecondsSinceEpoch(mills));
  }

  Uint8List getImageString(String value) {
    return Uri.parse(value).data!.contentAsBytes();
  }
}
