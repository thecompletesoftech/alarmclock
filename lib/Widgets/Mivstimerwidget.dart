import 'dart:developer';

import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../Config/Import.dart';

class Mivstimer extends StatefulWidget {
  final String title;
  final String alarmtime;
  final String duration;
  final String remaining;
  final String snooze;
  final String repeat;

  const Mivstimer(
      {super.key,
      required this.title,
      required this.alarmtime,
      required this.duration,
      required this.remaining,
      required this.snooze,
      required this.repeat});

  @override
  State<Mivstimer> createState() => _MivstimerState();
}

class _MivstimerState extends State<Mivstimer> {
  final CountdownController _controller = CountdownController(autoStart: false);
  var hideplayicon = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return CardBackground(
      backgroundimage: bigcardsvg,
      child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title.toString(),
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw60022,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            hideplayicon = !hideplayicon;
                          });
                          hideplayicon
                              ? _controller.pause()
                              : _controller.resume();
                        },
                        child: Container(
                            height: 45,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: Utils().decoration(
                                shadow: false,
                                shadowwithcolor:
                                    NeumorphicTheme.isUsingDark(context)
                                        ? true
                                        : false,
                                cntx: context,
                                isdark: NeumorphicTheme.isUsingDark(context),
                                radius: 32.5 * fem),
                            child: Image.asset(
                              "assets/pause.png",
                              color: NeumorphicTheme.accentColor(context),
                              height: 20,
                              fit: BoxFit.fill,
                              width: 20,
                            )),
                      ),
                      SizedBox(width: 15),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: Utils().decoration(
                              shadow: false,
                              shadowwithcolor:
                                  NeumorphicTheme.isUsingDark(context)
                                      ? true
                                      : false,
                              cntx: context,
                              isdark: NeumorphicTheme.isUsingDark(context),
                              radius: 32.5 * fem),
                          child: Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/power.png",
                                color: NeumorphicTheme.accentColor(context),
                                height: 20,
                                fit: BoxFit.fill,
                                width: 20,
                              ))),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/alramclock.png",
                        color: NeumorphicTheme.accentColor(context),
                      )),
                  SizedBox(width: 4),
                  Text(
                    widget.alarmtime,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw50016,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                ],
              ),
              SizedBox(height: 28),
              newtitlewidget(duration, widget.duration),
              SizedBox(height: 20),
              titlewidget(remianingtext, widget.remaining.toString()),
              SizedBox(height: 20),
              newtitlewidget(snoozetext, widget.snooze),
              SizedBox(height: 20),
              newtitlewidget(repeattext, widget.repeat),
              SizedBox(height: 20),
            ],
          )),
    );
  }

  titlewidget(title, value) {
    var newvalue = value.split(':');
    var hrssec = int.parse(newvalue[0].toString()) * 3600;
    var minsec = int.parse(newvalue[1].toString()) * 60;
    var newsec = hrssec + minsec + int.parse(newvalue[2]);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw40016,
              color: NeumorphicTheme.defaultTextColor(context)),
        ),
        Countdown(
          controller: _controller,
          seconds: newsec,
          build: (_, double time) {
            int hrs = (time / 3600).truncate();
            var newsec = time - (hrs * 3600);
            int minutes = (newsec / 60).truncate();
            var currentsec = time - (minutes * 60 + hrs * 3600).truncate();
            var currentsecond = currentsec.toStringAsFixed(0);
            var currenthrs = hrs.toString();
            var currentmin = minutes.toString();
            return Text(
              '${currenthrs.length > 1 ? currenthrs : '0' + currenthrs} : ${currentmin.length > 1 ? currentmin : '0' + currentmin} : ${currentsecond.length > 1 ? currentsecond : '0' + currentsecond}',
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw40018,
                  color: NeumorphicTheme.accentColor(context)),
            );
          },
          interval: Duration(seconds: 1),
          onFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Timer is done!'),
              ),
            );
          },
        ),
      ],
    );
  }

  newtitlewidget(title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw40016,
              color: NeumorphicTheme.defaultTextColor(context)),
        ),
        Text(
          value,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw40018,
              color: NeumorphicTheme.accentColor(context)),
        ),
      ],
    );
  }
}
