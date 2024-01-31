import 'dart:developer';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:timezone/timezone.dart' as tz;

class WorldController extends GetxController {
  final searchlist = [].obs;
  final WorldClocklist = [].obs;
  final currentcitytime = [].obs;
  var box = GetStorage();
  var addclockloading = false.obs;
  var db = FirebaseFirestore.instance;
  setup(location, cntx) async {
    var istanbulTimeZone = tz.getLocation(location);
    var now = tz.TZDateTime.now(istanbulTimeZone);
    log("ddhs------> " + now.millisecondsSinceEpoch.toString());
    AddWorldtime(location, cntx);
  }

  AddWorldtime(location, cntx) {
    addclockloading.value = true;
    var uid = box.read('uid');
    var userdata = {
      'id': '',
      'uid': uid,
      'placename': location,
    };
    log("UserDetail" + userdata.toString());
    try {
      ApiHelper()
          .whereCollection('worldclocklist', 'placename', location)
          .then((value) {
        if (value < 1) {
          ApiHelper().AddCollection("worldclocklist", userdata).then((value) {
            Navigator.pop(cntx);
          });
        } else {
          Mysnack(retry, alreadyaddedclock, cntx);
        }
        addclockloading.value = false;
      });
    } on Exception catch (e) {
      log("Add WorldClock Error ==>" + e.toString());
      addclockloading.value = false;
      Mysnack(retry, e, cntx);
    }
  }

  gettime(location) {
    var istanbulTimeZone = tz.getLocation(location);
    var now = tz.TZDateTime.now(istanbulTimeZone);
    return now;
  }
}
