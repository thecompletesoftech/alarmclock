import 'package:clockalarm/Config/Import.dart';

nextscreenwithoutback(cntx, screenname) {
  Navigator.pushReplacement(
      cntx, MaterialPageRoute(builder: (BuildContext context) => screenname));
}

nextscreen(cntx, screenname) {
  Navigator.push(
      cntx, MaterialPageRoute(builder: (BuildContext context) => screenname));
}

buttonradius({r}) {
  NeumorphicBoxShape.roundRect(BorderRadius.circular(r ?? 15.0));
}
