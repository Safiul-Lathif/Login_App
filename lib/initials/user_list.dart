import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/initials/newpart.dart';
import 'package:login/models/userListModel.dart';
import 'package:http/http.dart' as http;

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});
  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  final List<UserList> _list = [];

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
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isweb = MediaQuery.of(context).size.width < 600;
        return Container(
          color: Color(0xff121212),
          child: ListView.builder(
              controller: scrollController,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < _list.length) {
                  return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                (_list[index].avatar.toString()),
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewPart(
                                                item: _list[users],
                                              )));
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _list[index].firstName.toString() +
                                        " " +
                                        _list[index].lastName.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _list[index].email.toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      )
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
        );
      });

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
