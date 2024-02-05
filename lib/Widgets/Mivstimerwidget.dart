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
                      Container(
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
              titlewidgte(duration, int.parse(widget.duration.toString())),
              SizedBox(height: 20),
              // titlewidgte(remianingtext, widget.remaining),
              // SizedBox(height: 20),
              // titlewidgte(snoozetext, widget.snooze),
              // SizedBox(height: 20),
              // titlewidgte(repeattext, widget.repeat),
              // SizedBox(height: 20),
            ],
          )),
    );
  }

  titlewidgte(title, value) {
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
          // controller: _controller,
          seconds: value,
          build: (_, double time) => Text(
            time.toString(),
            style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw40018,
                color: NeumorphicTheme.accentColor(context)),
          ),
          interval: Duration(milliseconds: 100),
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
}
