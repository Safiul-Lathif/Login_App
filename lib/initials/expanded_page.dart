import 'dart:convert';
import 'dart:math';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/models/userListModel.dart';

class ExpandedPage extends StatefulWidget {
  const ExpandedPage({super.key});

  @override
  State<ExpandedPage> createState() => _ExpandedPageState();
}

class _ExpandedPageState extends State<ExpandedPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expanded Widget"),
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: Column(children: [
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) => ExpansionTile(
                    title: Text(
                      _list[index].firstName.toString() +
                          " " +
                          _list[index].lastName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Object exception, StackTrace? stackTrace) {
                              return CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                child: Text(
                                  _list[index].firstName![0].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                              // CircleAvatar(
                              //   backgroundImage:
                              //       NetworkImage(_list[index].avatar.toString()),
                              //   radius: 40,

                              //   onBackgroundImageError: ,
                              //   backgroundColor: Colors.primaries[
                              //       Random().nextInt(Colors.primaries.length)],
                              //   child: Text(
                              //     _list[index].firstName![0].toString(),
                              //     style: const TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 30,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                            })
                          ],
                        ),
                      ),
                    ],
                  )),
        )
      ])),
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
}
