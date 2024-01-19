import 'dart:async';

import 'package:clockalarm/View/BottomNavigation/BottomNavigation.dart';
import 'package:clockalarm/View/WorldClock/WorldClock.dart';

import '../Config/Import.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => nextscreenwithoutback(context, WorldClock()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/TivalLogo.png"),
      ),
    );
  }
}
