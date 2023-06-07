import 'package:flutter/material.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';
import 'package:house_of_deliverance/models/app_data.dart';
import 'package:house_of_deliverance/screens/bible_screen.dart';
import 'package:house_of_deliverance/screens/contact_us_screen.dart';
import 'package:house_of_deliverance/screens/learning_screen.dart';
import 'package:house_of_deliverance/screens/notes/note_list.dart';
import 'package:house_of_deliverance/screens/notifications_screen.dart';
import 'package:house_of_deliverance/screens/prayer_request_screen.dart';
import 'package:house_of_deliverance/screens/send_song_screen.dart';
import 'package:wakelock/wakelock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<HomeScreen> {
  bool keepScreenOn = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();

    checkKeepOnFunction();
  }

  void checkKeepOnFunction() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      keepScreenOn = prefs.getBool("keepScreenon") ?? false;
      print("Keep Screen On : ${keepScreenOn}");
      setWakelock();
    });
  }

  setWakelock() {
    if (keepScreenOn) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
  }

  setKeepOnFunction(bool onvalue) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('keepScreenon', onvalue);
    print("Keep Screen On : ${keepScreenOn}");
    setWakelock();
  }

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
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => HomeScreen()));
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
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsScreen()));
                  },
                  leading: Switch(
                    // This bool value toggles the switch.
                    value: keepScreenOn,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        keepScreenOn = value;
                        setKeepOnFunction(value);
                      });
                    },
                  ),
                  title: Text(
                    "Keep Screen On : ${keepScreenOn ? 'Yes' : 'No'}",
                    style: AppStyle.txtUrbanistBold16
                        .copyWith(color: ColorConstant.primaryColor),
                  ),
                ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "assets/images/bg.jpg",
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LearningScreen()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.7,
                          width: MediaQuery.of(context).size.width / 3.75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ColorConstant.primaryColor2.withOpacity(0.8),
                                  ColorConstant.primaryColor.withOpacity(0.8),
                                ],
                              )),
                          child: Center(
                            child: Text("English",
                                style: AppStyle.txtUrbanistBold16
                                    .copyWith(fontSize: 25)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LearningScreen(
                                        isHindi: true,
                                      )));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.7,
                          width: MediaQuery.of(context).size.width / 3.75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ColorConstant.primaryColor2.withOpacity(0.8),
                                  ColorConstant.primaryColor.withOpacity(0.8),
                                ],
                              )),
                          child: Center(
                            child: Text("हिंदी",
                                style: AppStyle.txtUrbanistBold16
                                    .copyWith(fontSize: 25)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BibleScreen()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.7,
                          width: MediaQuery.of(context).size.width / 3.75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ColorConstant.primaryColor2.withOpacity(0.8),
                                  ColorConstant.primaryColor.withOpacity(0.8),
                                ],
                              )),
                          child: Center(
                            child: Text("Bible",
                                style: AppStyle.txtUrbanistBold16
                                    .copyWith(fontSize: 25)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SendSongScreen()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.7,
                          width: MediaQuery.of(context).size.width / 3.75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ColorConstant.primaryColor2.withOpacity(0.8),
                                  ColorConstant.primaryColor.withOpacity(0.8),
                                ],
                              )),
                          child: Center(
                            child: Text("Send\nSong",
                                textAlign: TextAlign.center,
                                style: AppStyle.txtUrbanistBold16
                                    .copyWith(fontSize: 20)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrayerRequestScreen()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.7,
                          width: MediaQuery.of(context).size.width / 3.75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ColorConstant.primaryColor2.withOpacity(0.8),
                                  ColorConstant.primaryColor.withOpacity(0.8),
                                ],
                              )),
                          child: Center(
                            child: Text("Prayer\nRequest",
                                textAlign: TextAlign.center,
                                style: AppStyle.txtUrbanistBold16
                                    .copyWith(fontSize: 20)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUsScreen()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.7,
                          width: MediaQuery.of(context).size.width / 3.75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ColorConstant.primaryColor2.withOpacity(0.8),
                                  ColorConstant.primaryColor.withOpacity(0.8),
                                ],
                              )),
                          child: Center(
                            child: Text("Contact\nUs",
                                textAlign: TextAlign.center,
                                style: AppStyle.txtUrbanistBold16
                                    .copyWith(fontSize: 20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4.5,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            ColorConstant.primaryColor2.withOpacity(0.8),
                            ColorConstant.primaryColor.withOpacity(0.8),
                          ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: Text(
                          """Bible Study: $BibleStudy\nChurch Service: $ChurchService\n\nAddress: $address\n\nFor more info: $pno""",
                          style: AppStyle.txtUrbanistMedium14appGrey8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
