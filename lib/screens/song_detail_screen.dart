import 'package:flutter/material.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';
import 'package:house_of_deliverance/screens/home_screen.dart';
import 'package:house_of_deliverance/screens/notes/note_list.dart';
import 'package:house_of_deliverance/screens/notifications_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongDetailScreen extends StatefulWidget {
  final String lyrics, title, video;
  const SongDetailScreen(
      {super.key,
      required this.lyrics,
      required this.title,
      required this.video});

  @override
  State<SongDetailScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<SongDetailScreen> {
  double fontSizeSelected = 15;
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
  );

  bool isStarted = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  change() {
    setState(() {
      isStarted = !isStarted;

      if (isStarted) {
        _controller.unMute();
      } else {
        _controller.mute();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _controller.pause();

    var videoId = widget.video.contains("http")
        ? YoutubePlayer.convertUrlToId(widget.video)
        : widget.video;
    _controller.pause();

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? 'iLnmTe5Q2Qw',
    );
    _controller.pause();
    _controller.pause();

    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: change,
          backgroundColor: ColorConstant.primaryColor2,
          child: Icon(
            isStarted ? Icons.stop : Icons.play_arrow,
            color: Colors.white,
          )),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 50,
              width: 50,
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
            ),
            Container(
              width: 50,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: ColorConstant.primaryColor2,
                  )),
            )
          ],
        ),
        foregroundColor: ColorConstant.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.title,
                  style: AppStyle.txtUrbanistBold24
                      .copyWith(color: ColorConstant.primaryColor2),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          fontSizeSelected = 15;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3 - 40,
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
                          child:
                              Text("Small", style: AppStyle.txtUrbanistBold16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          fontSizeSelected = 18;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3 - 40,
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
                          child:
                              Text("Medium", style: AppStyle.txtUrbanistBold16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          fontSizeSelected = 21;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3 - 40,
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
                          child:
                              Text("Large", style: AppStyle.txtUrbanistBold16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorConstant.primaryColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "${widget.lyrics}",
                      textAlign: TextAlign.start,
                      style: AppStyle.txtUrbanistMedium14appGrey8.copyWith(
                          color: ColorConstant.primaryColor2,
                          fontSize: fontSizeSelected),
                    ),
                  ),
                ),
                widget.video.isEmpty || isStarted == false
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressColors: ProgressBarColors(
                              playedColor: ColorConstant.primaryColor,
                              handleColor:
                                  ColorConstant.primaryColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
