import 'package:flutter/material.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/Routes.dart';
import 'package:indoortracking/Views/ProductManagement/productmap.dart';


class ProductView extends StatefulWidget {
  dynamic data;

  ProductView({Key? key, required this.data}) : super(key: key);

  @override
  _DiseasesState createState() => _DiseasesState(data: data);
}

class _DiseasesState extends State<ProductView> {
  final double topSpace = displaySize.width * 0.4;

  dynamic data;

  _DiseasesState({required this.data});

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
                            "Product View",
                            style: TextStyle(color: color6),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Routes(context: context)
                                            .navigate(ProductMap(data: data));
                            },
                            child: Icon(
                              Icons.pix_outlined,
                              color: color6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: displaySize.width * 0.5,
                          child: Image.network(
                            data['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(data['name'],
                                  style: TextStyle(
                                      color: colorDarkBg,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                  "LKR ${int.parse(data['price']).toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: color3,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(data['description'],
                                  style: TextStyle(
                                      color: color8,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    ));
  }
}
