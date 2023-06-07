import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_of_deliverance/models/app_data.dart';
import 'package:house_of_deliverance/models/songs_model_data.dart';
import 'package:house_of_deliverance/notifications/configure_listener.dart';
import 'package:house_of_deliverance/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    configureListener(context);
    setDataLocal();
    Future.delayed(Duration(seconds: 5)).whenComplete(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => HomeScreen())),
          (route) => false);
    });
  }

  setDataLocal() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("app_data").get();
    var elem = data.docs.first.data();
    address = elem['address'];
    pno = elem['pno'];
    BibleStudy = elem['BibleStudy'];
    ChurchService = elem['ChurchService'];
    songs = [];
    songsData = [];
    FirebaseFirestore.instance
        .collection("songs")
        .orderBy("title")
        .snapshots(includeMetadataChanges: true)
        .listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        log("Change is: ${change.doc.data()}");
        int isFound = 0;
        for (int i = 0; i < songs.length; i++) {
          if (songs[i].id == change.doc.id) {
            isFound = 1;
            break;
          }
        }

        if (isFound == 0) {
          Songs songToBeAdded = Songs(
            change.doc.id,
            change.doc.data()!['title'].toString().toUpperCase(),
            change.doc.data()!['category_id'] ?? "",
          );
          songs.add(songToBeAdded);
        }
      }
      if (songs.isEmpty) {
        songs = songs2;
      }
      Future.delayed(Duration(seconds: 2)).whenComplete(() {
        if (mounted) setState(() {});
      });
    });
    FirebaseFirestore.instance
        .collection("songs_data")
        .snapshots(includeMetadataChanges: true)
        .listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        log("Change is: ${change.doc.data()}");
        int isFound = 0;
        for (int i = 0; i < songsData.length; i++) {
          if (songsData[i].id == change.doc.id) {
            isFound = 1;
            break;
          }
        }

        if (isFound == 0) {
          SongsData songDataTobeAdded = SongsData(
            change.doc.id,
            change.doc.data()!['song_index_id'] ??
                change.doc.data()!['display_index'].toString() ??
                change.doc.id ??
                "",
            change.doc.data()!['title'] ?? "",
            change.doc.data()!['lyrics'] ?? "",
            change.doc.data()!['youtube_link'] ?? "",
            change.doc.data()!['display_index'].toString(),
          );

          songsData.add(songDataTobeAdded);
        }
      }
      if (songsData.isEmpty) {
        songsData = songsData2;
      }
      Future.delayed(Duration(seconds: 2)).whenComplete(() {
        if (mounted) setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
