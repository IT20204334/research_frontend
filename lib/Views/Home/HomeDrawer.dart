import 'package:indoortracking/Controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Models/Utils/Routes.dart';
import 'package:indoortracking/Models/Utils/Utils.dart';
import 'package:indoortracking/Views/History/History.dart';
import 'package:indoortracking/Views/Live/live_prediction.dart';
import 'package:indoortracking/Views/ProductManagement/product_management.dart';
import 'package:indoortracking/Views/peoplecount/TrafficMap.dart';

class HomeDrawer extends StatefulWidget {
  int selection = 1;

  HomeDrawer({Key? key, required selection}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState(selection: selection);
}

class _HomeDrawerState extends State<HomeDrawer> {
  int selection;

  _HomeDrawerState({required this.selection});

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: displaySize.height * 0.15,
          decoration: CustomUtils.getGradientBackground(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: ClipOval(
                    child: Image.asset(
                      user_image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(CustomUtils.loggedInUser!.name
                            .toString()
                            .toUpperCase()),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          CustomUtils.loggedInUser!.email.toString(),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          CustomUtils.loggedInUser!.mobile.toString(),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        (CustomUtils.loggedInUser!.type == 1)
            ? ListTile(
                leading: Icon(
                  Icons.shop_outlined,
                  color: color11,
                ),
                onTap: () {
                  Routes(context: context).navigate(const ProductManagent());
                },
                title: const Text('Product Management'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: color11,
                  size: 15.0,
                ))
            : const SizedBox.shrink(),
        (CustomUtils.loggedInUser!.type == 2)
            ? ListTile(
                leading: Icon(
                  Icons.live_help_outlined,
                  color: color11,
                ),
                onTap: () {
                  Routes(context: context).navigate(const PredictionLive());
                },
                title: const Text('Upload Predictions'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: color11,
                  size: 15.0,
                ))
            : const SizedBox.shrink(),
        (CustomUtils.loggedInUser!.type == 2)
            ? ListTile(
                leading: Icon(
                  Icons.history_toggle_off_outlined,
                  color: color11,
                ),
                onTap: () {
                  Routes(context: context).navigate(const History());
                },
                title: const Text('Prediction History'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: color11,
                  size: 15.0,
                ))
            : const SizedBox.shrink(),
                ListTile(
            leading: Icon(
              Icons.logout,
              color: color11,
            ),
            onTap: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TrafficMap()));
            },
            title: const Text('Crowd Monitoring'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: color11,
              size: 15.0,
            )),
        ListTile(
            leading: Icon(
              Icons.logout,
              color: color11,
            ),
            onTap: () {
              AuthController().logout(context);
            },
            title: const Text('Logout'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: color11,
              size: 15.0,
            )),
      ],
    );
  }
}
