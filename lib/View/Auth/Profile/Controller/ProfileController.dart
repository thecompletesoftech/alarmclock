import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/alarm/AlarmScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../main.dart';

class ProfileController extends GetxController {
  var dataa = {}.obs;
  final nameContoller = TextEditingController();
  final password = TextEditingController();
  var selectimage;
  var darktheme = (box.read('isdark') == true ? true : false).obs;
  var profileloading = false.obs;
  Future<String> uploadImage(imageFile) async {
    String fileName = (imageFile.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => print('Upload complete'));
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  getimageurl(cntx) async {
    try {
      profileloading.value = true;
      var userdata = await ApiHelper().getdatabyuserid('users');
      print("message==> " + userdata.docs[0]['id'].toString());
      String downloadURL = selectimage != null
          ? await uploadImage(File(selectimage!))
          : userdata.docs[0]['image'].toString();
      print('Image uploaded. Download URL: $downloadURL');
      editprofile(cntx, downloadURL, userdata.docs[0]);
    } catch (e) {
      profileloading.value = false;
    }
  }

  editprofile(cntx, imageurl, userdata) async {
    var updatedata = {
      "image": imageurl.toString(),
      "name": nameContoller.text.isEmpty
          ? userdata['name']
          : nameContoller.text.toString()
    };
    await ApiHelper().Updatedata('users', userdata['id'], updatedata);
    profileloading.value = false;
    nextscreen(cntx, Profile());
  }

  Future<bool?> deleteUserAccount(cntx) async {
    try {
      profileloading.value = true;
      var userdata = await ApiHelper().getdatabyuserid('users');
      var alarmdata = await ApiHelper().getdatabyuserid('alarm');
      var mivsdata = await ApiHelper().getdatabyuserid('mivs');
      var worldclockdata = await ApiHelper().getdatabyuserid('worldclocklist');
      print("USERID" + userdata.docs[0]['id'].toString());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userdata.docs[0]['email'], password: password.text);
      if (alarmdata.docs.length > 0) {
        print("alarm" + alarmdata.docs[0]['docid']);
        await ApiHelper().deletedata('alarm', alarmdata.docs[0]['docid']);
      }
      if (mivsdata.docs.length > 0) {
        await ApiHelper().deletedata('mivs', mivsdata.docs[0]['id']);
      }
      if (worldclockdata.docs.length > 0) {
        await ApiHelper()
            .deletedata('worldclocklist', worldclockdata.docs[0]['id']);
      }
      await ApiHelper().deletedata('users', userdata.docs[0]['id']);
      await FirebaseAuth.instance.currentUser!.delete();
      profileloading.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      profileloading.value = false;
      if (e.code == "requires-recent-login") {
        print('Delete Account==> ' + e.toString());
        Get.snackbar("Relogin", "please login again to delete your account",
            backgroundColor: NeumorphicTheme.accentColor(cntx));
      } else {
        Get.snackbar("Something went wrong", "Please retry after some time",
            backgroundColor: NeumorphicTheme.accentColor(cntx));
        print('Delete Account Error==> ' + e.toString());
      }
      return false;
    }
  }

  Future Deletedata(alarmdata, mivsdata, worldclockdata, userdata) async {
    await FirebaseAuth.instance.currentUser!.delete();
    return true;
  }

  notification() async {
    print("checkFirst--> ");
    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction) async {},
        onNotificationCreatedMethod:
            (ReceivedNotification receivedNotification) async {},
        onNotificationDisplayedMethod:
            (ReceivedNotification receivedNotification) async {
          SnackBar(content: Text("eneter"));
          print("object" + receivedNotification.toString());
          dataa.value = receivedNotification.payload!;
          print("Receivedd");
          print("Receivedd value ===> " + receivedNotification.toString());
          Get.to(
            () => AlarmScreen(
              data: receivedNotification.payload!,
              onsnoozeTap: (val) {
                snooze(receivedNotification.payload!, val);
              },
            ),
          );
        },
        onDismissActionReceivedMethod:
            (ReceivedAction receivedAction) async {});
  }

  add5Minutes(String timeString, {mins = 5}) {
    DateTime currentTime = DateTime.parse(timeString);
    DateTime updatedTime = currentTime.add(Duration(minutes: mins));
    String formattedTime = updatedTime.toString();
    DateTime newtime = DateTime.parse(formattedTime);
    return newtime;
  }

  snooze(data, mins) {
    var updatedTime = add5Minutes(data['currentTime'].toString(), mins: mins);
    shownotification(data['sound'], bool.parse(data['snooze'].toString()),
        updatedTime, data['assets']);
  }

  shownotification(soundname, snooze, dateTime, soundassets) async {
    DateTime currentTime = DateTime.now();
    await AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
      NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: false,
          importance: NotificationImportance.Max,
          enableVibration: true,
          playSound: true,
          onlyAlertOnce: false,
          soundSource: soundname),
    ]);
    bool isallowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isallowed) {
      print("object===>>>>>>>>>>");
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(999),
              channelKey: 'basic', //set configuration wuth key "basic"
              title: 'Alarm is playing',
              body: '',
              payload: {
                "name": "FlutterCampus",
                "currentTime": currentTime.toString(),
                "sound": soundname.toString(),
                "assets": soundassets.toString(),
                "snooze": snooze.toString()
              },
              autoDismissible: false,
              customSound: soundname,
              fullScreenIntent: true),
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
