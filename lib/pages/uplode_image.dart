import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

import 'HomePage.dart';

class UplodeImage extends StatefulWidget {
  const UplodeImage({super.key});

  @override
  State<UplodeImage> createState() => _UplodeImageState();
}

class _UplodeImageState extends State<UplodeImage> {
  static final notification = FlutterLocalNotificationsPlugin();

  static Future init({bool sheduled = false}) async {
    var initAndroidSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: initAndroidSettings);
    await notification.initialize(settings);
  }

  static Future showNotification({
    var id = 0,
    var title,
    var body,
    var playload,
  }) async =>
      notification.show(id, title, body, await notificationDetails());
  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel  name',
          importance: Importance.max),
    );
  }

  final songUrl =
      'https://mp3teluguwap.net/mp3/2022/Ponniyan%20Selvan/Ponniyan%20Selvan/Ponni%20Nadhi.mp3';
  bool downloading = false;
  var progressString = "";

  Future<void> DownloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(songUrl, "${dir.path}/MySong.mp3",
          onReceiveProgress: (rec, total) {
        var persentage = rec / total * 100;

        setState(() {
          progressString = persentage.toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {}
    setState(() {
      downloading = false;
      progressString = "Compleated";
      _displaySnackBar(context);
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downlode Item"),
        backgroundColor: Colors.pink.shade400,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(Icons.arrow_back))
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Ponni Nathi.mp3",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text("Click Here To download"),
              SizedBox(
                height: 20,
              ),
              Text("$progressString"),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      downloading = true;
                    });
                    downloading
                        ? await showDialog(
                            context: context,
                            builder: (
                              context,
                            ) {
                              String contentText = "Content of Dialog";
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  setState(() {
                                    downloading = true;
                                    DownloadFile();
                                    showNotification(
                                        title: "Ponni Nadhi Parkanume .mp3",
                                        body:
                                            " File Downloading:$progressString");
                                  });
                                  return AlertDialog(
                                    title: Text(
                                      "File Downloading : $progressString",
                                      style: TextStyle(
                                          color: Colors.pink, fontSize: 15),
                                    ),
                                    actions: <Widget>[
                                      new TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          color: Colors.pink.shade400,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text(
                                            "okay",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : showDialog(
                            context: context,
                            builder: (BuildContext ctx) => (AlertDialog(
                              title: Text(
                                "Downloading file : $progressString",
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 15),
                              ),
                              content: SizedBox(
                                height: 0,
                                width: 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            )),
                          );
                  },
                  child: Text("download file ")),
              // SizedBox(
              //   height: 40,
              // ),
              // Center(
              //   child: downloading
              //       ? Container(
              //           height: 50,
              //           width: 200,
              //           child: Card(
              //             color: Colors.pink,
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   "Downloading file : $progressString",
              //                   style: TextStyle(color: Colors.white),
              //                 )
              //               ],
              //             ),
              //           ),
              //         )
              //       : Container(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(" File Downloaded Scuessfully"),
      ),
    );
  }
}
