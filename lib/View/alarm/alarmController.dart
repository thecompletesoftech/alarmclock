import 'dart:math';
import 'package:clockalarm/Config/Import.dart';

class AlramController extends GetxController {
  var alarms = <AlarmSettings>[].obs;
  var switchlist = [].obs;
  var currenttime = "".obs;
  var currentsound = "".obs;
  var alarmisloading = false.obs;
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
          snooze, audio, context);

      //insert to firebase
    }).then((value) {
      //get data of firebase
    });
  }

  getalram() async {
    print("dashkjas");
    switchlist.value = [];
    alarms.value = Alarm.getAlarms();
    final int documents =
        await FirebaseFirestore.instance.collection('alarm').snapshots().length;
    print("documents length" + documents.toString());
    switchlist.value = List.filled(documents, true);
    print(alarms.toString());
    alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
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

  AddAlramtime(dateTime, snooze, audio, cntx) {
    alarmisloading.value = true;
    var uid = box.read('uid');

    var alramdata = {
      "uid": uid,
      "id": Random().nextInt(100),
      "dateTime": dateTime,
      "assetAudioPath": audio,
      "loopAudio": snooze,
      "vibrate": true,
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
