import 'package:clockalarm/Account/Login.dart';

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
      () => 
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login())),
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
