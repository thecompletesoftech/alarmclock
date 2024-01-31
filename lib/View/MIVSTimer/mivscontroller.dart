import 'dart:convert';
import 'dart:developer';

import 'package:clockalarm/Config/Import.dart';

import '../../Config/Api.dart';

class Mivsctrl extends GetxController {
  var snoozetime = "00:00:00".obs;
  var totalduration = "00:00:00".obs;
  var intervalend = "00:00:00".obs;
  var intervalduration = "00:00:00".obs;
  TextEditingController timename = TextEditingController();
  TextEditingController repeatinverval = TextEditingController();
  var mivstime = false.obs;
  var box = GetStorage();

  clerdata() {
    snoozetime.value = "00:00:00";
    totalduration.value = "00:00:00";
    intervalend.value = "00:00:00";
    intervalduration.value = "00:00:00";
  }

  AddMIVStime(cntx) {
    mivstime.value = true;
    var uid = box.read('uid');
    var userdata = {
      'id': '',
      'uid': uid,
      'timename': timename.text,
      'repeateinterval': repeatinverval.text,
      'intervalDuration': totalduration.value,
      'intervalEnd': intervalend.value,
      'totalDuration': totalduration.value,
      'snoozeDuration': snoozetime.value,
    };
    print("UserDetail" + userdata.toString());
    try {
      ApiHelper().AddCollection("mivstime", userdata).then((value) {
        Navigator.pop(cntx);
      });
      mivstime.value = false;
    } on Exception catch (e) {
      log("Add WorldClock Error ==>" + e.toString());
      mivstime.value = false;
      Mysnack(retry, e, cntx);
    }
  }

  getmivstime(cntx) {
    var uid = box.read('uid');
    try {
      ApiHelper().getdatabyuserid("mivstime", uid).then((value) {
        value.docs.forEach((element) async {
          var index = value.docs.indexOf(element);

          // FirebaseFirestore.instance
          //     .collection("alarm")
          //     .doc(_querySnapshot.docs[index].id)
          //     .update({"alarmstatus": false});
        });
        // print("esfes" + value.docs.toString());
      });
      mivstime.value = false;
    } on Exception catch (e) {
      log("Add WorldClock Error ==>" + e.toString());
      mivstime.value = false;
      Mysnack(retry, e, cntx);
    }
  }
}
