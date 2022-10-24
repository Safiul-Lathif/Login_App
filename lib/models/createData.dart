// To parse this JSON data, do
//
//     final createData = createDataFromJson(jsonString);

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
