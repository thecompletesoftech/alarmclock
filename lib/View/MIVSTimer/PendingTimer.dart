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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Started at",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40012,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "4:30",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40012,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Started at",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40012,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "4:30",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40012,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      title: snoozetxt, hour: "00", minute: "00", second: "00"),
                ],
              ),
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
                    ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
