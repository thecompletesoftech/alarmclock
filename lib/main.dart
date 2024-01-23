import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/SplashScreen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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
