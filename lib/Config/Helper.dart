import 'package:clockalarm/Config/Import.dart';

nextscreen(context, screenname) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screenname));
}
