import 'package:clockalarm/Config/Import.dart';

import 'View/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
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
