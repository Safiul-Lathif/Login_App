import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/models/userListModel.dart';

class NewPart extends StatefulWidget {
  NewPart({required this.item, super.key});
  final UserList item;
  @override
  State<NewPart> createState() => _NewPartState();
}

class _NewPartState extends State<NewPart> {
  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isweb = MediaQuery.of(context).size.width > 900;
        return isweb
            ? Scaffold(
                body: Container(
                color: Color(0xff121212),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Image.network(
                            (widget.item.avatar.toString()),
                            width: MediaQuery.of(context).size.width * 0.4,
                            // height:
                            //     MediaQuery.of(context).size.height * 0.6,

                            fit: BoxFit.fill,
                            //height: MediaQuery.of(context).size.height,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "First Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.item.firstName.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Last Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(widget.item.lastName.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white70,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Email :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.item.email.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Unique ID :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.item.id.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
            : Scaffold(
                appBar: AppBar(
                  // title: Text(" Detail Page"),
                  backgroundColor: Colors.pink.shade400,
                  elevation: 0,

                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                ),
                body: Container(
                  color: Color(0xff121212),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Image.network(
                              (widget.item.avatar.toString()),
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                              //height: MediaQuery.of(context).size.height,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "First Name :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.item.firstName.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Last Name :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(widget.item.lastName.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white70,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Email :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.item.email.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Unique ID :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.item.id.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 240,
                        ),
                      ],
                    ),
                  ),
                ));
      });
}
