import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';
import 'package:house_of_deliverance/models/notification_model.dart';
import 'package:house_of_deliverance/screens/home_screen.dart';
import 'package:house_of_deliverance/screens/notes/note_list.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notificationModel = [];
  bool isLoading = false;
  showDialogModel(
      BuildContext context, NotificationModel notificationModelData) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                notificationModelData.title,
                style: AppStyle.txtUrbanistBold16
                    .copyWith(color: ColorConstant.primaryColor, fontSize: 18),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      notificationModelData.image,
                      width: MediaQuery.of(context).size.width - 100,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: SingleChildScrollView(
                        child: Text(
                          notificationModelData.body,
                          style: AppStyle.txtUrbanistSemiBold12.copyWith(
                              color: ColorConstant.primaryColor, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    var data =
        await FirebaseFirestore.instance.collection("notifications").get();

    if (data.docs.isNotEmpty) {
      for (var element in data.docs) {
        notificationModel.add(NotificationModel(
          title: element.data()['title'],
          image: element.data()['image'],
          body: element.data()['body'],
        ));
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => NotificationsScreen()));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Notifications",
                style: AppStyle.txtUrbanistBold24
                    .copyWith(color: ColorConstant.primaryColor2),
              ),
              const SizedBox(
                height: 20,
              ),
              for (int i = 0; i < notificationModel.length; i++)
                InkWell(
                  onTap: () {
                    showDialogModel(context, notificationModel[i]);
                  },
                  child: NotificationWidget(
                    title: notificationModel[i].title,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final String title;
  const NotificationWidget({
    required this.title,
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
      child: Center(
        child: Text(title, style: AppStyle.txtUrbanistBold16),
      ),
    );
  }
}
