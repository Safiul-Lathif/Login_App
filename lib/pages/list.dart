import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login/models/createData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../initials/list_view.dart';

class page23 extends StatefulWidget {
  page23({Key? key}) : super(key: key);

  @override
  _page23State createState() => _page23State();
}

class _page23State extends State<page23> {
  late SharedPreferences prefs;
  List create = [];
  List Search = [];
  final TextEditingController _searchController = TextEditingController();
  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    List todoList = jsonDecode(stringTodo!);
    for (var todo in todoList) {
      setState(() {
        create.add(Todo().fromJson(todo));
      });
    }
  }

  void saveTodo() {
    List items = create.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(child: const Text("ListView")),
        backgroundColor: Colors.pink.shade400,
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: create.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                elevation: 8.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: makeListTile(create[index], index),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addTodo();
        },
      ),
    );
  }

  addTodo() async {
    int id = Random().nextInt(30);
    Todo t = Todo(id: id, title: '', description: '', status: false);
    Todo returnTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Update(todo: t)));
    if (returnTodo != null) {
      setState(() {
        create.add(returnTodo);
      });
      saveTodo();
    }
  }

  makeListTile(Todo todo, index) {
    return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: CircleAvatar(
              child: IconButton(
                  onPressed: () async {
                    Todo t = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Update(todo: create[index])));
                    if (t != null) {
                      setState(() {
                        create[index] = t;
                      });
                      saveTodo();
                    }
                  },
                  icon: const Icon(Icons.edit))),
        ),
        title: Row(
          children: [
            Text(
              todo.title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            todo.status!
                ? const Icon(
                    Icons.verified,
                    color: Colors.greenAccent,
                  )
                : Container()
          ],
        ),
        subtitle: Wrap(
          children: <Widget>[
            Text(
              todo.description!,
              overflow: TextOverflow.clip,
              maxLines: 1,
            )
          ],
        ),
        trailing: InkWell(
            onTap: () {
              setState(() {
                create.remove(todo);
              });
            },
            child: const Icon(Icons.delete, size: 30.0)));
  }
}
