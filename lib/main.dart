import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:timezone/data/latest.dart' as tz;

import 'Config/FireBase/NotificationServices.dart';

void main() async {
  await GetStorage.init();
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Alarm.init();
  await PushNotificationService().setupInteractedMessage();
  runApp(const MyApp());
}

onSelectNotification(String? payload) async {
  // Handle the selection of the notification
  print('Notification selected: $payload');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'Tival',
        themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark
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
        home: SplashScreen(),
      ),
    );
  }
}
