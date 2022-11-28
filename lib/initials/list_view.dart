import 'package:flutter/material.dart';

import '../models/createData.dart';

class Update extends StatefulWidget {
  Todo todo;
  Update({Key? key, required this.todo}) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState(todo: this.todo);
}

class _UpdateState extends State<Update> {
  Todo todo;
  _UpdateState({required this.todo});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      titleController.text = todo.title!;
      descriptionController.text = todo.description!;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.pink.shade400,
        title: const Text(" User Info"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                onChanged: (data) {
                  todo.title = data;
                },
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (data) {
                  todo.description = data;
                },
                controller: descriptionController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Job'),
              ),
              const SizedBox(height: 20),
              Container(
                child: Center(
                    child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.pink.shade400,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, todo);
                  },
                  child: const Text("Create Data "),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
