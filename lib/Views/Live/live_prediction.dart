import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/FirebaseStructure.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Models/Utils/Utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/custom_button.dart';

class PredictionLive extends StatefulWidget {

  const PredictionLive({Key? key}) : super(key: key);

  @override
  _DiseasesState createState() => _DiseasesState();
}

class _DiseasesState extends State<PredictionLive> {

  final double topSpace = displaySize.width * 0.4;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  final _imagePicker = ImagePicker();
  XFile? image;
  Uint8List? imageUInts;

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
                            "Prediction Enrollment",
                            style: TextStyle(color: color6),
                          ),
                          GestureDetector(
                            onTap: () async {},
                            child: Icon(
                              Icons.restore,
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
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: (imageUInts != null)
                              ? Image.memory(imageUInts!)
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        showChooserType();
                                      },
                                      child: Image.asset(defaultImg),
                                    ),
                                    Positioned(
                                        bottom: 50.0,
                                        child: Text('Click to upload an image'
                                            .toUpperCase()))
                                  ],
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: CustomButton(
                              buttonText: 'Upload for prediction'.toUpperCase(),
                              textColor: color6,
                              backgroundColor: color3,
                              isBorder: false,
                              borderColor: color6,
                              onclickFunction: () {
                                if (image != null) {
                                  uploadImage();
                                } else {
                                  CustomUtils.showSnackBarMessage(
                                      context,
                                      "Please select image first",
                                      CustomUtils.ERROR_SNACKBAR);
                                }
                              }),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    ));
  }

  uploadImage() async {
    CustomUtils.showLoader(context);
    final firebaseStorage = FirebaseStorage.instance;
    await Permission.photos.request();
    if (image != null) {
      var file = File(image!.path);
      if (image != null) {
        var snapshot = await firebaseStorage
            .ref()
            .child("${const Uuid().v1()}.png")
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        await _databaseReference.child(FirebaseStructure.LIVEIMAGE).set({
          'status': true,
          'image': downloadUrl,
        });
        CustomUtils.hideLoader(context);
        setState(() {
          image = null;
          imageUInts = null;
        });
      } else {
        print('No Image Path Received');
      }
    }
  }

  Future<void> showChooserType() async {
    await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
              width: displaySize.width,
              child: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(color: color6),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _imagePicker
                                  .pickImage(source: ImageSource.camera)
                                  .then((value) async {
                                if (value != null) {
                                  imageUInts = await value.readAsBytes();
                                  setState(() {
                                    image = value;
                                  });
                                }
                              });
                            },
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.vertical,
                              children: [
                                Icon(
                                  Icons.camera,
                                  color: color11,
                                ),
                                const Text('Camera')
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _imagePicker
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) async {
                                if (value != null) {
                                  imageUInts = await value.readAsBytes();
                                  setState(() {
                                    image = value;
                                  });
                                }
                              });
                            },
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.vertical,
                              children: [
                                Icon(
                                  Icons.photo,
                                  color: color11,
                                ),
                                const Text('Gallery')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

}
