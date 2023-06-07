import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';
import 'package:house_of_deliverance/screens/home_screen.dart';
import 'package:house_of_deliverance/screens/notes/note_list.dart';
import 'package:house_of_deliverance/screens/notifications_screen.dart';
import 'package:house_of_deliverance/widgets/button_widget.dart';
import 'package:house_of_deliverance/widgets/custom_textfield.dart';

class SendSongScreen extends StatefulWidget {
  const SendSongScreen({super.key});

  @override
  State<SendSongScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<SendSongScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController songTitleController = TextEditingController();
  TextEditingController songLyricsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              "Send us song",
              style: AppStyle.txtUrbanistBold16
                  .copyWith(fontSize: 30, color: ColorConstant.primaryColor),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: fullNameController,
                hintText: 'Full Name',
                obsecureText: false,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                validationType: "Name",
              ),
            ),
            CustomTextField(
              controller: contactNoController,
              hintText: 'Contact No',
              obsecureText: false,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              validationType: "Name",
            ),
            CustomTextField(
              controller: songTitleController,
              hintText: 'Song Title',
              obsecureText: false,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              validationType: "Name",
            ),
            CustomTextField(
              controller: songLyricsController,
              hintText: 'Song Lyrics',
              obsecureText: false,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validationType: "Name",
              lines: 6,
            ),
            InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance.collection("songs_request").add({
                      'fullNameController': fullNameController.text,
                      'contactNoController': contactNoController.text,
                      'songTitleController': songTitleController.text,
                      'songLyricsController': songLyricsController.text
                    });
                    Fluttertoast.showToast(msg: "Song send successfully");
                    Navigator.pop(context);
                  }
                },
                child: ButtonWidget(title: 'Send Song'))
          ]),
        ),
      ),
    );
  }
}
