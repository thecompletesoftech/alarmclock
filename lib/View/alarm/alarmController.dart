import 'dart:math';
import 'package:clockalarm/Config/Import.dart';

class AlramController extends GetxController {
  var alarms = <AlarmSettings>[].obs;
  var switchlist = [].obs;
  var currenttime = "".obs;
  var currentsound = "".obs;
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
        assetAudioPath: 'assets/ringtone/immigrate.mp3',
        loopAudio: snooze,
        vibrate: true,
        // volumeMax: true,
        fadeDuration: 3.0,
        notificationTitle: 'Alarm is Playing',
        notificationBody: 'Tap to stop',
        enableNotificationOnKill: true,
        // stopOnNotificationOpen: true,
        androidFullScreenIntent: true);
    Alarm.set(alarmSettings: alarmSettings).then((value) {
      print(value.toString());

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
}
