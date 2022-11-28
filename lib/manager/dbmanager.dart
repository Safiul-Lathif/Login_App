import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbWorkerManager {
  Database? _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "worker.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE worker (id , INTEGER PRIMARYKEY autoincreament , name TEXT , job, TEXT)");
      });
    }
  }

  Future<int> insertWorker(Worker worker) async {
    await openDb();
    return await _database!.insert('worker', worker.toMap());
  }

  Future<List<Worker>> getWorkerList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('worker');
    return List.generate(maps.length, (i) {
      return Worker(
          id: maps[i]['id'], name: maps[i]['name'], job: maps[i]['job']);
    });
  }

  Future<int> updateWorker(Worker worker) async {
    await openDb();
    return await _database!.update('worker', worker.toMap(),
        where: "id = ?", whereArgs: [worker.id]);
  }

  Future<void> deleteWorker(int id) async {
    await openDb();
    await _database!.delete('worker', where: "id = ?", whereArgs: [id]);
  }
}

class Worker {
  int? id;
  String name;
  String job;

  Worker({required this.name, required this.job, this.id});
  Map<String, dynamic> toMap() {
    return {'name': name, 'job': job};
  }
}
