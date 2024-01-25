import 'package:clockalarm/Config/Import.dart';
import 'package:intl/intl.dart';

nextscreenwithoutback(cntx, screenname) {
  Navigator.pushReplacement(
      cntx, MaterialPageRoute(builder: (BuildContext context) => screenname));
}

nextscreen(cntx, screenname) {
  Navigator.push(
      cntx, MaterialPageRoute(builder: (BuildContext context) => screenname));
}

backscreen(cntx) {
  Navigator.pop(cntx);
}

buttonradius({r}) {
  NeumorphicBoxShape.roundRect(BorderRadius.circular(r ?? 15.0));
}

String formatDate(String? dateString) {
  if (dateString != null) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  } else {
    return "date";
  }
}

formatTime(dateString) {
  if (dateString != null) {
    String formattedDate = DateFormat('hh:mm a').format(dateString);
    return formattedDate;
  } else {
    return "date";
  }
}

String formatDateTime(String? dateString) {
  if (dateString != null) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
    return formattedDate;
  } else {
    return "date";
  }
}
