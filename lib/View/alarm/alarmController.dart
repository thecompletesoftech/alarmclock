import 'dart:math';
import 'package:clockalarm/Config/Import.dart';

class AlramController extends GetxController {
  var alarms = <AlarmSettings>[].obs;
  var switchlist = [].obs;
  var currenttime = "".obs;
  var currentsound = "".obs;
  var alarmisloading = false.obs;
  var box = GetStorage();

  setAlarm(TimeOfDay time, snooze, BuildContext context) {
    final timeOfDay = time;
    final nextDay = DateTime.now().add(const Duration(days: 1));
    var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, timeOfDay.hour, timeOfDay.minute);
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = nextDay;
    }
    final alarmSettings = AlarmSettings(
        id: Random().nextInt(100),
        dateTime: dateTime,
        assetAudioPath: 'assets/ImmigrantSong.mp3',
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
      await AddAlramtime(dateTime, snooze, 'assets/ImmigrantSong.mp3', context);
      //insert to firebase
    }).then((value) {
      //get data of firebase
    });
  }

  getalram() {
    switchlist.value = [];
    alarms.value = Alarm.getAlarms();
    switchlist.value = List.filled(alarms.length, true);
    print(alarms.toString());
    alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
  }

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
