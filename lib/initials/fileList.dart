import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileList extends StatefulWidget {
  const FileList({super.key, required this.files, required this.onOpenedFile});
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  @override
  State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
