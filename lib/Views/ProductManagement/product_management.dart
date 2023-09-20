import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validation/form_validation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoortracking/Views/Widgets/custom_text_form_field.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/FirebaseStructure.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Models/Utils/Utils.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/custom_button.dart';

class ProductManagent extends StatefulWidget {
  const ProductManagent({Key? key}) : super(key: key);

  @override
  _DiseasesState createState() => _DiseasesState();
}

class _DiseasesState extends State<ProductManagent> {
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
                            "Product Management",
                            style: TextStyle(color: color6),
                          ),
                          GestureDetector(
                            onTap: () async {
                              showEnrollment(null, null);
                            },
                            child: Icon(
                              Icons.add,
                              color: color6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
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
                                              child: ListTile(
                                                title: Text(
                                                    rec['value']['name'],
                                                    style: TextStyle(
                                                        color: color11,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                subtitle: Text(
                                                    "LKR ${int.parse(rec['value']['price']).toStringAsFixed(2)}",
                                                    style: TextStyle(
                                                        color: color11,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    getActionIcon(
                                                        color13, Icons.edit,
                                                        () {
                                                      showEnrollment(rec['key'],
                                                          rec['value']);
                                                    }),
                                                    getActionIcon(
                                                        color13, Icons.delete,
                                                        () {
                                                      _databaseReference
                                                          .child(
                                                              FirebaseStructure
                                                                  .PRODUCTS)
                                                          .child(rec['key'])
                                                          .remove()
                                                          .then((value) {
                                                        getData();
                                                      });
                                                    })
                                                  ],
                                                ),
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
        .child(FirebaseStructure.PRODUCTS)
        .once()
        .then((DatabaseEvent data) {
      list.clear();
      for (DataSnapshot element in data.snapshot.children) {
        list.add({'key': element.key, 'value': element.value});
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  Uint8List getImageString(String value) {
    return Uri.parse(value).data!.contentAsBytes();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> showEnrollment(key, dynamic savedRecord) async {
    TextEditingController _name = TextEditingController();
    TextEditingController _description = TextEditingController();
    TextEditingController _price = TextEditingController();

    final _imagePicker = ImagePicker();
    XFile? image;
    Uint8List? imageUInts;

    final firebaseStorage = FirebaseStorage.instance;

    if (savedRecord != null) {
      _name.text = savedRecord['name'];
      _description.text = savedRecord['description'];
      _price.text = savedRecord['price'];
    }

    await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
              width: displaySize.width,
              child: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(color: color3),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh,
                            color: color3,
                          ),
                          Text(
                            "Manage Products",
                            style: TextStyle(fontSize: 15.0, color: color6),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: color6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: GestureDetector(
                                onTap: () async {
                                  await _imagePicker
                                      .pickImage(source: ImageSource.gallery)
                                      .then((value) async {
                                    if (value != null) {
                                      image = value;
                                      await image!
                                          .readAsBytes()
                                          .then((value) => imageUInts = value);
                                    }
                                  });
                                  setState(() {});
                                },
                                child: SizedBox(
                                  height: displaySize.width * 0.4,
                                  child: (imageUInts != null &&
                                          imageUInts!.isNotEmpty)
                                      ? Image.memory(imageUInts!)
                                      : (savedRecord != null)
                                          ? Image.network(savedRecord['image'])
                                          : Image.asset(defaultImg),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: CustomTextFormField(
                                  height: 5.0,
                                  controller: _name,
                                  backgroundColor: color7,
                                  iconColor: color3,
                                  isIconAvailable: true,
                                  hint: 'Name',
                                  icon: Icons.shop_outlined,
                                  textInputType: TextInputType.text,
                                  validation: (value) {
                                    final validator = Validator(
                                      validators: [const RequiredValidator()],
                                    );
                                    return validator.validate(
                                      label: 'Invalid Name',
                                      value: value,
                                    );
                                  },
                                  obscureText: false),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: CustomTextFormField(
                                  height: 5.0,
                                  controller: _description,
                                  backgroundColor: color7,
                                  iconColor: color3,
                                  isIconAvailable: true,
                                  hint: 'Description',
                                  icon: Icons.abc,
                                  textInputType: TextInputType.multiline,
                                  validation: (value) {
                                    final validator = Validator(
                                      validators: [const RequiredValidator()],
                                    );
                                    return validator.validate(
                                      label: 'Invalid Description',
                                      value: value,
                                    );
                                  },
                                  obscureText: false),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: CustomTextFormField(
                                  height: 5.0,
                                  controller: _price,
                                  backgroundColor: color7,
                                  iconColor: color3,
                                  isIconAvailable: true,
                                  hint: 'Price',
                                  icon: Icons.money,
                                  textInputType: TextInputType.number,
                                  validation: (value) {
                                    final validator = Validator(
                                      validators: [const RequiredValidator()],
                                    );
                                    return validator.validate(
                                      label: 'Invalid Price',
                                      value: value,
                                    );
                                  },
                                  obscureText: false),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45.0, vertical: 20.0),
                              child: CustomButton(
                                  buttonText: "Submit",
                                  textColor: color6,
                                  backgroundColor: color3,
                                  isBorder: false,
                                  borderColor: color6,
                                  onclickFunction: () async {
                                    FocusScope.of(context).unfocus();
                                    CustomUtils.showLoader(context);
                                    DatabaseReference ref = _databaseReference
                                        .child(FirebaseStructure.PRODUCTS);
                                    dynamic data = {
                                      'name': _name.text,
                                      'price': _price.text,
                                      'description': _description.text,
                                    };

                                    if (savedRecord == null &&
                                        imageUInts == null &&
                                        imageUInts!.isEmpty) {
                                      CustomUtils.showToast(
                                          "Please select image first");
                                      return;
                                    }

                                    if (imageUInts != null &&
                                        imageUInts!.isNotEmpty) {
                                      var file = File(image!.path);
                                      var snapshot = await firebaseStorage
                                          .ref()
                                          .child("${const Uuid().v1()}.png")
                                          .putFile(file);
                                      var downloadUrl =
                                          await snapshot.ref.getDownloadURL();

                                      data['image'] = downloadUrl;
                                    }

                                    if (savedRecord != null) {
                                      await ref.child(key).update(data);
                                    } else {
                                      await ref.push().set(data);
                                    }
                                    CustomUtils.hideLoader(context);
                                    Navigator.pop(context);
                                  }),
                            ),
                          ],
                        )),
                  )
                ],
              ));
        }).then((value) => getData());
  }

  String getUserPriviledge(int type) {
    return ['Administrator', 'Farmer', 'Supervisor'][type - 1];
  }

  getColors(int type) {
    return [color3, color11, color12][type - 1];
  }
}
