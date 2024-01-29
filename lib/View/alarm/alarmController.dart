import 'dart:math';
import 'package:clockalarm/Config/Import.dart';

class AlramController extends GetxController {
  var alarms = <AlarmSettings>[].obs;
  var switchlist = [].obs;
  var currenttime = "".obs;
  var currentsound = "".obs;
  var currentsoundpath = "".obs;
  var alarmisloading = false.obs;
  var getalarmisloading = false.obs;
  var box = GetStorage();

  setAlarm(time, snooze, audio, BuildContext context) {
    print("dateTime" + time.toString());
    final alarmSettings = AlarmSettings(
        id: Random().nextInt(100),
        dateTime: time,
        assetAudioPath: audio,
        loopAudio: snooze,
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

      //insert to firebase
    }).then((value) {
      //get data of firebase
    });
  }

  alramstatus(uid, status) async {
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
  }

  getalram() async {
    getalarmisloading.value = true;
    switchlist.value = [];
    alarms.value = Alarm.getAlarms();
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('alarm').get();
    final int documents = qSnap.docs.length;
    print("documents length" + documents.toString());
    switchlist.value = List.filled(documents, true);
    print("alarams" + alarms.toString());
    alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    getalarmisloading.value = false;
  }

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
}
