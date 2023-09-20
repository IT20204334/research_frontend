import 'package:flutter/material.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';

class ProductMap extends StatefulWidget {
  dynamic data;

  ProductMap({Key? key, required this.data}) : super(key: key);

  @override
  _DiseasesState createState() => _DiseasesState(data: data);
}

class _DiseasesState extends State<ProductMap> {
  final double topSpace = displaySize.width * 0.4;

  dynamic data;

  _DiseasesState({required this.data});

  double xrate = (displaySize.width / 50);
  double yrate = (displaySize.height * 0.8 / 50);

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
                            "Product Map",
                            style: TextStyle(color: color6),
                          ),
                          const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: (displaySize.width),
                      height: (displaySize.height * 0.85),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: (displaySize.width),
                            height: (displaySize.height * 0.85),
                            child: Image.network(
                              'https://i.pinimg.com/originals/37/03/b5/3703b5f85adf34f1b859e8d63b12e87b.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                              bottom: ((data['x'] ?? 0) * yrate),
                              left: ((data['y'] ?? 0) * xrate),
                              child: Icon(
                                Icons.location_on,
                                color: color3,
                                size: 40.0,
                              ))
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    ));
  }
}
