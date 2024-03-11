import 'dart:developer';
import 'dart:io';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../main.dart';

class ProfileController extends GetxController {
  final nameContoller = TextEditingController();
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
      log("message==> " + userdata.docs[0]['id'].toString());
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
}
