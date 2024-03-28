import 'dart:io';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';
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
}
