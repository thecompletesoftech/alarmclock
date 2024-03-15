import 'dart:developer';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockalarm/Config/FireBase/localnotification.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/Profile/Controller/ProfileController.dart';
import 'package:clockalarm/View/SplashScreen.dart';
import 'package:clockalarm/View/alarm/AlarmScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:timezone/data/latest.dart' as tz;

var onalarm = false;
void main() async {
  await GetStorage.init();
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Alarm.init();
  // await PushNotificationService().setupInteractedMessage();
  await NotificationService().initializePlatformNotifications();
  runApp(const MyApp());
}

onSelectNotification(String? payload) async {
  // Handle the selection of the notification
  print('Notification selected: $payload');
}

var box = GetStorage();

ProfileController profilecontroller = Get.put(ProfileController());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var dataa = null;
  @override
  void initState() {
    profilecontroller.notification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: profilecontroller.darktheme.value == true
            ? mycolor().lightBlack
            : mycolor().lightWhite,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: profilecontroller.darktheme.value == true
            ? Brightness.light
            : Brightness.dark));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(
        () => NeumorphicApp(
          debugShowCheckedModeBanner: false,
          themeMode: profilecontroller.darktheme.value == true
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: NeumorphicThemeData(
            defaultTextColor: mycolor().Black,
            baseColor: mycolor().lightWhite,
            lightSource: LightSource.topLeft,
            accentColor: mycolor().lighttxtcolor,
            depth: 10,
          ),
          darkTheme: NeumorphicThemeData(
            defaultTextColor: mycolor().White,
            baseColor: mycolor().lightBlack,
            accentColor: mycolor().darktxtcolor,
            lightSource: LightSource.topLeft,
            depth: 6,
          ),
          home: profilecontroller.dataa.length < 1
              ? SplashScreen()
              : AlarmScreen(
                  data: dataa,
                  onsnoozeTap: (val) {
                    print("checkkkkkkkkkkk" + val.toString());
                    profilecontroller.snooze(dataa, val);
                  },
                ),
        ),
      ),
    );
  }
}
