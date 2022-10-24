import 'dart:convert';
import 'package:login/initials/expanded_page.dart';
import 'package:login/initials/login.dart';
import 'package:login/models/userListModel.dart';
import 'package:login/initials/CreatePage.dart';
import 'package:login/initials/NewPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserList> _list = [];
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("List of Users"),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreatePage()));
                  },
                  icon: Icon(Icons.add)),
              TextButton(
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text("Logout"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpandedPage()));
                  },
                  child: Icon(Icons.list))
            ]),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _list.length) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewPage(
                                              item: _list[index],
                                            )));
                              },
                              child: Card(
                                child: Row(
                                  children: [
                                    Image.network(
                                        (_list[index].avatar.toString())),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _list[index].firstName.toString() +
                                              " " +
                                              _list[index].lastName.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(_list[index].email.toString()),
                                        SizedBox(
                                          height: 80,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                // child: ListTile(
                                //   leading: Image.network(
                                //     (_list[index].avatar.toString()),
                                //   ),
                                //   title: Text(
                                //     _list[index].firstName.toString() +
                                //         " " +
                                //         _list[index].lastName.toString(),
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.bold, fontSize: 15),
                                //   ),
                                //   subtitle: Text(_list[index].email.toString()),
                                // ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              //     backgroundColor: MaterialStateProperty.all<Color>(
              //       Colors.black87,
              //     ),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => CreatePage()));
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
              //     child: Text(
              //       'Create ',
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
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
}
