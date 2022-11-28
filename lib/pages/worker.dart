import 'package:flutter/material.dart';
import 'package:login/manager/dbmanager.dart';

class WorkersList extends StatefulWidget {
  const WorkersList({super.key});

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  final DbWorkerManager dbManager = DbWorkerManager();
  final _nameController = TextEditingController();
  final _jobConteroller = TextEditingController();
  late Worker worker;
  final _formkey = GlobalKey<FormState>();
  late List<Worker> workerList;
  late int updateindex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Worker List")),
      body: ListView(
        children: [
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    controller: _nameController,
                    validator: (val) =>
                        val!.isNotEmpty ? null : 'Name Should Not be Empty',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Job',
                      border: OutlineInputBorder(),
                    ),
                    controller: _jobConteroller,
                    validator: (val) =>
                        val!.isNotEmpty ? null : 'Job Should Not be Empty',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _submitWorker(context);
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Submit',
                            textAlign: TextAlign.center,
                          ))),
                  FutureBuilder(
                      future: dbManager.getWorkerList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          workerList = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: workerList.length,
                            itemBuilder: (BuildContext contex, int index) {
                              Worker st = workerList[index];
                              return Card(
                                child: ListTile(
                                  leading: IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          _nameController.text = st.name;
                                          _jobConteroller.text = st.job;
                                          worker = st;
                                          updateindex = index;
                                        });

                                        // _UpdateWorker(context);
                                      },
                                      icon: Icon(Icons.edit)),
                                  title: Text("${st.name}"),
                                  subtitle: Text("${st.job}"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      print(workerList.length);
                                      dbManager.deleteWorker(st.id!);
                                      setState(() {
                                        workerList.removeAt(index);
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),

                                //  Row(
                                //   children: [
                                //     Column(
                                //       children: <Widget>[
                                //         Text(' ${st.name}'),
                                //         Text('${st.job}')
                                //       ],
                                //     ),
                                //     IconButton(
                                //         onPressed: () {
                                //           _nameController.text = st.name;
                                //           _jobConteroller.text = st.job;
                                //           worker = st;
                                //           updateindex = index;
                                //         },
                                //         icon: Icon(Icons.edit)),
                                //     IconButton(
                                //         onPressed: () {
                                //           dbManager.deleteWorker(st.id!);
                                //           setState(() {
                                //             workerList.removeAt(index);
                                //           });
                                //         },
                                //         icon: Icon(Icons.delete))
                                //   ],
                                // ),
                              );
                            },
                          );
                        }
                        return Container();
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitWorker(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      Worker st =
          new Worker(name: _nameController.text, job: _jobConteroller.text);
      dbManager
          .insertWorker(st)
          .then((id) => {_nameController.clear(), _jobConteroller.clear()});
    } else {
      worker.name = _nameController.text;
      worker.job = _jobConteroller.text;

      dbManager.updateWorker(worker).then((id) => {
            setState(() {
              workerList[updateindex].name = _nameController.text;
              workerList[updateindex].job = _jobConteroller.text;
            }),
            _nameController.clear(),
            _jobConteroller.clear(),
            // ignore: unnecessary_null_comparison
            worker == null
          });
    }
  }
}
