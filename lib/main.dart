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

ProfileController profilecontroller = Get.put(ProfileController());
var onalarm = false;
void main() async {
  await GetStorage.init();
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Alarm.init();
  // await PushNotificationService().setupInteractedMessage();
  await NotificationService().initializePlatformNotifications();

  ReceivedAction? receivedAction = await AwesomeNotifications()
      .getInitialNotificationAction(removeFromActionEvents: false);
  if (receivedAction?.channelKey == 'basic') {
    print("checkSecondd" + receivedAction.toString());
    runApp(MyApps(dataa: receivedAction!.payload!));
  } else {
    runApp(const MyApp());
  }
}

var box = GetStorage();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
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
      navigatorKey: navigatorKey,
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
            home: SplashScreen()),
      ),
    );
  }
}

class MyApps extends StatelessWidget {
  final dataa;
  const MyApps({super.key, this.dataa});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
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
      navigatorKey: navigatorKey,
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
            home: AlarmScreen(
              data: dataa,
              onsnoozeTap: (val) {
                profilecontroller.snooze(dataa, val);
              },
            )),
      ),
    );
  }
}
