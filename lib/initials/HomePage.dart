import 'dart:convert';
import 'package:login/initials/expanded_page.dart';
import 'package:login/initials/grid_page.dart';
import 'package:login/initials/image_picker.dart';
import 'package:login/initials/login.dart';
import 'package:login/initials/newpart.dart';
import 'package:login/initials/uplode_image.dart';
import 'package:login/initials/user_list.dart';
import 'package:login/models/userListModel.dart';
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
                ? OrientationBuilder(builder: (context, orientation) {
                    final isweb = MediaQuery.of(context).size.width < 750;
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
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 20, right: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewPart(
                                                          item: _list[index],
                                                        )));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                _list[index]
                                                        .firstName
                                                        .toString() +
                                                    " " +
                                                    _list[index]
                                                        .lastName
                                                        .toString(),
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
                                                    fontSize: 12,
                                                    color: Colors.white70),
                                              ),
                                            ],
                                          ),
                                        )
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
                  })
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
