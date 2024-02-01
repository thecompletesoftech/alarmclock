import 'dart:async';

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
    return Scaffold(
      body: Center(
          child: NeumorphicTheme.isUsingDark(context)
              ? Image.asset("assets/LogoDarkMode.png")
              : Image.asset("assets/NewLogo.png")),
    );
  }
}
