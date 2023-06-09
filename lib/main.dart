import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:house_of_deliverance/core/db_helper.dart';
import 'package:house_of_deliverance/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    // print(message.data.toString());
    // print(message.notification!.title);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  DatabaseHelper().initializeDatabase();
  runApp(const MyApp());
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House of Deliverance',
      home: SplashScreen(),
    );
  }
}
