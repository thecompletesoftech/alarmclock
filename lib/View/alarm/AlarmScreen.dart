import 'dart:io';
import 'dart:math';

import 'package:alarmplayer/alarmplayer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockalarm/Widgets/ButtonWidget.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../Config/Import.dart';

class AlarmScreen extends StatefulWidget {
  final id;
  final data;
  final Function? onsnoozeTap;
  const AlarmScreen({
    Key? key,
    this.data,
    this.onsnoozeTap,
    this.id,
  }) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  Alarmplayer alarmplayer = Alarmplayer();
  @override
  void initState() {
    alarmplayer.Alarm(
      url: widget.data['assets'].toString(), // Path of sound file.
      volume: 1, // optional, set the volume, default 1.
      looping: true, // optional, if you want to loop you're alarm or not
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');
    final snoozeTimes = [
      2,
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
            SizedBox(height: 20),
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
                              'Alarm',
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
                                'Alarm',
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
            SizedBox(height: 45),
            if (bool.parse(widget.data['snooze'].toString()) == true)
              GestureDetector(
                onTap: () async {
                  // await rescheduleAlarm(5);
                },
                child: Text(
                  'Snooze',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: NeumorphicTheme.accentColor(context)),
                ),
              ),
            if (bool.parse(widget.data['snooze'].toString()) == true)
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
                              await snooze(widget.id, widget.data, minutes);
                              await alarmplayer.StopAlarm();
                              AwesomeNotifications().dismiss(widget.id);
                              exit(0);
                            },
                          ).paddingSymmetric(
                              horizontal: NeumorphicTheme.isUsingDark(context)
                                  ? 10
                                  : 0),
                        ))
                    .toList(),
              ),
            SizedBox(height: 45),
            ButtonWidget(
                name: "Dismiss",
                onTap: () async {
                  alarmplayer.StopAlarm();
                  AwesomeNotifications().cancel(widget.id);
                  AwesomeNotifications().dismiss(widget.id);
                  exit(0);
                }),
          ],
        ),
      ),
    );
  }

  add5Minutes({mins = 5}) {
    DateTime currentTime = DateTime.now();
    DateTime updatedTime = currentTime.add(Duration(minutes: mins));
    String formattedTime = updatedTime.toString();
    DateTime newtime = DateTime.parse(formattedTime);
    return newtime;
  }

  snooze(notid, data, mins) async {
    print("datata===> " + data.toString());
    print("datata===> " + mins.toString());
    var updatedTime = add5Minutes(mins: mins);
    await shownotification(notid, data['sound'],
        bool.parse(data['snooze'].toString()), updatedTime, data['assets']);
  }

  shownotification(notid, soundname, snooze, dateTime, soundassets) async {
    DateTime currentTime = DateTime.now();
    await AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
      NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: false,
          importance: NotificationImportance.Max,
          enableVibration: true,
          playSound: false,
          soundSource: soundname),
    ]);
    bool isallowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isallowed) {
      print("object===>>>>>>>>>>");
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      print('entererr' + dateTime.toString());
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(9999),
              channelKey: 'basic', //set configuration wuth key "basic"
              title: 'Alarm is playing',
              body: '',
              payload: {
                "name": "FlutterCampus",
                "currentTime": currentTime.toString(),
                "sound": soundname.toString(),
                "assets": soundassets.toString(),
                "snooze": snooze.toString()
              },
              autoDismissible: false,
              customSound: soundname,
              displayOnForeground: true,
              wakeUpScreen: true,
              fullScreenIntent: true),
          schedule: NotificationCalendar.fromDate(
              date: dateTime, preciseAlarm: true, repeats: true),
          actionButtons: snooze
              ? [
                  NotificationActionButton(
                      key: "stop",
                      label: "Stop alram",
                      actionType: ActionType.SilentBackgroundAction),
                  NotificationActionButton(
                    key: "snooze",
                    label: "Snooze",
                  )
                ]
              : [
                  NotificationActionButton(
                      key: "stop",
                      label: "Stop alram",
                      actionType: ActionType.SilentBackgroundAction),
                ]);
    }
  }
}
