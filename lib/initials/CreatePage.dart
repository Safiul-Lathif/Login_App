import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl_browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/createData.dart';

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
  final Connectivity _connectivity = Connectivity();
  bool hideUI = false;
  @override
  void initState() {
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
    super.initState();
  }

  CreateData? _user;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Data"),
        backgroundColor: Colors.black,
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
                          Colors.black87,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final CreateData? user = await _userInput(
                            _nameController.text, _jobController.text);
                        setState(() {
                          _user = user;
                        });
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
                                  color: Colors.black,
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
                  ))
                ],
              ),
            ),
    );
  }
}
