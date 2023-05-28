import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String content;
  String? contentTranslated;
  String title;
  String? titleTranslated;
  Timestamp timeStamp;
  DateTime dateTime;
  String displayDate;
  bool isFinished;
  String uid;

  TodoModel({
    required this.uid,
    required this.content,
    this.contentTranslated,
    required this.title,
    this.titleTranslated,
    required this.timeStamp,
    required this.dateTime,
    required this.displayDate,
    required this.isFinished,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'contentTranslated': contentTranslated,
      'title': title,
      'titleTranslated': titleTranslated,
      'timeStamp': timeStamp,
      'dateTime': dateTime,
      'displayDate': displayDate,
      'isFinished': isFinished,
      'uid': uid,
    };
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TodoModel(
      content: data['content'],
      contentTranslated: data['contentTranslated'],
      title: data['title'],
      titleTranslated: data['titleTranslated'],
      timeStamp: data['timeStamp'],
      dateTime: data['dateTime'].toDate(),
      displayDate: data['displayDate'],
      isFinished: data['isFinished'],
      uid: data['uid'],
    );
  }
}
