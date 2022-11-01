import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  FilePickerResult? result;
  PlatformFile? pickedFile;

  Future _selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    } else {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  Future _selectFile1() async {
    final pickedfiles =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    //you can use ImageCourse.camera for Camera capture
    if (pickedfiles != null) {
      imagefiles = pickedfiles as List<XFile>?;
      setState(() {});
    } else {}
  }

  // Future _selectFile1() async {
  //   final results = await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if (results != null) {
  //     pickedFiles = results as List<XFile>?;
  //     setState(() {});
  //   } else {
  //     print("No Image Is Selected");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Uplode"),
        backgroundColor: Colors.pink.shade400,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              if (pickedFile != null)
                Row(
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
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                  ],
                ),
              SizedBox(
                height: 10,
              ),
              imagefiles != null
                  ? Wrap(
                      children: imagefiles!.map((e) {
                        return Container(
                            child: Card(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.file(File(e.path)),
                          ),
                        ));
                      }).toList(),
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),

              // Center(
              //   child: Container(
              //     height: 150,
              //     width: 150,
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         image: DecorationImage(
              //           image: FileImage(
              //             File(pickedFiles!.path!),
              //           ),
              //           // fit: BoxFit.fill
              //         )),
              //   ),
              // ),
              // if (pickedFiles == null)
              // ListView.builder(
              //     //controller: scrollController,
              //     itemCount: result!.files.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       if (index < result!.files.length) {
              //         return Center(
              //           child: Container(
              //               // height: 150,
              //               // width: 150,
              //               // decoration: BoxDecoration(
              //               //     shape: BoxShape.circle,
              //               //     image: DecorationImage(
              //               //       image: FileImage(
              //               //         File(pickedFiles!.path!),
              //               //       ),
              //               //       // fit: BoxFit.fill
              //               //     )),
              //               ),
              //         );
              //       } else {
              //         return const Padding(
              //           padding: EdgeInsets.symmetric(vertical: 32),
              //           child: Center(
              //             child: CircularProgressIndicator(),
              //           ),
              //         );
              //       }
              //     }),

              // Center(
              //   child: Container(
              //     height: 150,
              //     width: 150,
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         image: DecorationImage(
              //           image: FileImage(
              //             File(pickedFiles!.path!),
              //           ),
              //           // fit: BoxFit.fill
              //         )),
              //   ),
              //),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height,
              // ),
              Center(
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: _selectFile,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.pink.shade400),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.pink.shade400),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
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
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                    onPressed: _selectFile1,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.pink.shade400),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.pink.shade400),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
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
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
