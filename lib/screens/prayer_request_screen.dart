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
import 'package:country_picker/country_picker.dart';

class PrayerRequestScreen extends StatefulWidget {
  const PrayerRequestScreen({super.key});

  @override
  State<PrayerRequestScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<PrayerRequestScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController prayerController = TextEditingController();
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
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  "Prayer Request",
                  style: AppStyle.txtUrbanistBold16.copyWith(
                      fontSize: 30, color: ColorConstant.primaryColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: fullNameController,
                  hintText: 'Full Name',
                  obsecureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validationType: "Name",
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
                  controller: emailController,
                  hintText: 'Email',
                  obsecureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validationType: 'Email',
                ),
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode:
                          true, // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        print('Select country: ${country.displayName}');
                        countryController.text = country.displayName;
                      },
                    );
                  },
                  child: CustomTextField(
                    controller: countryController,
                    hintText: 'Country',
                    obsecureText: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    validationType: "Name",
                  ),
                ),
                CustomTextField(
                  controller: stateController,
                  hintText: 'State',
                  obsecureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validationType: "Name",
                ),
                CustomTextField(
                  controller: cityController,
                  hintText: 'City',
                  obsecureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validationType: "Name",
                ),
                InkWell(
                  onTap: () {
                    showSelectedDialog(context);
                  },
                  child: CustomTextField(
                    controller: prayerController,
                    hintText: 'Prayer For',
                    obsecureText: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    validationType: "Name",
                  ),
                ),
                CustomTextField(
                  controller: messageController,
                  hintText: 'Message',
                  obsecureText: false,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.multiline,
                  validationType: "Name",
                  lines: 6,
                ),
                InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection("prayer_request")
                            .add({
                          'fullNameController': fullNameController.text,
                          'contactNoController': contactNoController.text,
                          'emailController': emailController.text,
                          'stateController': stateController.text,
                          'messageController': messageController.text,
                          'prayerController': prayerController.text,
                          'cityController': cityController.text,
                          'countryController': countryController.text
                        });
                        Fluttertoast.showToast(
                            msg: "Prayer Request Send successfully");
                        Navigator.pop(context);
                      }
                    },
                    child: ButtonWidget(title: 'Send Prayer Request'))
              ]),
            )),
      ),
    );
  }

  List<String> items = [
    "A Neighbour/Co-Worker",
    "Abuse",
    "Alcohol",
    "Allergies",
    "Cancer",
    "Child Custody",
    "Church",
    "Cold & Flu",
    "Deliverance from Addictions",
    "Depression",
    "Diabetes",
    "Drugs",
    "Emotional Distress",
    "Family Member",
    "Family Situations",
    "For A brother/ Sister In Christ",
    "For A Friend",
    "For A Loved One",
    "For Finances",
    "For My Business",
    "For My Family",
    "For My Home Church",
    "For My Job",
    "For My Ministry",
    "For Myself",
    "For Provision",
    "For The Current World Situation",
    "For The Government",
    "Heart Problems",
    "Internal Organs",
    "Legal Situation",
    "Life Threats",
    "Lung Disease",
    "Marriage Restoration",
    "Mental Illness",
    "Military Service",
    "Other",
    "Physical Ailment",
    "Protection",
    "Rebellious Children",
    "Salvation",
    "Sexual Perversion",
    "Stroke",
    "Tobacco",
  ];
  showSelectedDialog(
    BuildContext context2,
  ) {
    showDialog(
        context: context2,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Select Prayer For',
                style: AppStyle.txtUrbanistBold16
                    .copyWith(color: ColorConstant.primaryColor2),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < items.length; i++)
                          InkWell(
                            onTap: () {
                              prayerController.text = items[i];
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: [
                                Text(items[i],
                                    style: AppStyle.txtUrbanistBold16.copyWith(
                                        color: ColorConstant.primaryColor2,
                                        fontSize: 13)),
                                Divider(
                                  thickness: 1,
                                  color: ColorConstant.primaryColor2,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
