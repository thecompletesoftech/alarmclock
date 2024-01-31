import 'package:permission_handler/permission_handler.dart';

class Permissions {
  Future checkCamerapermission() async {
    var photosStatus = await Permission.photos.status;
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;
    var StorageStatus = await Permission.storage.status;
    var manageExternalStorageStatus =
        await Permission.manageExternalStorage.status;
    if (!photosStatus.isGranted) await Permission.photos.request();
    if (!cameraStatus.isGranted) await Permission.camera.request();
    if (!microphoneStatus.isGranted) await Permission.microphone.request();
    if (!StorageStatus.isGranted) await Permission.storage.request();
    if (!manageExternalStorageStatus.isGranted)
      await Permission.manageExternalStorage.request();
    if (await Permission.camera.isGranted) {
      if (await Permission.manageExternalStorage.isGranted) {
        print("Permission granted");
      } else if (await Permission.photos.isGranted) {
        print("Permission granted");
      } else {
        // openAppSettings();
      }
      print("Permission granted");
      return true;
    } else {
      // openAppSettings();
      print(
          "Camera needs to access your microphone, please provide permission");
      return false;
    }
  }
}
