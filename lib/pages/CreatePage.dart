import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/initials/new_data.dart';
import 'package:login/models/createData.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

Future<CreateData?> _userInput(String name, String job) async {
  var response = await http.post(Uri.parse("https://reqres.in/api/users"),
      body: {"name": name, "job": job});
  var data = response.body;
  print(data);
  if (response.statusCode == 201) {
    final jsonResponse = jsonDecode(response.body);
    return CreateData.fromJson(jsonResponse);
  } else {
    return null;
  }
}

class _CreatePageState extends State<CreatePage> {
  List create = [];
  List Search = [];
  final Connectivity _connectivity = Connectivity();
  bool hideUI = false;
  @override
  void initState() {
    super.initState();
    setupList();
    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        setState(() {
          hideUI = false;
        });
      } else {
        setState(() {
          hideUI = true;
        });
      }
    });
  }

  addEmploye(String name, String job) {
    createModel = Create(name: name, job: job);
    create.add(createModel);
    itemCount.value = create.length;
    _nameController.clear();
    _jobController.clear();
  }

  removeEmploye(int index) {
    create.removeAt(index);
    itemCount.value = create.length;
  }

  String replace = '';
  String replac = '';
  CreateData? _user;
  bool isBlank = true;
  late SharedPreferences prefs;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  late Create createModel;
  var itemCount = 0.obs;

  // setupList() async {
  //   prefs = await SharedPreferences.getInstance();
  //   String StringList = prefs.getString('create');
  //   List CreateList = jsonDecode(StringList);
  //   for (var Create in CreateList) {
  //     setState(() {
  //       create.add(Create().fromJson(Create));
  //     });
  //   }
  // }
  setupList() async {
    prefs = await SharedPreferences.getInstance();

    List todoList = jsonDecode(prefs.getString('create')!);
    for (var todo in todoList) {
      setState(() {
        create.add(Create().fromJson(todo));
      });
    }
  }

  void saveList() {
    List items = create.map((e) => e.toJson()).toList();
    prefs.setString('create', jsonEncode(items));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.pink.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (val) {
              setState(() {
                Search = create
                    .where(
                        (element) => element.name.toLowerCase().contains(val))
                    .toList();
              });
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: "Search",
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        backgroundColor: Colors.pink.shade400,
      ),
      body: hideUI
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.network_check,
                      size: 74,
                    ),
                    Text("NO Internet connection")
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: _searchController.text.isEmpty
                            ? create.length
                            : Search.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                                  leading: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => SimpleDialog(
                                                  children: [
                                                    TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  create[index]
                                                                      .name),
                                                      onChanged: ((value) {
                                                        replace = value;
                                                      }),
                                                    ),
                                                    TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  create[index]
                                                                      .job),
                                                      onChanged: ((value) {
                                                        replac = value;
                                                      }),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            create[index].name =
                                                                replace;

                                                            create[index].job =
                                                                replac;

                                                            Navigator.pop(
                                                                context);
                                                            saveList();
                                                          });
                                                        },
                                                        child: Text("Update"))
                                                  ],
                                                ));
                                      },
                                      icon: Icon(Icons.edit)),
                                  title: Text(_searchController.text.isEmpty
                                      ? create[index].name
                                      : Search[index].name),
                                  subtitle: Text(_searchController.text.isEmpty
                                      ? create[index].job
                                      : Search[index].job),
                                  trailing: IconButton(
                                      onPressed: () {
                                        removeEmploye(index);
                                        saveList();
                                      },
                                      icon: Icon(Icons.delete))));
                        }),
                  ),

                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter name',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _jobController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Enter Job'),
                  ),
                  SizedBox(height: 20),

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
                  //   onPressed: () async {
                  //     // await _displaySnackBar(context, "Data Added Sucesfully!!!");
                  //     _newData =
                  //         await _userInput(_nameController.text, _jobController.text)
                  //             as Future<CreateData>?;
                  //   },
                  //   child: const Text(
                  //     'Create Data',
                  //   ),
                  // ),
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.pink.shade400,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          saveList();
                          final CreateData? user = await _userInput(
                              _nameController.text, _jobController.text);
                          setState(() {
                            _user = user;
                          });

                          addEmploye(_nameController.text, _jobController.text);
                          await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Data Added suessfully"),
                              content: SizedBox(
                                height: 100,
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name:  ${_user!.name}"),
                                    Text("Job: ${_user!.job}"),
                                    Text("Id: ${_user!.id}"),
                                    Text("Created At: ${_user!.createdAt}")
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
                        child: const Text("Create Data "),
                      ),
                    ),
                  ),

                  // Container(
                  //   child: ListView.builder(
                  //       itemCount: 1,
                  //       itemBuilder: (context, index) {
                  //         return Card(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [Text(""), Text("")],
                  //           ),
                  //         );

                  //       }),
                  // )
                ],
              ),
            ),
    );
  }
}
