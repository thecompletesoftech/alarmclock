import 'dart:async';

import 'package:flutter/services.dart';

import '../Config/Import.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box = GetStorage();
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => nextscreenwithoutback(
          context, box.read('uid') != null ? NewBottomNavigator() : SignIn()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: NeumorphicTheme.baseColor(context),
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: NeumorphicTheme.isUsingDark(context)
            ? Brightness.light
            : Brightness.dark));
    return Scaffold(
      body: Center(
          child: NeumorphicTheme.isUsingDark(context)
              ? Image.asset("assets/Lighttival.gif")
              : Image.asset("assets/Lighttival.gif")),
    );
  }
}
