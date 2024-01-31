import 'dart:math';
import 'package:clockalarm/Config/Import.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AlramController extends GetxController {
  var alarms = <AlarmSettings>[].obs;
  var switchlist = [].obs;
  var currenttime = "".obs;
  var currentsound = "".obs;
  var currentsoundpath = "".obs;
  var alarmisloading = false.obs;
  var getalarmisloading = false.obs;
  var addalarmisloading = false.obs;
  var box = GetStorage();

  setAlarm(time, snooze, audio, BuildContext context) {
    addalarmisloading.value = true;
    print("dateTime" + time.toString());
    final alarmSettings = AlarmSettings(
        id: Random().nextInt(100),
        dateTime: time,
        assetAudioPath: audio,
        loopAudio: true,
        vibrate: true,
        // volumeMax: true,
        fadeDuration: 3.0,
        notificationTitle: 'Alarm is Playing',
        notificationBody: 'Tap to stop',
        enableNotificationOnKill: true,
        // stopOnNotificationOpen: true,
        androidFullScreenIntent: true);
    Alarm.set(alarmSettings: alarmSettings).then((value) async {
      await AddAlramtime(time.hour.toString() + ":" + time.minute.toString(),
          time.toString(), snooze, audio, context);
      addalarmisloading.value = false;
      //insert to firebase
    }).then((value) {
      addalarmisloading.value = false;
      //get data of firebase
    });
  }

  setalarmfalse() async {
    DateTime now = DateTime.now();
    var uid = box.read('uid');
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection("alarm")
        .where("uid", isEqualTo: uid)
        .get();
    if (_querySnapshot.docs.isNotEmpty) {
      for (var i = 0; i < _querySnapshot.docs.length; i++) {
        print("index" + i.toString());
        print("-----------------------------------");
        if (DateTime.parse(_querySnapshot.docs[i]['date']).compareTo(now) < 0) {
          print("before-----");
          FirebaseFirestore.instance
              .collection("alarm")
              .doc(_querySnapshot.docs[i].id)
              .update({"alarmstatus": false});
        }
      }
      // _querySnapshot.docs.map((element) async {
      //   var index = _querySnapshot.docs.indexOf(element);

      // });
    }
  }

  alramstatus(uid, status, cntx) async {
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection("alarm")
        .where("id", isEqualTo: uid)
        .get();
    if (_querySnapshot.docs.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("alarm")
          .doc(_querySnapshot.docs[0].id)
          .update({"alarmstatus": status});
      print(_querySnapshot.docs[0].id.toString());
    }
    clearalramlist();
    await setalarmfalse();
    await setstorealramtolocal(cntx);
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('alarm')
        .where("uid", isEqualTo: box.read('uid'))
        .get();
    final int documents = qSnap.docs.length;
    print("documents length" + documents.toString());
  }

  getalram(cntx) async {
    getalarmisloading.value = true;
    clearalramlist();
    await setalarmfalse();
    await setstorealramtolocal(cntx);
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('alarm')
        .where("uid", isEqualTo: box.read('uid'))
        .get();
    final int documents = qSnap.docs.length;
    print("documents length" + documents.toString());
    getalarmisloading.value = false;
  }

  clearalramlist() async {
    var alarms = await Alarm.getAlarms();
    print("alarams" + alarms.toString());
    for (var i = 0; i < alarms.length; i++) {
      Alarm.stop(alarms[i].id);
    }
  }

  // scheduleNotification(
  //     {int id = 0,
  //     String? title,
  //     String? body,
  //     String? payLoad,
  //     required DateTime scheduledNotificationDateTime}) async {
  //   return FlutterLocalNotificationsPlugin().zonedSchedule(
  //       id,
  //       title,
  //       body,
  //       tz.TZDateTime.from(
  //         scheduledNotificationDateTime,
  //         tz.local,
  //       ),
  //       await notificationDetails(),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  // Future<void> scheduleRepeatingAlarm() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'repeating_channel_id',
  //     'Repeating Channel Name',
  //     'Repeating Channel Description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     enableVibration: true,
  //   );
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);

  //   // Schedule the repeating alarm
  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     0,
  //     'Repeating Alarm Title',
  //     'Repeating Alarm Body',
  //     RepeatInterval.hourly,
  //     platformChannelSpecifics,
  //     payload: 'Repeating Alarm Payload',
  //   );
  // }

  AddAlramtime(dateTime, date, snooze, audio, cntx) {
    alarmisloading.value = true;
    var uid = box.read('uid');
    var alramdata = {
      "uid": uid,
      "id": Random().nextInt(100),
      "dateTime": dateTime,
      "date": date,
      "assetAudioPath": audio,
      "loopAudio": snooze,
      "vibrate": true,
      "alarmstatus": true,
      "fadeDuration": 3.0,
      "notificationTitle": 'Alarm is Playing',
      "notificationBody": 'Tap to stop',
      "enableNotificationOnKill": true,
      "androidFullScreenIntent": true
    };
    // log("UserDetail" + userdata.toString());
    try {
      FirebaseFirestore.instance
          .collection("alarm")
          .add(alramdata)
          .then((value) {
        // log("values" + value.id.toString());

        alarmisloading.value = false;
      });
    } on Exception catch (e) {
      // log("Add WorldClock Error ==>" + e.toString());
      alarmisloading.value = false;
      Mysnack(retry, e, cntx);
    }
  }

  setstorealramtolocal(cntx) async {
    clearalramlist();
    var uid = box.read('uid');
    print("uid" + uid.toString());
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection("alarm")
        .where("uid", isEqualTo: uid)
        .get();
    _querySnapshot.docs.forEach((element) async {
      if (element['alarmstatus'] == true) {
        print("insert -------------------");
        final alarmSettings = AlarmSettings(
            id: element['id'],
            dateTime: DateTime.parse(element['date']),
            assetAudioPath: element['assetAudioPath'],
            loopAudio: true,
            vibrate: true,
            // volumeMax: true,
            fadeDuration: 3.0,
            notificationTitle: 'Alarm is Playing',
            notificationBody: 'Tap to stop',
            enableNotificationOnKill: true,
            // stopOnNotificationOpen: true,
            androidFullScreenIntent: true);
        await Alarm.set(alarmSettings: alarmSettings).then((value) async {
          print("alarm set to local");
          //insert to firebase
        }).then((value) {});
      }
    });
    alarms.value = await Alarm.getAlarms();
    print("alarams" + alarms.toString());
  }
}
