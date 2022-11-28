import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:login/initials/login.dart';
import 'package:login/initials/multipl.dart';
import 'package:login/initials/popup.dart';

import 'package:login/models/modelPage.dart';
import 'package:login/pages/CreatePage.dart';
import 'package:login/pages/HomePage.dart';
import 'package:login/pages/list.dart';
import 'package:login/pages/uplode_image.dart';
import 'package:login/pages/worker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/grid_page.dart';
import '../pages/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 2;
  final screens = [
    page23(),
    ImagePicker(),
    HomePage(),
    UplodeImage(),
    GridPage()
  ];
  final items = <Widget>[
    Icon(
      Icons.create,
      size: 30,
    ),
    Icon(
      Icons.image,
      size: 30,
    ),
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.list,
      size: 30,
    ),
    Icon(
      Icons.grid_3x3,
      size: 30,
    )
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        // backgroundColor: Colors.transparent,
        height: 50,
        index: 2,
        items: items,
        onTap: (index) => setState(() => this.index = index),
        //     (index) {
        //   if (index == 0) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => CreatePage()),
        //     );
        //   } else if (index == 1) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => HomePage()),
        //     );
        //   } else if (index == 2) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ImagePicker()),
        //     );
        //   } else {
        //     _showPopupMenu();
        //   }
        // },
      ));

  _showPopupMenu() async {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 550, 0, 100),
      items: [
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Popup()));
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.lock_outline),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Change Password",
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Popup()));
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.settings),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Settings",
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.logout),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Logout ",
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
      elevation: 0,
    );
  }
}
