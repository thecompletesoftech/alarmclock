import 'package:clockalarm/Config/Import.dart';

class WorldClock extends StatefulWidget {
  const WorldClock({super.key});

  @override
  State<WorldClock> createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": "assets/add.png", "screenname": AddAlram()},
            {"icon": "assets/edit.png", "screenname": ""},
            {"icon": "assets/person.png", "screenname": Profile()},
          ], titletext: worldclock,
          showarrow: false,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 250),
              items: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 230,
                              width: 230,
                              decoration: Utils().decoration(
                                  cntx: context,
                                  isdark: NeumorphicTheme.isUsingDark(context),
                                  radius: 250.0 * fem),
                            ),
                            Container(
                              height: 18,
                              width: 2,
                              color: NeumorphicTheme.defaultTextColor(context),
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
                              color: NeumorphicTheme.defaultTextColor(context),
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
                              color: NeumorphicTheme.defaultTextColor(context),
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
                              color: NeumorphicTheme.defaultTextColor(context),
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
                        datetime: DateTime(2019, 1, 1, 9, 12, 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            DotsIndicator(
              dotsCount: 4,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 10.5 * fem),
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.only(left: 32.0, top: 16.0, right: 16.0),
                  height: 60,
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Bangalore",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40020,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "India",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw70014,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "01:00",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40020,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "pm",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw70014,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _showNeumorphicBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 500,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                selectcity,
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw60018,
                    color: NeumorphicTheme.accentColor(context)),
              ),
              SizedBox(
                height: 9,
              ),
              TextBoxwidget(
                hinttext: 'Search',
                validator: (p0) {},
                ontap: () {},
                suffixicon: Icon(
                  Icons.search,
                  color: NeumorphicTheme.accentColor(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
