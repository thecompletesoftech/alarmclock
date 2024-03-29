import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/Json/Json.dart';
import 'package:clockalarm/View/WorldClock/Clock.dart';
import 'package:clockalarm/View/WorldClock/SearchScreen.dart';

import '../../Coming/TimeList.dart';

class WorldClock extends StatefulWidget {
  const WorldClock({super.key});

  @override
  State<WorldClock> createState() => _WorldClockState();
}

@override
class _WorldClockState extends State<WorldClock> {
  WorldController controller = Get.put(WorldController());
  var currentindex = 0;
  void initState() {
    // GetStorage().erase();
    controller.currentcitytime.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": AddAlram()},
              {"icon": "assets/Save.png", "screenname": TimeList()},
              {"icon": "assets/person.png", "screenname": Profile()},
            ],
            ontapnavigate: (value) {
              switch (value) {
                case 0:
                  Navigator.of(context).push(createRoutes(SearchScreen()));
                  break;
                case 1:
                  nextscreen(context, TimeList());
                  break;
                case 2:
                  nextscreen(context, Profile());
                  break;
              }
            },
            titletext: worldclock,
            ontapornavigate: true,
            showarrow: false,
          ).marginOnly(top: 8)),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: ApiHelper().getsnapshotbyuserid('worldclocklist'),
                  builder: (context, snapshot) {
                    if ((snapshot.data == null) ||
                        (snapshot.data!.docs.length < 1)) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          reverse: false,
                          height: 280,
                          initialPage: 0,
                          onPageChanged: (index, reason) {},
                        ),
                        items: [1].map((element) {
                          return ClockWidget(
                            currenttime: DateTime.now(),
                          );
                        }).toList(),
                      );
                    }
                    return CarouselSlider(
                      options: CarouselOptions(
                        reverse: false,
                        height: 280,
                        initialPage: currentindex,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentindex = index;
                          });
                        },
                      ),
                      items: snapshot.data!.docs.map((element) {
                        var currenttime =
                            controller.gettime(element['placename']);
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Stack(
                              children: [
                                Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    NeumorphicTheme.isUsingDark(context)
                                        ? Container(
                                            height: 230,
                                            width: 230,
                                            decoration: Utils().decoration(
                                                cntx: context,
                                                isdark:
                                                    NeumorphicTheme.isUsingDark(
                                                        context),
                                                radius: 250.0 * fem),
                                          )
                                        : Image.asset("assets/stopwatch.png",
                                            height: 235),
                                    Container(
                                      height: 18,
                                      width: 2,
                                      color: NeumorphicTheme.defaultTextColor(
                                          context),
                                    ).paddingOnly(top: 8),
                                  ],
                                ),
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      height: 230,
                                      width: 230,
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      height: 2,
                                      width: 18,
                                      color: NeumorphicTheme.defaultTextColor(
                                          context),
                                    ).paddingOnly(left: 8),
                                  ],
                                ),
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      height: 230,
                                      width: 230,
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 2,
                                      color: NeumorphicTheme.defaultTextColor(
                                          context),
                                    ).paddingOnly(bottom: 8),
                                  ],
                                ),
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Container(
                                      height: 230,
                                      width: 230,
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      height: 2,
                                      width: 18,
                                      color: NeumorphicTheme.defaultTextColor(
                                          context),
                                    ).paddingOnly(right: 8),
                                  ],
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                if (NeumorphicTheme.isUsingDark(context) ==
                                    false)
                                  Image.asset("assets/stopwatch.png",
                                          height: 160)
                                      .paddingOnly(left: 5),
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: AnalogClock(
                                    decoration:
                                        NeumorphicTheme.isUsingDark(context)
                                            ? Utils().decoration(
                                                cntx: context,
                                                isdark:
                                                    NeumorphicTheme.isUsingDark(
                                                        context),
                                                radius: 150 * fem)
                                            : BoxDecoration(),
                                    width: 150.0,
                                    isLive: true,
                                    hourHandColor:
                                        NeumorphicTheme.defaultTextColor(
                                            context),
                                    minuteHandColor:
                                        NeumorphicTheme.accentColor(context),
                                    showSecondHand: false,
                                    numberColor: Colors.black87,
                                    showNumbers: false,
                                    showAllNumbers: false,
                                    textScaleFactor: 1.4,
                                    showTicks: false,
                                    showDigitalClock: false,
                                    datetime: currenttime ?? DateTime.now(),
                                  ).paddingOnly(left: 10),
                                ),
                              ],
                            ).paddingOnly(
                                right: NeumorphicTheme.isUsingDark(context)
                                    ? 0
                                    : 5,
                                bottom: NeumorphicTheme.isUsingDark(context)
                                    ? 0
                                    : 3),
                          ],
                        );
                      }).toList(),
                    );
                  }),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: ApiHelper().getsnapshotbyuserid('worldclocklist'),
                  builder: (context, snapshot) {
                    if ((snapshot.data == null) ||
                        (snapshot.data!.docs.length < 1)) {
                      return DotsIndicator(
                        dotsCount: 1,
                        position: 0,
                        decorator: DotsDecorator(
                            activeColor: NeumorphicTheme.accentColor(context)),
                      );
                    }
                    return DotsIndicator(
                      dotsCount: snapshot.data!.docs.length,
                      position: currentindex,
                      decorator: DotsDecorator(
                          activeColor: NeumorphicTheme.accentColor(context)),
                    );
                  }),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: ApiHelper().getsnapshotbyuserid('worldclocklist'),
                  builder: (context, snapshot) {
                    if ((snapshot.data == null) ||
                        (snapshot.data!.docs.length < 1)) {
                      return Center(
                        child: Text(
                          noanyclockadded,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw50018,
                              color: NeumorphicTheme.defaultTextColor(context)),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot newitem = snapshot.data!.docs[index];
                          var currenttime = controller
                              .gettime(snapshot.data!.docs[index]['placename']);
                          return Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical:
                                        NeumorphicTheme.isUsingDark(context)
                                            ? 5
                                            : 0),
                                child: CardBackground(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            newitem['label'],
                                            style: MyTextStyle.Dynamic(
                                                style: MyTextStyle.mw40020,
                                                color:
                                                    NeumorphicTheme.accentColor(
                                                        context)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            formatTime(currenttime)
                                                .toString()
                                                .split(' ')[0],
                                            style: MyTextStyle.Dynamic(
                                                style: MyTextStyle.mw40018,
                                                color:
                                                    NeumorphicTheme.accentColor(
                                                        context)),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            formatTime(currenttime)
                                                .toString()
                                                .split(' ')[1],
                                            style: MyTextStyle.Dynamic(
                                                style: MyTextStyle.mw70014,
                                                color:
                                                    mycolor().greenlightcolor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      vertical:
                                          NeumorphicTheme.isUsingDark(context)
                                              ? 3
                                              : 0),
                                ).paddingOnly(bottom: 20),
                              ),
                              Positioned(
                                right: NeumorphicTheme.isUsingDark(context)
                                    ? 10
                                    : 18,
                                top: 0,
                                child: InkWell(
                                  onTap: () {
                                    ApiHelper().deletedata(
                                        'worldclocklist', newitem['id']);
                                  },
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
