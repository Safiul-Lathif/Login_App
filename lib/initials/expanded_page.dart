import 'dart:convert';
import 'dart:math';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/initials/HomePage.dart';
import 'package:login/models/userListModel.dart';

class ExpandedPage extends StatefulWidget {
  const ExpandedPage({super.key});

  @override
  State<ExpandedPage> createState() => _ExpandedPageState();
}

class _ExpandedPageState extends State<ExpandedPage> {
  List<UserList> _list = [];
  final selectedIndexes = [];
  UserList? _user;
  bool valuefirst = false;
  int page = 1;
  ScrollController scrollController = ScrollController();
  int users = 0;

  @override
  void initState() {
    super.initState();
    userData(users);
    _handleNext();
  }

  void _handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        userData(users);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Expanded Widget"),
            SizedBox(
              width: 10,
            ),
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: valuefirst,
                onChanged: (bool? value) {
                  setState(() {
                    valuefirst = !valuefirst;
                    if (valuefirst) {
                      selectedIndexes.addAll(_list);
                    } else {
                      selectedIndexes.clear();
                    }
                  });
                },
              ),
            ),
            // SizedBox(
            //   width: 100,
            // ),
            // IconButton(onPressed: () {}, icon: Icon(Icons.delete))
          ],
        ),
        backgroundColor: Colors.pink.shade400,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) => ExpansionTile(
                      title: Row(
                        children: [
                          Checkbox(
                              value: !valuefirst
                                  ? selectedIndexes.contains(index)
                                  : true,
                              onChanged: valuefirst
                                  ? (bool? value) {
                                      setState(() {
                                        if (selectedIndexes.contains(index)) {
                                          selectedIndexes.remove(index);
                                        } else {
                                          // selectedIndexes.add(index);
                                        }
                                      });
                                    }
                                  : (bool? value) {
                                      setState(() {
                                        if (selectedIndexes.contains(index)) {
                                          selectedIndexes.remove(index);
                                        } else {
                                          selectedIndexes.add(index);
                                        }
                                      });
                                    }),
                          // Checkbox(
                          //   value: selectedIndexes.contains(index),
                          //   onChanged: (bool? value) {
                          //     if (selectedIndexes.contains(index)) {
                          //       selectedIndexes.remove(index);
                          //     } else {
                          //       selectedIndexes.add(index);
                          //     }

                          //     // if(selectedIndexes(index) {
                          //     //    selectedIndexes.remove(index); // unselect
                          //     // });
                          //     // else {
                          //     //   selectedIndexes.add(index);  // select
                          //     // }
                          //     setState(() {});
                          //   },

                          //   // checkColor: Colors.greenAccent,
                          //   // activeColor: Colors.black,
                          // ),
                          // Checkbox(
                          //     value: _isChecked,
                          //     onChanged: (val) {
                          //       setState(() {
                          //         _isChecked = val!;
                          //         // if (val == true) {}

                          //       });
                          //     }),
                          Text(
                            _list[index].firstName.toString() +
                                " " +
                                _list[index].lastName.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _list[index].email.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "First Name :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(_list[index].firstName.toString()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Last Name :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(_list[index].lastName.toString()),
                                    ],
                                  ),
                                ],
                              ),
                              Image.network(_list[index].avatar.toString(),
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                return CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  child: Text(
                                    _list[index].firstName![0].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              })
                            ], //
                          ),
                        ),
                      ],
                    )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SizedBox(
                child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.pink.shade400,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext ctx) => AlertDialog(
                          title: const Text("Data Deleted suessfully"),
                          content: SizedBox(
                            height: 150,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    " Total ${selectedIndexes.length} items deleted"),
                                Text(" ${selectedIndexes} These Items deleted"),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                color: Colors.pink.shade400,
                                padding: const EdgeInsets.all(14),
                                child: const Text(
                                  "okay",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Delete(${selectedIndexes.length})",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ))),
          )
        ]),
      ),
    );
  }

  Future<List<UserList>?> userData(users) async {
    var response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$page'),
    );
    if (response.statusCode == 200) {
      // print(json.decode(response.body)["data"]);
      var result = jsonDecode(response.body)['data'] as List;
      List<UserList> tagObjs =
          result.map((tagJson) => UserList.fromJson(tagJson)).toList();
      setState(() {
        page++;
        _list.addAll(tagObjs);
        users = users + 2;
      });
      // print(tagObjs);
      return tagObjs;
    } else {
      return null;
    }
  }

  Future<UserList?> deleteData() async {
    var response =
        await http.delete(Uri.parse('https://reqres.in/api/users?page=$page'));
    var data = response.body;
    print(data);
    if (response.statusCode == 204) {
      final jsonResponse = jsonDecode(response.body);
      return UserList.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
