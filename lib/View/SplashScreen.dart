import 'dart:async';
import 'dart:math';

import 'package:alarmplayer/alarmplayer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockalarm/View/alarm/AlarmScreen.dart';
import 'package:flutter/services.dart';

import '../Config/Import.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box = GetStorage();
  Alarmplayer alarmplayer = Alarmplayer();
  void initState() {
    print("Splash ENTER==>");
    Timer(
      Duration(seconds: 5),
      () => nextscreenwithoutback(
          context, box.read('uid') != null ? NewBottomNavigator() : SignIn()),
    );
    super.initState();
  }

  Future<dynamic> notification() async {
    var data = false;
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction) async {},
        onNotificationCreatedMethod:
            (ReceivedNotification receivedNotification) async {},
        onNotificationDisplayedMethod:
            (ReceivedNotification receivedNotification) async {
          print("object" + receivedNotification.toString());
          if (receivedNotification.payload != null) {
            Get.to(() => AlarmScreen(
                  data: receivedNotification,
                  onsnoozeTap: (val) {
                    print("checkkkkkkkkkkk" + val.toString());
                    snooze(receivedNotification, val);
                  },
                ));
            data = true;
          }
        },
        onDismissActionReceivedMethod:
            (ReceivedAction receivedAction) async {});
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: NeumorphicTheme.isUsingDark(context)
              ? Image.asset("assets/Lighttival.gif")
              : Image.asset("assets/DarkTival.gif")),
    );
  }

  add5Minutes(String timeString, {mins = 5}) {
    DateTime currentTime = DateTime.parse(timeString);
    DateTime updatedTime = currentTime.add(Duration(minutes: mins));
    String formattedTime = updatedTime.toString();
    DateTime newtime = DateTime.parse(formattedTime);
    return newtime;
  }

  snooze(data, mins) {
    var updatedTime =
        add5Minutes(data.payload!['currentTime'].toString(), mins: mins);
    shownotification(
        data.payload!['sound'],
        bool.parse(data.payload!['snooze'].toString()),
        updatedTime,
        data.payload!['assets']);
  }

  shownotification(soundname, snooze, dateTime, soundassets) async {
    DateTime currentTime = DateTime.now();
    await AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
      // notification icon
      NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: false,
          importance: NotificationImportance.Max,
          enableVibration: true,
          playSound: true,
          onlyAlertOnce: false,
          soundSource: soundname),
    ]);
    bool isallowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isallowed) {
      print("object===>>>>>>>>>>");
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(999),
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
              fullScreenIntent: true),
          schedule: NotificationCalendar.fromDate(date: dateTime),
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
