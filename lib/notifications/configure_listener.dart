// ignore_for_file: empty_catches, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:house_of_deliverance/notifications/notifications.dart';
import 'package:house_of_deliverance/screens/home_screen.dart';

Future getToken() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  String? deviceToken = "";
  await firebaseMessaging.getToken().then((token) {
    deviceToken = token;
  });
  await FirebaseFirestore.instance
      .collection("DeviceTokens")
      .doc(deviceToken)
      .set({
    "device_token": deviceToken,
    "uid": FirebaseAuth.instance.currentUser!.uid
  });
}

configureListener(BuildContext context) async {
  LocalNotificationService.initialize(context);
  // getToken();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // setMessage(message, context);
    try {
      print("Message: $message");
      print("Message Data: ${message.data}");
      print("Message Data: ${message.notification!.body}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      LocalNotificationService.display(message);
    } catch (ex) {}
  });

  ///gives you the message on which user taps
  ///and it opened the app from terminated state
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    try {
      // ignore: unnecessary_brace_in_string_interps
      print("Message: ${message}");
      print("Message Data: ${message!.data}");
      print("Message Data: ${message.notification!.body}");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      LocalNotificationService.display(message);
    } catch (ex) {}
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    try {
      print("Message: $message");
      print("Message Data: ${message.data}");
      print("Message Data: ${message.notification!.body}");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      LocalNotificationService.display(message);
    } catch (ex) {}
  });
}
