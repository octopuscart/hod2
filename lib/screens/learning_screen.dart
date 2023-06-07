// ignore_for_file: unused_import

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';
import 'package:house_of_deliverance/models/songs_model_data.dart';
import 'package:house_of_deliverance/screens/home_screen.dart';
import 'package:house_of_deliverance/screens/notes/note_list.dart';
import 'package:house_of_deliverance/screens/notifications_screen.dart';
import 'package:house_of_deliverance/screens/song_detail_screen.dart';

class LearningScreen extends StatefulWidget {
  final bool isHindi;
  const LearningScreen({super.key, this.isHindi = false});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

bool isFirst = true;

class _LearningScreenState extends State<LearningScreen> {
  String selectedListen = "";
  FlutterTts flutterTts = FlutterTts();
  int songsIndex = 0;
  @override
  void initState() {
    super.initState();
    // getData();
  }

  setData() async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);
    await flutterTts.setLanguage("en-US");

    await flutterTts.setSpeechRate(0.5);

    await flutterTts.setVolume(1.0);

    await flutterTts.setPitch(1.0);
  }

  bool isPlaying = true;
  Future speak(String message) async {
    var result = await flutterTts.speak(message);
    if (result == 1 && mounted) setState(() => isPlaying = true);
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1 && mounted) setState(() => isPlaying = false);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   setData();
  // }

  // @override
  // void dispose() {
  //   stop();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 400,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  width: 100,
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  leading: Icon(Icons.home, color: ColorConstant.primaryColor),
                  title: Text(
                    "Home",
                    style: AppStyle.txtUrbanistBold16
                        .copyWith(color: ColorConstant.primaryColor),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => NoteList()));
                  },
                  leading: Icon(Icons.notes, color: ColorConstant.primaryColor),
                  title: Text(
                    "Notes",
                    style: AppStyle.txtUrbanistBold16
                        .copyWith(color: ColorConstant.primaryColor),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsScreen()));
                  },
                  leading: Icon(Icons.notifications,
                      color: ColorConstant.primaryColor),
                  title: Text(
                    "Notifications",
                    style: AppStyle.txtUrbanistBold16
                        .copyWith(color: ColorConstant.primaryColor),
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "House of Deliverance",
                  style: AppStyle.txtUrbanistBold16
                      .copyWith(color: ColorConstant.primaryColor2),
                ),
                Text(
                  "Song Book",
                  style: AppStyle.txtUrbanistMedium12
                      .copyWith(color: ColorConstant.primaryColor2),
                ),
              ],
            )
          ],
        ),
        foregroundColor: ColorConstant.primaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: widget.isHindi
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < songs.length; i++)
                            songs[i].category_id == "2"
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedListen = songs[i].id;
                                      });
                                      songsIndex = 0;
                                    },
                                    child: ElementSong(
                                      title: songs[i].title,
                                      i: i.toString(),
                                    ))
                                : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < songsData.length; i++)
                              songsData[i].display_index == selectedListen
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SongDetailScreen(
                                                      lyrics:
                                                          songsData[i].lyrics,
                                                      title: songsData[i].title,
                                                      video: songsData[i]
                                                          .youtube_link,
                                                    )));
                                      },
                                      child: SongWidget(
                                          title: songsData[i].title,
                                          i: (++songsIndex).toString()))
                                  : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < songs.length; i++)
                            songs[i].category_id == "1"
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedListen = songs[i].id;
                                      });
                                      songsIndex = 0;
                                    },
                                    child: ElementSong(
                                        title: songs[i].title,
                                        i: (i + 1).toString()))
                                : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < songsData.length; i++)
                              songsData[i].display_index == selectedListen
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SongDetailScreen(
                                                      lyrics:
                                                          songsData[i].lyrics,
                                                      title: songsData[i].title,
                                                      video: songsData[i]
                                                          .youtube_link,
                                                    )));
                                      },
                                      child: SongWidget(
                                          title: songsData[i].title,
                                          i: (++songsIndex).toString()))
                                  : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
    );
  }
}

class SongWidget extends StatelessWidget {
  final String title, i;
  const SongWidget({
    required this.title,
    required this.i,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorConstant.primaryColor2.withOpacity(0.8),
              ColorConstant.primaryColor.withOpacity(0.8),
            ],
          )),
      child: Text("$i) $title", style: AppStyle.txtUrbanistBold16),
    );
  }
}

class ElementSong extends StatelessWidget {
  final String title, i;
  const ElementSong({
    required this.title,
    required this.i,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                ColorConstant.primaryColor2.withOpacity(0.8),
                ColorConstant.primaryColor.withOpacity(0.8),
              ],
            )),
        child: Center(
          child: Text(title,
              style: AppStyle.txtUrbanistBold18.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
