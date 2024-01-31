import 'dart:convert';
import 'dart:developer';
import 'package:clockalarm/Config/FireBase/Model/Notificationmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Sendnotification {
  Future<int> notification(Notifier notifier) async {
    var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "key=${dotenv.env['serverkey']}"
    };
    final response = await http.post(url,
        body: jsonEncode(notifier.toJson()), headers: header);
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse != null) {
      print("notification sent successfully");
    } else {
      print("something went wrong");
    }
    return jsonResponse["success"];
  }

  String SendNotification(title, body, doctorTokenId, Senderid, Receiverid, Msg,
      Time, PostId, PostImage) {
    notification(
      Notifier(
        to: doctorTokenId,
        notification:
            Notifications(body: body, sound: '', tag: '', title: title),
        data: Datas(
          postid: PostId,
          postimage: PostImage,
          senderid: Senderid,
          receiverid: Receiverid,
          msg: Msg,
          time: Time,
        ),
      ),
    ).then((value) async {
      print("data post successfully:");
      if (value != 0) {
        try {
          var notifydata = {
            'senderid': Senderid,
            'receiverid': Receiverid,
            'msg': Msg,
            'time': Time,
            'postid': PostId,
            'postimage': PostImage,
          };
          await FirebaseFirestore.instance
              .collection("notificationlist")
              .add(notifydata)
              .then((value) {
            log("Notification Data==> " + value.id.toString());
          });
        } on Exception catch (e) {
          log("Add Notification Error ==>" + e.toString());
        }
      }
    });
    return doctorTokenId;
  }
}
