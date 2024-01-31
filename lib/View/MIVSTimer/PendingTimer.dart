import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/TimerCard.dart';

class PendingTimer extends StatefulWidget {
  final showbtn;
  const PendingTimer({super.key, this.showbtn = false});

  @override
  State<PendingTimer> createState() => _PendingTimerState();
}

class _PendingTimerState extends State<PendingTimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": null},
              {"icon": "assets/person.png", "screenname": null},
            ],
            titletext: pendingtime,
            showdivider: true,
            showlistbtn: false,
            showarrow: true,
            showsubtitle: true,
            subtitle: "Alpha",
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "Started at",
                                    style: MyTextStyle.Dynamic(
                                        style: MyTextStyle.mw40012,
                                        color: NeumorphicTheme.accentColor(
                                            context)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "4:30",
                                    style: MyTextStyle.Dynamic(
                                        style: MyTextStyle.mw40012,
                                        color: NeumorphicTheme.defaultTextColor(
                                            context)),
                                  ),
                                ],
                              ).paddingOnly(
                                  left: NeumorphicTheme.isUsingDark(context)
                                      ? 4
                                      : 12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Started at",
                                  style: MyTextStyle.Dynamic(
                                      style: MyTextStyle.mw40012,
                                      color:
                                          NeumorphicTheme.accentColor(context)),
                                ),
                                Text(
                                  "4:30",
                                  style: MyTextStyle.Dynamic(
                                      style: MyTextStyle.mw40012,
                                      color: NeumorphicTheme.defaultTextColor(
                                          context)),
                                ),
                              ],
                            ).paddingOnly(right: NeumorphicTheme.isUsingDark(context) ? 10: 0),
                             if (NeumorphicTheme.isUsingDark(context))
                            Container(
                              width: 90,
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        height: 60.0,
                                        child: Image.asset(
                                            fit: BoxFit.fill,
                                            NeumorphicTheme.isUsingDark(context)
                                                ? "assets/ProgressBar.png"
                                                : "assets/LightProgressBar.png"
                                            // scale: 0.1,
                                            ),
                                      ),
                                      LinearPercentIndicator(
                                        padding: EdgeInsets.zero,
                                        barRadius: Radius.circular(10),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        curve: Curves.easeInOut,
                                        backgroundColor: mycolor().Transparent,
                                        width: 150.0,
                                        lineHeight: 60.0,
                                        percent: 0.9,
                                        progressColor:
                                            NeumorphicTheme.accentColor(
                                                context),
                                      )
                                    ],
                                  ).paddingSymmetric(
                                      horizontal:
                                          NeumorphicTheme.isUsingDark(context)
                                              ? 0
                                              : 10),
                                ],
                              ),
                            ),
                             if (NeumorphicTheme.isUsingDark(context))
                            Container(
                              height: 80,
                              width: 90,
                            ),
                          ],
                        ).paddingOnly(
                            left: NeumorphicTheme.isUsingDark(context) ? 3 : 0),
                      ],
                    ),
                    if (NeumorphicTheme.isUsingDark(context))
                      Positioned(
                          bottom: 0,
                          right: -8,
                          top: 2,
                          child: Image.asset("assets/Play.png"))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: NeumorphicTheme.isUsingDark(context) ? 8.0 : 0.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Timercard(
                          title: timeReaming,
                          hour: "00",
                          minute: "00",
                          second: "00"),
                      SizedBox(height: 20),
                      IntervalCard(
                        title: reperatinterval,
                        interval: 4,
                      ),
                      SizedBox(height: 20),
                      Intervalend(
                        title: interduration,
                        hour: "12",
                        minute: "00",
                        second: "00",
                        medium: "AM",
                      ),
                      SizedBox(height: 20),
                      Timercard(
                          title: intervalend,
                          hour: "00",
                          minute: "00",
                          second: "00"),
                      SizedBox(height: 20),
                      Timercard(
                          title: totalduration,
                          hour: "00",
                          minute: "00",
                          second: "00"),
                      SizedBox(height: 20),
                      Timercard(
                          title: snoozetxt,
                          hour: "00",
                          minute: "00",
                          second: "00"),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 15),
            SizedBox(height: 30),
            widget.showbtn == true
                ? Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          name: cancel.toUpperCase(),
                          txtstyle: MyTextStyle.mw40018,
                          borderRadius: 15.0,
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: ButtonWidget(
                          name: snoozing,
                          txtstyle: MyTextStyle.mw40018,
                          borderRadius: 15.0,
                          onTap: () {},
                        ),
                      ),
                    ],
                  )
                : ButtonWidget(
                    name: deletetimer,
                    txtstyle: MyTextStyle.mw40018,
                    borderRadius: 15.0,
                    onTap: () {
                      nextscreen(context, AlramTimesup());
                    },
                  ).paddingSymmetric(horizontal: 15.0),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
