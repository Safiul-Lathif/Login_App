import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isButtonActive = true;
  bool isButtonActive1 = true;
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  FilePickerResult? result;
  PlatformFile? pickedFile;
  late MaterialStatesController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = MaterialStatesController();
  //   controller.addListener(() {
  //     final isButtonActive = pickedFile!.path!.isEmpty;
  //     setState(() => this.isButtonActive = isButtonActive);
  //   });
  // }

  // @ov erride
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  Future openImages() async {
    final pickedfiles = await ImagePicker.platform.getMultiImage();
    //you can use ImageCourse.camera for Camera capture
    if (pickedfiles != null) {
      imagefiles = pickedfiles as List<XFile>?;
      setState(() {
        isButtonActive1 = false;
      });
    } else {}
  }

  Future _selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    } else {
      setState(() {
        pickedFile = result.files.first;

        isButtonActive = false;

        // if (pickedFile == null) {
        //   isButtonActive = true;
        // }
      });
    }
    // if (pickedFile == null) {
    //   isButtonActive = true;
    // } else {
    //   isButtonActive = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Image Uplode"),
          backgroundColor: Colors.pink.shade400,
        ),
        body: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                if (pickedFile != null)
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              // shape: BoxShape.rectangle,
                              image: DecorationImage(
                            image: FileImage(
                              File(pickedFile!.path!),
                            ),
                            //fit: BoxFit.fill
                          )),
                        ),
                        Text(pickedFile!.name),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                pickedFile = null;
                                isButtonActive = true;
                              });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                imagefiles != null
                    ? Wrap(
                        children: imagefiles!.map((e) {
                          return Container(
                              child: Card(
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      // shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                    image: FileImage(
                                      File(e.path),
                                    ),
                                    //fit: BoxFit.fill
                                  )),
                                ),
                                Expanded(
                                  child: Text(
                                    e.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        imagefiles!
                                            .removeAt(imagefiles!.indexOf(e));
                                      });
                                      if (imagefiles!.isEmpty) {
                                        isButtonActive1 = true;
                                      }
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          ));
                        }).toList(),
                      )
                    : Container(),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: isButtonActive ? _selectFile : null,
                      // statesController: controller,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        onSurface: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.file_upload,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Upload Single Image',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: SizedBox(
                  width: 270,
                  child: ElevatedButton(
                    onPressed: isButtonActive1 ? openImages : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      onSurface: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.file_upload,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Upload Multiple Image',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
