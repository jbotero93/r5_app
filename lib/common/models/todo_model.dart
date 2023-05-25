import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String content;
  String title;
  Timestamp timeStamp;
  DateTime dateTime;
  String displayDate;
  bool isFinished;

  TodoModel({
    required this.content,
    required this.title,
    required this.timeStamp,
    required this.dateTime,
    required this.displayDate,
    required this.isFinished,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'title': title,
      'timeStamp': timeStamp,
      'dateTime': dateTime,
      'displayDate': displayDate,
      'isFinished': isFinished,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      content: map['content'],
      title: map['title'],
      timeStamp: map['timeStamp'],
      dateTime: map['dateTime'].toDate(),
      displayDate: map['displayDate'],
      isFinished: map['isFinished'],
    );
  }
}
