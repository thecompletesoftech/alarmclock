import 'dart:developer';
import 'dart:io';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  var selectimage;
  var profileimage = "";
  var box = GetStorage();

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

  updateprofile(cntx) async {
    var setimageid = await ApiHelper().getdatabyuserid('users');
    log("message" + setimageid.docs[0]['id'].toString());
    String downloadURL = await uploadImage(File(selectimage!));
    print('Image uploaded. Download URL: $downloadURL');
    var updatedata = {"image": downloadURL.toString()};
    await ApiHelper().Updatedata('users', setimageid.docs[0]['id'], updatedata);
    log('mcvnevoveokvk');
    nextscreen(cntx, WorldClock());
  }
}
