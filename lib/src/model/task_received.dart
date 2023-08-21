// To parse this JSON data, do
//
//     final taskReceived = taskReceivedFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TaskReceived {
  String id;
  Task? task;
  int rating;
  bool isQualified;
  String? comments;
  int v;
  String? archivos;

  TaskReceived({
    required this.id,
    this.task,
    required this.rating,
    required this.isQualified,
    this.comments,
    required this.v,
    this.archivos,
  });

  factory TaskReceived.fromRawJson(String str) =>
      TaskReceived.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskReceived.fromJson(Map<String, dynamic> json) => TaskReceived(
        id: json["_id"],
        task: Task.fromJson(json["task"]),
        rating: json["rating"],
        isQualified: json["isQualified"],
        comments: json['comments'],
        v: json["__v"],
        archivos: json["archivos"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "task": task!.toJson(),
        "rating": rating,
        "isQualified": isQualified,
        "comments": comments,
        "__v": v,
        "archivos": archivos,
      };
}

class Task {
  String id;
  String subject;
  String nameTask;
  String description;
  bool status;
  String group;
  DateTime createdAt;
  DateTime expiredAt;
  String userTeacher;
  int v;

  Task({
    required this.id,
    required this.subject,
    required this.nameTask,
    required this.description,
    required this.status,
    required this.group,
    required this.createdAt,
    required this.expiredAt,
    required this.userTeacher,
    required this.v,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        subject: json["subject"],
        nameTask: json["nameTask"],
        description: json["description"],
        status: json["status"],
        group: json["group"],
        createdAt: DateTime.parse(json["createdAt"]),
        expiredAt: DateTime.parse(json["expiredAt"]),
        userTeacher: json["userTeacher"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject,
        "nameTask": nameTask,
        "description": description,
        "status": status,
        "group": group,
        "createdAt": createdAt.toIso8601String(),
        "expiredAt": expiredAt.toIso8601String(),
        "userTeacher": userTeacher,
        "__v": v,
      };
}




// // To parse this JSON data, do
// //
// //     final taskReceived = taskReceivedFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// class TaskReceived {
//     TaskReceived({
//         required this.id,
//         required this.task,
//         required this.rating,
//         required this.isQualified,
//          this.comments,
//         required this.v,
//          this.archivos,
//     });

//     String id;
//     Task task;
//     double rating;
//     bool isQualified;
//     String? comments;
//     int v;
//     String? archivos;

//     factory TaskReceived.fromRawJson(String str) => TaskReceived.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory TaskReceived.fromJson(Map<String, dynamic> json) => TaskReceived(
//         id: json["_id"],
//         task: Task.fromJson(json["task"]),
//         rating: json["rating"]?.toDouble(),
//         isQualified: json["isQualified"],
//         comments: json["comments"],
//         v: json["__v"],
//         archivos: json["archivos"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "task": task.toJson(),
//         "rating": rating,
//         "isQualified": isQualified,
//         "comments": comments,
//         "__v": v,
//         "archivos": archivos,
//     };
// }

// class Task {
//     Task({
//         required this.id,
//         required this.subject,
//         required this.nameTask,
//         required this.description,
//         required this.status,
//         required this.group,
//         required this.userTeacher,
//         required this.v,
//         required this.archivos,
//     }); 


//     String id;
//     String subject;
//     String nameTask;
//     String description;
//     bool status;
//     String group;
//     String userTeacher;
//     int v;
//     String? archivos;

//     factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Task.fromJson(Map<String, dynamic> json) => Task(
//         id: json["_id"],
//         subject: json["subject"],
//         nameTask: json["nameTask"],
//         description: json["description"],
//         status: json["status"],
//         group: json["group"],
//         userTeacher: json["userTeacher"],
//         v: json["__v"],
//         archivos: json["archivos"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "subject": subject,
//         "nameTask": nameTask,
//         "description": description,
//         "status": status,
//         "group": group,
//         "userTeacher": userTeacher,
//         "__v": v,
//         "archivos": archivos,
//     };
// }
