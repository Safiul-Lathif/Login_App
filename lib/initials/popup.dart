import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/initials/login.dart';

class Popup extends StatefulWidget {
  const Popup({super.key});

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade400,
      ),
      body: Container(),
    );
  }

  _showPopupMenu() async {
    // final deviceposition = buttonMenuPosition(context);
    //Offset offset= Offset(0, -380);
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 0, 0, 0),
      //  position: deviceposition,

      items: [
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
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
      ],
      elevation: 0,
    );
  }
}
