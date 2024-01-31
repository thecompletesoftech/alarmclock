import 'dart:developer';
import 'dart:io';
import 'package:clockalarm/Config/Import.dart';

class ApiHelper {
  var db = FirebaseFirestore.instance;
  Future Api() async {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  }

  Future AddCollection(collectionname, data) async {
    await db.collection(collectionname).add(data).then((value) async {
      log("values" + value.id.toString());
      AddDocid(collectionname, value.id);
    });
    return;
  }

  AddDocid(collectionname, docid) {
    db.collection(collectionname).doc(docid).update({'id': docid});
    return;
  }

  Future whereCollection(collectionname, key, val) async {
    var data =
        await db.collection(collectionname).where(key, isEqualTo: val).get();
    return data.docs.length;
  }

  getdatabyuserid(collectionname, uid) async {
    var data =
        await db.collection(collectionname).where("uid", isEqualTo: uid).get();
    return data;
  }
}
