import 'dart:developer';

import 'package:clockalarm/Config/Import.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class WorldController extends GetxController {
  final searchlist = [].obs;
  final WorldClocklist = [].obs;
  final currentcitytime = [].obs;
  var box = GetStorage();
  var addclockloading = false.obs;
  setup(location, cntx) async {
    var istanbulTimeZone = tz.getLocation(location);
    var now = tz.TZDateTime.now(istanbulTimeZone);
    var add = currentcitytime
        .where((element) => element['name'] == location)
        .toList();
    if (add.length < 1) {
      currentcitytime.add({'name': location, 'time': now});
      AddWorldtime(location, now, cntx);
    } else {
      Mysnack(retry, alreadyaddedclock, cntx);
    }
  }
  setups(location, cntx) async {
    var istanbulTimeZone = tz.getLocation(location);
    var now = tz.TZDateTime.now(istanbulTimeZone);
    var add = currentcitytime
        .where((element) => element['name'] == location)
        .toList();
    if (add.length < 1) {
      currentcitytime.add({'name': location, 'time': now});
      // AddWorldtime(location, now, cntx);
    } else {
      Mysnack(retry, alreadyaddedclock, cntx);
    }
  }

  AddWorldtime(location, time, cntx) {
    addclockloading.value = true;
    var uid = box.read('uid');
    var userdata = {
      'uid': uid,
      'placename': location,
      'time': time,
    };
    log("UserDetail" + userdata.toString());
    try {
      FirebaseFirestore.instance
          .collection("worldclocklist")
          .add(userdata)
          .then((value) {
        // log("values" + value.id.toString());
        Navigator.pop(cntx);
        addclockloading.value = false;
      });
    } on Exception catch (e) {
      log("Add WorldClock Error ==>" + e.toString());
      addclockloading.value = false;
      Mysnack(retry, e, cntx);
    }
  }
}
