import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationMessage {
  String title;
  String body;
  String message;
  Timestamp createdAt;
  // ignore: non_constant_identifier_names
  Map<dynamic, dynamic> otherInfo;
  NotificationMessage(
      {required this.title,
      required this.body,
      this.message = "",
      required this.createdAt,
      required this.otherInfo});
}
