import 'package:clockalarm/Widgets/TimeNameCard.dart' show TimeNameCard;

import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/TimerCard.dart';

class AddMIVSTimer extends StatefulWidget {
  const AddMIVSTimer({super.key});

  @override
  State<AddMIVSTimer> createState() => _AddMIVSTimerState();
}

class _AddMIVSTimerState extends State<AddMIVSTimer> {
  Mivsctrl _mivsctrl = Get.put(Mivsctrl());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(82),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": null},
              {"icon": "assets/person.png", "screenname": null},
            ],
            titletext: timertext,
            showdivider: true,
            showbtn: true,
            showarrow: true,
            showlistbtn: false,
          ).marginOnly(top: 5)),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 25 : 10),
              TimeNameCard(
                title: timername,
                interval: alphatext,
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 25 : 20),
              GestureDetector(
                onTap: () async {
                  var picked = await setShowpicker();
                  print("picked" + picked.toString());
                  setState(() {
                    _mivsctrl.intervalend.value = picked.toString();
                  });
                },
                child: Timercard(
                    title: interduration,
                    hour: _mivsctrl.intervalend.value
                        .toString()
                        .split(":")[0]
                        .toString(),
                    minute: _mivsctrl.intervalend.value
                        .toString()
                        .split(":")[1]
                        .toString(),
                    second: _mivsctrl.intervalend.value
                        .toString()
                        .split(":")[2]
                        .toString()),
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 25 : 15),
              IntervalCard(
                title: reperatinterval,
                interval: 4,
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 25 : 15),
              GestureDetector(
                onTap: (() async {
                  var picked = await setShowpicker();
                  print("picked" + picked.toString());
                  setState(() {
                    _mivsctrl.intervalduration.value = picked.toString();
                  });
                }),
                child: Intervalend(
                  title: intervalend,
                  hour: _mivsctrl.intervalduration.value
                      .toString()
                      .split(":")[0]
                      .toString(),
                  minute: _mivsctrl.intervalduration.value
                      .toString()
                      .split(":")[1]
                      .toString(),
                  second: _mivsctrl.intervalduration.value
                      .toString()
                      .split(":")[2]
                      .toString(),
                  medium: getAmPm(_mivsctrl.intervalduration.value
                      .toString()
                      .split(":")[0]
                      .toString()),
                ),
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 25 : 15),
              GestureDetector(
                onTap: (() async {
                  var picked = await setShowpicker();
                  print("picked" + picked.toString());
                  setState(() {
                    _mivsctrl.totalduration.value = picked.toString();
                  });
                }),
                child: Obx(
                  () => Timercard(
                      title: totalduration,
                      hour: _mivsctrl.totalduration.value
                          .toString()
                          .split(":")[0]
                          .toString(),
                      minute: _mivsctrl.totalduration.value
                          .toString()
                          .split(":")[1]
                          .toString(),
                      second: _mivsctrl.totalduration.value
                          .toString()
                          .split(":")[2]
                          .toString()),
                ),
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 25 : 15),
              GestureDetector(
                onTap: (() async {
                  var picked = await setShowpicker();
                  print("picked" + picked.toString());
                  setState(() {
                    _mivsctrl.snoozetime.value = picked.toString();
                  });
                }),
                child: Timercard(
                    title: snoozetxt,
                    hour: _mivsctrl.snoozetime.value
                        .toString()
                        .split(":")[0]
                        .toString(),
                    minute: _mivsctrl.snoozetime.value
                        .toString()
                        .split(":")[1]
                        .toString(),
                    second: _mivsctrl.snoozetime.value
                        .toString()
                        .split(":")[2]
                        .toString()),
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 40 : 0),
              Container(
                height: NeumorphicTheme.isUsingDark(context) ? 50 : 80,
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        name: go,
                        txtstyle: MyTextStyle.mw40020,
                        issmall: true,
                        borderRadius: 15.0,
                        onTap: () {
                          if (_mivsctrl.intervalduration.value == "00:00:00") {
                            Mysnack(req, pleaseselectintervalduration, context);
                          } else if (_mivsctrl.intervalend.value ==
                              "00:00:00") {
                            Mysnack(req, pleaseselectintervalend, context);
                          } else if (_mivsctrl.totalduration.value ==
                              "00:00:00") {
                            Mysnack(req, pleaseselecttotalduration, context);
                          } else if (_mivsctrl.snoozetime.value == "00:00:00") {
                            Mysnack(req, pleaseselectsnoozeduration, context);
                          } else {
                            _mivsctrl.AddMIVStime(context);
                          }

                          // nextscreen(context, PendingTimer());
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ButtonWidget(
                        name: reset,
                        issmall: true,
                        txtstyle: MyTextStyle.mw40020,
                        borderRadius: 15.0,
                        onTap: () {
                          _mivsctrl.clerdata();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingOnly(
              left: 15,
              right: 15,
              bottom: NeumorphicTheme.isUsingDark(context) ? 15 : 0),
        ),
      ),
    );
  }

  setShowpicker() async {
    var result;
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedTime != null) {
      print("pciked time" + pickedTime.toString());
      DateTime date = DateTime.now();
      String second = date.second.toString().padLeft(2, '0');
      print("second" + second.toString());
      List timeSplit = pickedTime.format(context).split(' ');
      String formattedTime = timeSplit[0];
      String time = '$formattedTime:$second';
      String type = '';

      if (timeSplit.length > 1) {
        type = timeSplit[1];
        time = '$time $type';
      }
      result = time;
    } else {
      print("Time is not selected");
    }
    print("result" + result.toString());
    return result == null ? "00:00:00" : result;
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
