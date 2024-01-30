import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/Json/Json.dart';
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
    super.initState();
    controller.searchlist.clear();
    controller.searchlist.value = Searchlist;
    controller.setups('Europe/Istanbul', context);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": AddAlram()},
              {"icon": "assets/edit.png", "screenname": TimeList()},
              {"icon": "assets/person.png", "screenname": Profile()},
            ],
            ontapnavigate: (value) {
              switch (value) {
                case 0:
                  nextscreen(context, SearchScreen());
                  break;
                case 1:
                  nextscreen(context, "");
                  break;
                case 2:
                  nextscreen(context, Profile());
                  break;
              }
            },
            titletext: worldclock,
            ontapornavigate: true,
            showarrow: false,
          )),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 280,
                  initialPage: currentindex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentindex = index;
                    });
                  },
                ),
                items: controller.currentcitytime.map((element) {
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
                                          isdark: NeumorphicTheme.isUsingDark(
                                              context),
                                          radius: 250.0 * fem),
                                    )
                                  : SvgPicture.string(clockbackground),
                              Container(
                                height: 18,
                                width: 2,
                                color:
                                    NeumorphicTheme.defaultTextColor(context),
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
                                color:
                                    NeumorphicTheme.defaultTextColor(context),
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
                                color:
                                    NeumorphicTheme.defaultTextColor(context),
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
                                color:
                                    NeumorphicTheme.defaultTextColor(context),
                              ).paddingOnly(right: 8),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        child: AnalogClock(
                          decoration: Utils().decoration(
                              cntx: context,
                              isdark: NeumorphicTheme.isUsingDark(context),
                              radius: 150 * fem),
                          width: 150.0,
                          isLive: true,
                          hourHandColor:
                              NeumorphicTheme.defaultTextColor(context),
                          minuteHandColor: NeumorphicTheme.accentColor(context),
                          showSecondHand: false,
                          numberColor: Colors.black87,
                          showNumbers: false,
                          showAllNumbers: false,
                          textScaleFactor: 1.4,
                          showTicks: false,
                          showDigitalClock: false,
                          datetime: element['time'],
                        ),
                      ).paddingOnly(
                          right: NeumorphicTheme.isUsingDark(context) ? 0 : 5,
                          bottom: NeumorphicTheme.isUsingDark(context) ? 0 : 3),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              DotsIndicator(
                dotsCount: controller.currentcitytime.length,
                position: currentindex,
                decorator: DotsDecorator(
                    activeColor: NeumorphicTheme.accentColor(context)),
              ),
              SizedBox(
                height: 30,
              ),
              if (controller.currentcitytime.length > 0)
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("worldclocklist")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot newitem =
                                snapshot.data!.docs[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: CardBackground(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        newitem['placename'],
                                        style: MyTextStyle.Dynamic(
                                            style: MyTextStyle.mw40020,
                                            color: NeumorphicTheme.accentColor(
                                                context)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        convert24to12(newitem['time'])
                                            .toString(),
                                        style: MyTextStyle.Dynamic(
                                            style: MyTextStyle.mw40018,
                                            color: NeumorphicTheme.accentColor(
                                                context)),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        getAmPm(newitem['time']).toString(),
                                        style: MyTextStyle.Dynamic(
                                            style: MyTextStyle.mw70014,
                                            color: mycolor().greenlightcolor),
                                      ),
                                    ],
                                  ),
                                ],
                              )).paddingOnly(bottom: 20),
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
