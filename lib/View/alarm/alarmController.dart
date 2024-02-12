import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockalarm/Config/Import.dart';

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
        assetAudioPath: "assets/ringtone/ImmigrantSong.mp3+",
        loopAudio: true,
        volume: 0.0,
        vibrate: false,
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
      print("time to" + time.toString());
      shownotification(audio, snooze, DateTime.parse(time.toString()));
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

  shownotification(soundname, snooze, dateTime) async {
    DateTime currentTime = DateTime.now();
    await AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
      // notification icon
      NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: false,
          importance: NotificationImportance.High,
          enableVibration: true,
          playSound: true,
          soundSource: soundname),
    ]);
    bool isallowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isallowed) {
      print("object===>>>>>>>>>>");
      //no permission of local notification
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      //show notification
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 123,
              channelKey: 'basic', //set configuration wuth key "basic"
              title: 'Alarm is playing',
              body: '',
              payload: {
                "name": "FlutterCampus",
                "currentTime": currentTime.toString(),
                "sound": soundname.toString(),
                "snooze": snooze.toString()
              },
              autoDismissible: false,
              customSound: soundname),
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
