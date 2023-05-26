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

  factory TodoModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TodoModel(
      content: data['content'],
      title: data['title'],
      timeStamp: data['timeStamp'],
      dateTime: data['dateTime'].toDate(),
      displayDate: data['displayDate'],
      isFinished: data['isFinished'],
    );
  }
}
