import 'package:clockalarm/View/alarm/Sound.dart';
import 'package:flutter/cupertino.dart';

import '../../Config/Import.dart';
import 'Repeat.dart';
import 'alarmController.dart';

class AddAlram extends StatefulWidget {
  const AddAlram({super.key});

  @override
  State<AddAlram> createState() => _AddAlramState();
}

class _AddAlramState extends State<AddAlram> {
  AlramController _alramController = Get.put(AlramController());
  var alramlist = [
    {
      "title": "Repeat",
      "subtitle": "Never",
      "showarrow": true,
      "showswicth": false
    },
    {
      "title": "Label",
      "subtitle": "Alarm",
      "showarrow": false,
      "showswicth": false
    },
    {
      "title": "Sound",
      "subtitle": "Apex",
      "showarrow": true,
      "showswicth": false
    },
    {
      "title": "Snooze",
      "subtitle": "Never",
      "showarrow": false,
      "showswicth": true
    }
  ];
  DateTime _selectedTime = DateTime.now();
  String time = "-";
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (() {
                    backscreen(context);
                  }),
                  child: Text(cancel,
                      style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40014,
                        color: NeumorphicTheme.defaultTextColor(context),
                      )),
                ),
                Text(
                  addalarm,
                  style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw60018,
                      color: NeumorphicTheme.accentColor(context)),
                ),
                GestureDetector(
                  onTap: () async {
                    var timeofday = TimeOfDay.fromDateTime(_selectedTime);
                    await _alramController.setAlarm(
                        timeofday, isSwitched, context);

                    backscreen(context);
                    _alramController.getalram();
                  },
                  child: Text(save,
                      style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40014,
                        color: NeumorphicTheme.defaultTextColor(context),
                      )),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle:
                        TextStyle(color: NeumorphicTheme.accentColor(context)),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (newTime) {
                    setState(() {
                      _selectedTime = newTime;
                      time = "${_selectedTime.hour} : ${_selectedTime.minute}";
                    });
                  },
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: alramlist.length,
              itemBuilder: (context, index) {
                return
                    // UnicornOutlineButton(
                    //   strokeWidth: 2,
                    //   radius: 15,
                    //   gradient: LinearGradient(
                    //       colors: [mycolor().gradient1, mycolor().gradient2]),
                    //   child: Text('OMG', style: TextStyle(fontSize: 16)),
                    //   onPressed: () {},
                    // ).paddingOnly(
                    //   bottom: 10,
                    //   left: 10,
                    // );
                    AlramCard(
                  showmedium: false,
                  showswitchorsubtile: alramlist[index]['showswicth'],
                  showarrowicon: alramlist[index]['showarrow'],
                  time: alramlist[index]['title'].toString(),
                  subtitle: alramlist[index]['subtitle'].toString(),
                  ontapcard: () {
                    if (index == 0) {
                      nextscreen(context, Repeat());
                    }

                    if (index == 2) {
                      nextscreen(context, Sound());
                    }
                  },
                  onchange: (value) {
                    setState(() {
                      isSwitched = !isSwitched;
                    });
                  },
                  swicthvalue: isSwitched,
                ).paddingOnly(bottom: 10, top: 10);
              },
            )
          ],
        ),
      ),
    );
  }
}

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: BoxConstraints(minWidth: 88, minHeight: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required double strokeWidth,
      required double radius,
      required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 3, size.height - strokeWidth * 3);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
