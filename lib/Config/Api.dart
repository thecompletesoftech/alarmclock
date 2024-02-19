import 'dart:developer';
import 'dart:io';
import 'package:clockalarm/Config/Import.dart';

class ApiHelper {
  var db = FirebaseFirestore.instance;
  var uid = GetStorage().read('uid');
  Future Api() async {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  }

  Future AddCollection(collectionname, data) async {
    await db.collection(collectionname).add(data).then((value) async {
      log("values" + value.id.toString());
      var updatedata = {'id': value.id};
      Updatedata(collectionname, value.id, updatedata);
    });
    return;
  }

  Updatedata(collectionname, docid, updatejson) {
    db.collection(collectionname).doc(docid).update(updatejson);
    return;
  }

  Future whereCollection(collectionname, key, val) async {
    var data = await db
        .collection(collectionname)
        .where('uid', isEqualTo: uid)
        .where(key, isEqualTo: val)
        .get();
    return data.docs;
  }

  getdatabyuserid(collectionname) async {
    var data =
        await db.collection(collectionname).where("uid", isEqualTo: uid).get();
    return data;
  }

  Stream<QuerySnapshot> getsnapshotbyuserid(collectionname) async* {
    var data = await db
        .collection(collectionname)
        .where("uid", isEqualTo: uid)
        .snapshots();
    yield* data;
  }

  Stream<QuerySnapshot> getsnapshotbyorderbyuserid(
      collectionname, field, des) async* {
    var data = await db
        .collection(collectionname)
        .where("uid", isEqualTo: uid)
        .orderBy(field, descending: des)
        .snapshots();
    yield* data;
  }

  Future deletedata(collectionname, data) async {
    await db.collection(collectionname).doc(data).delete();
    return;
  }
}
