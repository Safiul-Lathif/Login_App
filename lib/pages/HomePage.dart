import 'dart:convert';
import 'package:login/initials/login.dart';
import 'package:login/initials/newpart.dart';

import 'package:login/initials/user_list.dart';
import 'package:login/models/userListModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CreatePage.dart';
import 'expanded_page.dart';
import 'uplode_image.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserList> _list = [];

  int page = 1;

  ScrollController scrollController = ScrollController();

  int users = 1;

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

  late UserList item;

  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isweb = MediaQuery.of(context).size.width < 700;
        return Scaffold(
            appBar: AppBar(
                title: Text("List of Users"),
                backgroundColor: Colors.pink.shade400,
                actions: []),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.pink.shade400,
                    ),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://i.ytimg.com/vi/USb2tN1Yq18/maxresdefault.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Log out '),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.expand,
                    ),
                    title: const Text('Expanded View '),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpandedPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.create,
                    ),
                    title: const Text('CRUD '),
                    onTap: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.expand,
                    ),
                    title: const Text('Uplode Image'),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UplodeImage()));
                    },
                  ),
                ],
              ),
            ),
            body: isweb
                ? UserListWidget()
                : Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: UserListWidget(),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: NewPart(item: _list[users])),
                    ],
                  ));
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
