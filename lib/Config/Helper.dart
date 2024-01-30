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

convert24to12(time) {
  return DateFormat("hh:mm").format(DateFormat('HH').parse(time));
}

convert12to24(time) {
  return DateFormat("hh:mm").format(DateFormat('HH:mm').parse(time));
}

getAmPm(time) {
  return DateFormat("a").format(DateFormat('HH').parse(time));
}

dynamic datTime2(dtime) {
  return DateFormat("hh:mm a dd MMM").format(datTimefrommilli(dtime));
}

DateTime datTimefrommilli(dtime) {
  return DateTime.fromMillisecondsSinceEpoch(
      int.parse(dtime.toString().substring(0, dtime.toString().length - 3)) *
          1000);
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

Mysnack(title, msg, cntx) {
  Get.snackbar(
    title,
    msg,
    colorText: NeumorphicTheme.accentColor(cntx),
    backgroundColor: NeumorphicTheme.baseColor(cntx),
    borderRadius: 15,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    borderColor: Colors.grey[400],
    borderWidth: 1,
    isDismissible: true,
    // dismissDirection: SnackDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
