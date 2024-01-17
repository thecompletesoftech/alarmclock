import 'package:clockalarm/Config/Import.dart';

nextscreenwithoutback(context, screenname) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screenname));
}
nextscreen(context, screenname) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screenname));
}
