import 'dart:convert';

CreateData createDataFromJson(String str) =>
    CreateData.fromJson(json.decode(str));

String createDataToJson(CreateData data) => json.encode(data.toJson());

class CreateData {
  CreateData({
    required this.name,
    required this.job,
    required this.id,
    required this.createdAt,
  });

  final String name;
  final String job;
  final String id;
  final DateTime createdAt;

  factory CreateData.fromJson(Map<String, dynamic> json) => CreateData(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}

class Create {
  String? name;
  String? job;

  Create({this.name, this.job});

  toJson() {
    return {"name": name, "job": job};
  }

  fromJson(jsonData) {
    return Create(name: jsonData['name'], job: jsonData['job']);
  }
}

class Todo {
  int? id;
  String? title;
  String? description;
  bool? status;

  Todo({this.id, this.title, this.description, this.status}) {
    id = this.id;
    title = this.title;
    description = this.description;
    status = this.status;
  }

  toJson() {
    return {
      "id": id,
      "description": description,
      "title": title,
      "status": status
    };
  }

  fromJson(jsonData) {
    return Todo(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        status: jsonData['status']);
  }
}
