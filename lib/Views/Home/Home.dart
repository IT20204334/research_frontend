import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/FirebaseStructure.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Models/Utils/Routes.dart';
import 'package:indoortracking/Views/Home/HomeDrawer.dart';
import 'package:indoortracking/Views/ProductManagement/productview.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int count = 0;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  List<dynamic> products = [];

  @override
  void initState() {
    getLiveData();
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: color6,
      drawer: Drawer(
        child: HomeDrawer(
          selection: 1,
        ),
      ),
      body: SizedBox(
          width: displaySize.width,
          height: displaySize.height,
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color7,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_scaffoldKey.currentState!.hasDrawer &&
                                  _scaffoldKey.currentState!.isEndDrawerOpen) {
                                _scaffoldKey.currentState!.openEndDrawer();
                              } else {
                                _scaffoldKey.currentState!.openDrawer();
                              }
                            },
                            child: Icon(
                              Icons.menu,
                              color: color3,
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                            child: Image.asset(logoOnly),
                          ),
                          const SizedBox.shrink()
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // Expanded(
                      //     flex: 0,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(5.0),
                      //       child: Container(
                      //         width: double.infinity,
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 15.0, horizontal: 10.0),
                      //         decoration: BoxDecoration(
                      //             border: Border.all(color: color3)),
                      // child: Wrap(
                      //   alignment: WrapAlignment.start,
                      //   direction: Axis.vertical,
                      //   children: [
                      //     Text('Hashini',
                      //         style: TextStyle(
                      //             color: color11,
                      //             fontSize: 14.0,
                      //             fontWeight: FontWeight.w600)),
                      //     Text('Total person count of supermarket',
                      //         style: TextStyle(
                      //             color: color11,
                      //             fontSize: 12.0,
                      //             fontWeight: FontWeight.w600)),
                      //     Text('$count',
                      //         style: TextStyle(
                      //             color: color3,
                      //             fontSize: 40.0,
                      //             fontWeight: FontWeight.w600))
                      //   ],
                      // ),
                      //   ),
                      // )),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 45.0, horizontal: 10.0),
                                child: GridView.builder(
                                  itemCount: products.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Routes(context: context)
                                            .navigate(ProductView(
                                          data: products[index],
                                        ));
                                      },
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.network(
                                            products[index]['image'],
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                              bottom: 5.0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: colorDarkBg
                                                        .withOpacity(0.8)),
                                                child: Text(
                                                    products[index]['name'],
                                                    style: TextStyle(
                                                        color: color9,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ))
                    ],
                  ))
            ],
          )),
    ));
  }

  List<String> getTips() {
    return [];
  }

  void getLiveData() {
    count = 0;
    _databaseReference
        .child(FirebaseStructure.CAMERACOUNT)
        .onValue
        .listen((event) {
      print(event.snapshot.value);
      if (event.snapshot.exists) {
        setState(() {
          count = event.snapshot.value as int;
        });
      }
    });
  }

  void getProducts() {
    products.clear();
    _databaseReference
        .child(FirebaseStructure.PRODUCTS)
        .once()
        .then((DatabaseEvent value) {
      setState(() {
        value.snapshot.children.forEach((DataSnapshot element) {
          dynamic data = element.value;
          data['key'] = element.key;
          products.add(data);
        });
      });
    });
  }
}
