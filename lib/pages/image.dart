import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:open_file/open_file.dart';

class Image extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const Image({super.key, required this.files, required this.onOpenedFile});

  @override
  State<Image> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<Image> {
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
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) {
      return;
    } else {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Uplode"),
        backgroundColor: Colors.pink.shade400,
        actions: [IconButton(onPressed: _pickedFile, icon: Icon(Icons.upload))],
      ),
      body: ListView.builder(
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final files = widget.files[index];
            return _build(files);
          }),
    );

    // child: Container(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: <Widget>[
    //         if (pickedFile != null)
    //           Center(
    //             child: Container(
    //               height: 150,
    //               width: 150,
    //               decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   image: DecorationImage(
    //                     image: FileImage(
    //                       File(pickedFile!.path!),
    //                     ),
    //                     // fit: BoxFit.fill
    //                   )),
    //             ),
    //           ),
    //         // SizedBox(
    //         //   height: MediaQuery.of(context).size.height,
    //         // ),
    //         Center(
    //           child: SizedBox(
    //             width: 250,
    //             child: ElevatedButton(
    //               onPressed: _pickedFile,
    //               style: ButtonStyle(
    //                 foregroundColor: MaterialStateProperty.all<Color>(
    //                     Colors.pink.shade400),
    //                 backgroundColor: MaterialStateProperty.all<Color>(
    //                     Colors.pink.shade400),
    //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                   RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(24.0),
    //                   ),
    //                 ),
    //               ),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(18.0),
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.file_upload,
    //                       color: Colors.white,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text(
    //                       'Upload Single Image',
    //                       style: TextStyle(fontSize: 16, color: Colors.white),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Center(
    //           child: SizedBox(
    //             width: 270,
    //             child: ElevatedButton(
    //               onPressed: _selectFile1,
    //               style: ButtonStyle(
    //                 foregroundColor: MaterialStateProperty.all<Color>(
    //                     Colors.pink.shade400),
    //                 backgroundColor: MaterialStateProperty.all<Color>(
    //                     Colors.pink.shade400),
    //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                   RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(24.0),
    //                   ),
    //                 ),
    //               ),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(18.0),
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.file_upload,
    //                       color: Colors.white,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text(
    //                       'Upload Multiple Image',
    //                       style: TextStyle(fontSize: 16, color: Colors.white),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         )
    //       ],
    //     ),
    //   ),
    // );;,
  }

  Widget _build(PlatformFile file) {
    return ListTile(
      title: Text(file.name),
    );
  }

  void _pickedFile() async {
    result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;

    loadselectedFie(result!.files);
  }

  void loadselectedFie(List<PlatformFile> files) {
    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => FileList(files: files, onOpenedFile: viewFile)));
  }

  // void viewFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }
}
