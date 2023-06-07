// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';
import 'package:house_of_deliverance/core/db_helper.dart';
import 'package:house_of_deliverance/models/note_model.dart';
import 'package:house_of_deliverance/screens/home_screen.dart';
import 'package:house_of_deliverance/screens/notes/note_detail.dart';
import 'package:house_of_deliverance/screens/notifications_screen.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

List<Note> noteList = [];

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  int axisCount = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget myAppBar() {
      return AppBar(
        title: Text('Notes', style: Theme.of(context).textTheme.headline5),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            splashRadius: 22,
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        actions: <Widget>[
          noteList.isEmpty
              ? IconButton(
                  splashRadius: 22,
                  icon: Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                )
              : IconButton(
                  splashRadius: 22,
                  icon: Icon(
                    axisCount == 2 ? Icons.list : Icons.grid_on,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      axisCount = axisCount == 2 ? 4 : 2;
                    });
                  },
                )
        ],
      );
    }

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
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => NoteList()));
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
      key: _scaffoldKey,
      appBar: myAppBar() as PreferredSizeWidget,
      body: noteList.isEmpty
          ? Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Click on the add button to add a new note!',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            )
          : Container(
              color: Colors.white,
              child: Column(
                children: [
                  for (int i = 0; i < noteList.length; i++)
                    GestureDetector(
                      onTap: () {
                        navigateToDetail(noteList[i], 'Edit Note');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        noteList[i].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(noteList[i].description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(noteList[i].date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                  ])
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(null, 'Add Note');
        },
        tooltip: 'Add Note',
        shape: const CircleBorder(
            side: BorderSide(color: Colors.black, width: 2.0)),
        child: const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }

  void navigateToDetail(Note? note, String title) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoteDetail(
                note ?? Note("", title: "", date: "", description: ""),
                title)));

    if (result == true) {
      updateListView();
    }
  }

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) async {
      List<Note> noteListFuture = await databaseHelper.getNoteList();

      log("Note List:${noteListFuture.length} ");
      setState(() {
        noteList = noteListFuture;
        count = noteListFuture.length;
      });
    });
  }
}
