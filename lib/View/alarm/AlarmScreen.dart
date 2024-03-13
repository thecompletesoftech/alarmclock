import 'package:clockalarm/Config/Color.dart';
import 'package:clockalarm/Widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../Config/Import.dart';
import '../../main.dart';

class AlarmScreen extends StatelessWidget {
  // final ObservableAlarm? alarm;

  const AlarmScreen({
    Key? key,
    // required this.alarm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    final now = DateTime.now();
    final format = DateFormat('Hm');
    final snoozeTimes = [
      5,
      10,
      15,
    ];
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: NeumorphicTheme.isUsingDark(context)
                  ? Container(
                      height: 250,
                      width: 250,
                      decoration: Utils().decoration(
                          cntx: context,
                          isdark: NeumorphicTheme.isUsingDark(context),
                          radius: 250.0 * fem),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.alarm,
                            color: NeumorphicTheme.accentColor(context),
                            size: 32,
                          ),
                          Text(
                            format.format(now),
                            style: TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.w900,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                          Container(
                            width: 250,
                            child: Text(
                              'alarm!.name',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: NeumorphicTheme.accentColor(context),
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/stopwatch.png", height: 250),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.alarm,
                              color: NeumorphicTheme.accentColor(context),
                              size: 32,
                            ),
                            Text(
                              format.format(now),
                              style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.w900,
                                  color: NeumorphicTheme.accentColor(context)),
                            ),
                            Container(
                              width: 250,
                              child: Text(
                                'alarm!.name',
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: NeumorphicTheme.accentColor(context),
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: 45,
            ),
            GestureDetector(
              onTap: () async {
                await rescheduleAlarm(5);
              },
              child: Text(
                'Snooze',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: NeumorphicTheme.accentColor(context)),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: snoozeTimes
                  .map((minutes) => Expanded(
                        child: ButtonWidget(
                          name: "+$minutes\m",
                          issmall: true,
                          // fontSize: 24,
                          onTap: () async {
                            await rescheduleAlarm(minutes);
                          },
                        ).paddingSymmetric(
                            horizontal:
                                NeumorphicTheme.isUsingDark(context) ? 10 : 0),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 45,
            ),
            ButtonWidget(
                name: "Dismiss",
                onTap: () async {
                  await dismissCurrentAlarm();
                }),
          ],
        ),
      ),
    );
  }

  Future<void> dismissCurrentAlarm() async {
    // mediaHandler.stopMusic();
    // Wakelock.disable();

    // AlarmStatus().isAlarm = false;
    // AlarmStatus().alarmId = -1;
    SystemNavigator.pop();
  }

  Future<void> rescheduleAlarm(int minutes) async {
    // Re-schedule alarm
    // var checkedDay = DateTime.now();
    // var targetDateTime = DateTime(checkedDay.year, checkedDay.month,
    //     checkedDay.day, alarm!.hour!, alarm!.minute!);
    // await AlarmScheduler()
    //     .newShot(targetDateTime.add(Duration(minutes: minutes)), alarm!.id!);
    dismissCurrentAlarm();
  }
}
