import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

Future<http.Response> notificationSend(String title, String deviceToken,
    String body, String uid, String status) async {
  const endpoint = "https://fcm.googleapis.com/fcm/send";

  final header = {
    'Authorization':
        'key=AAAAp6nttZU:APA91bH_pThOvTaiXW4SSmR42dxVRtF_MQy3wmw3-c9OyM2wpQJCiHRpyvcbaRVZ3uT3LqoKqNgrpWBcNSZwXrGfmLWSpJCHFu9far2zEWgGjJPE4iJ-s119iy1V-rK4RktKFLh_QllS',
    'Content-Type': 'application/json'
  };
  FirebaseFirestore.instance
      .collection("notifications")
      .add({"body": body, "title": title, "uid": uid, "status": status});
  return http.post(Uri.parse(endpoint),
      headers: header,
      body: jsonEncode({
        "to": deviceToken, // topic name
        "notification": {"body": body, "title": title, "sound": "default"}
      }));
}
