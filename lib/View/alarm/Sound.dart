import 'package:assets_audio_player/assets_audio_player.dart';

import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';

class Sound extends StatefulWidget {
  const Sound({super.key});

  @override
  State<Sound> createState() => _SoundState();
}

class _SoundState extends State<Sound> {
  var soundlist = [
    {"title": "Immigrant Song", "path": "assets/ringtone/ImmigrantSong.mp3"},
    {"title": "Super Mario", "path": "assets/ringtone/Super-Mario.mp3"},
    {"title": "Breaking", "path": "assets/ringtone/Breaking-Me-Tik-Tok.mp3"},
    {"title": "Canopy"},
    {"title": "Thursday"},
    {"title": "Chalet"},
    {"title": "Quad"},
    {"title": "Steps"},
    {"title": "Chirp"},
    {"title": "Valley"}
  ];
  var isplaying = false;
  AlramController _alramController = Get.put(AlramController());
  String time = "-";
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Stack(
              children: [
                GestureDetector(
                  onTap: (() {
                    backscreen(context);
                  }),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: mycolor().greenlightcolor,
                        size: 15.0,
                        fill: 0.5,
                      ),
                      SizedBox(width: 5),
                      Text(back,
                          style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40014,
                            color: NeumorphicTheme.defaultTextColor(context),
                          )),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 5, vertical: 5),
                Center(
                  child: Text(
                    "Sound",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw60018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            Container(
                decoration: Utils().decoration(
                    cntx: context,
                    isdark: NeumorphicTheme.isUsingDark(context),
                    radius: 18.0 * fem),
                child: StreamBuilder(
                    stream: AssetsAudioPlayer.newPlayer().isPlaying,
                    builder: (context, asyncSnapshot) {
                      // final bool? isPlaying = asyncSnapshot.data;
                      // print("isplaying" + isPlaying.toString());
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: soundlist.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _alramController.currentsound.value =
                                  soundlist[index]['title'].toString();
                              _alramController.currentsoundpath.value =
                                  soundlist[index]['path'].toString();
                              backscreen(context);
                              // if (index == 0) {
                              //   // final player = AudioCache();
                              //   // player.play('assets/ImmigrantSong.mp3');
                              // }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        soundlist[index]['title'].toString(),
                                        style: MyTextStyle.Dynamic(
                                            style: MyTextStyle.mw40020,
                                            color: NeumorphicTheme.accentColor(
                                                context)),
                                      ),
                                      // GestureDetector(
                                      //     onTap: (() {
                                      //       if (isPlaying == false) {
                                      //         playaudio(index);
                                      //       }
                                      //     }),
                                      //     child: Icon(Icons.play_arrow))
                                    ],
                                  ),
                                  if (index != soundlist.length - 1) Divider()
                                ],
                              ),
                            ).paddingOnly(top: 5),
                          );
                        },
                      ).paddingOnly(top: 10, bottom: 5);
                    })),
            SizedBox(height: 58),
            ButtonWidget(
              width: 68.0,
              name: none,
              txtstyle: MyTextStyle.mw40020,
              borderRadius: 20.0,
              onTap: () {},
            ),
            SizedBox(height: 20),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }

  playaudio(index) {
    setState(() {
      isplaying = true;
    });

    AssetsAudioPlayer.newPlayer().open(
      Audio(soundlist[index]['path'].toString()),
      autoStart: true,
      showNotification: true,
    );
    AssetsAudioPlayer.newPlayer().play();
    final bool playing = AssetsAudioPlayer.newPlayer().isPlaying.value;
    print("isplaying--------------------------------" + playing.toString());
  }
}
