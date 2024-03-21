import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockalarm/Config/Import.dart';

class AlramController extends GetxController {
  var alarms = <AlarmSettings>[].obs;
  var switchlist = [].obs;
  var selectedweekdaylist = [].obs;
  var alramlist = [
    {"id": "7", "title": "Sunday"},
    {"id": "1", "title": "Monday"},
    {"id": "2", "title": "Tuesday"},
    {"id": "3", "title": "Wednesday"},
    {"id": "4", "title": "Thursday"},
    {"id": "5", "title": "Friday"},
    {"id": "6", "title": "Saturday"}
  ].obs;
  var currenttime = "".obs;
  var currentsound = "".obs;
  var currentsoundpath = "".obs;
  var currentsoundassets = "".obs;
  var alarmisloading = false.obs;
  var getalarmisloading = false.obs;
  var addalarmisloading = false.obs;
  var box = GetStorage();

  setAlarm(time, snooze, audio, BuildContext context) async {
    addalarmisloading.value = true;
    print("dateTime" + time.toString());
    var notid = Random().nextInt(9999);
    await AddAlramtime(
        notid,
        time.hour.toString() + ":" + time.minute.toString(),
        time.toString(),
        snooze,
        audio,
        context);
    shownotification(notid, audio, snooze, DateTime.parse(time.toString()));
    addalarmisloading.value = false;
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
        if (DateTime.parse(_querySnapshot.docs[i]['date']).compareTo(now) < 0) {
          if (_querySnapshot.docs[i]['repeat'] != true) {
            FirebaseFirestore.instance
                .collection('alarm')
                .doc(_querySnapshot.docs[i].id)
                .delete();
            AwesomeNotifications().cancel(_querySnapshot.docs[i]['id']);
            // FirebaseFirestore.instance
            //     .collection("alarm")
            //     .doc(_querySnapshot.docs[i].id)
            //     .update({"alarmstatus": false});
          }
        }
      }
    }
  }

  alramstatus(id, status, cntx) async {
    print("staaa" + status.toString());
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection("alarm")
        .where("id", isEqualTo: id)
        .get();
    if (_querySnapshot.docs.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("alarm")
          .doc(_querySnapshot.docs[0].id)
          .update({"alarmstatus": status});
      if (status == false) {
        AwesomeNotifications().cancel(id);
      } else {
        await reschedule(_querySnapshot.docs[0].id);
      }
    }
    await setalarmfalse();
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('alarm')
        .where("uid", isEqualTo: box.read('uid'))
        .get();
    final int documents = qSnap.docs.length;
    print("documents length" + documents.toString());
  }

  reschedule(id) async {
    await FirebaseFirestore.instance
        .collection("alarm")
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? data = value.data();
        if (data != null)
          shownotification(data['id'], data['assetAudioPath'], data['snooze'],
              DateTime.parse(data['date'].toString()));
      }
    });
  }

  AddAlramtime(notid, dateTime, date, snooze, audio, cntx) {
    alarmisloading.value = true;
    var uid = box.read('uid');
    var alramdata = {
      "uid": uid,
      "id": notid,
      'docid': '',
      "dateTime": dateTime,
      "date": date,
      "assetAudioPath": audio,
      "snooze": snooze,
      "alarmstatus": true,
      'repeat': selectedweekdaylist.length > 0 ? true : false,
      "notificationTitle": 'Alarm is Playing',
      "notificationBody": '',
    };
    try {
      FirebaseFirestore.instance
          .collection("alarm")
          .add(alramdata)
          .then((value) {
        FirebaseFirestore.instance
            .collection("alarm")
            .doc(value.id)
            .update({'docid': value.id});
        alarmisloading.value = false;
      });
    } on Exception catch (e) {
      // log("Add WorldClock Error ==>" + e.toString());
      alarmisloading.value = false;
      Mysnack(retry, e, cntx);
    }
  }

  shownotification(notid, soundname, snooze, dateTime) async {
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
          playSound: false,
          soundSource: soundname),
    ]);
    bool isallowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isallowed) {
      print("object===>>>>>>>>>>");
      //no permission of local notification
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      print("LENGTHHHHHHHHHHHHHH=> " + selectedweekdaylist.toString());
      selectedweekdaylist.length > 0
          ? Sendnotification(notid, soundname, snooze, dateTime)
          : AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: notid,
                  channelKey: 'basic', //set configuration wuth key "basic"
                  title: 'Alarm is playing....',
                  body: '',
                  payload: {
                    "name": "FlutterCampus",
                    "currentTime": currentTime.toString(),
                    "sound": soundname.toString(),
                    "assets": currentsoundassets.toString(),
                    "snooze": snooze.toString()
                  },
                  autoDismissible: false,
                  customSound: soundname,
                  displayOnForeground: true,
                  wakeUpScreen: true,
                  fullScreenIntent: true),
              actionButtons: snooze
                  ? [
                      NotificationActionButton(
                          key: "stop",
                          label: "Stop alarm",
                          actionType: ActionType.SilentBackgroundAction),
                      NotificationActionButton(
                          key: "snooze",
                          label: "Snooze",
                          actionType: ActionType.SilentBackgroundAction)
                    ]
                  : [
                      NotificationActionButton(
                          key: "stop",
                          label: "Stop alarm",
                          actionType: ActionType.SilentBackgroundAction),
                    ],
              schedule: NotificationCalendar.fromDate(
                  date: dateTime, preciseAlarm: true, repeats: true));
    }
  }

  Sendnotification(notid, soundname, snooze, dateTime) {
    DateTime currentTime = DateTime.now();
    for (var i = 0; i < selectedweekdaylist.length; i++) {
      print("Alarm Day" +
          dateTime.toString() +
          '---' +
          selectedweekdaylist[i].toString());
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notid,
              channelKey: 'basic', //set configuration wuth key "basic"
              title: 'Alarm is playing....',
              body: '',
              payload: {
                "name": "FlutterCampus",
                "currentTime": currentTime.toString(),
                "sound": soundname.toString(),
                "assets": currentsoundassets.toString(),
                "snooze": snooze.toString()
              },
              autoDismissible: false,
              customSound: soundname,
              displayOnForeground: true,
              wakeUpScreen: true,
              fullScreenIntent: true),
          actionButtons: snooze
              ? [
                  NotificationActionButton(
                      key: "stop",
                      label: "Stop alarm",
                      actionType: ActionType.SilentBackgroundAction),
                  NotificationActionButton(
                      key: "snooze",
                      label: "Snooze",
                      actionType: ActionType.SilentBackgroundAction)
                ]
              : [
                  NotificationActionButton(
                      key: "stop",
                      label: "Stop alarm",
                      actionType: ActionType.SilentBackgroundAction),
                ],
          schedule: NotificationCalendar(
            repeats: true,
            weekday: int.parse(selectedweekdaylist[i].toString()),
            hour: dateTime.hour,
            minute: dateTime.minute,
            second: 0,
            millisecond: 0,
            allowWhileIdle: true,
            preciseAlarm: true,
          ));
    }
    selectedweekdaylist.clear();
  }
}
