import '../../Config/Import.dart';

class Clock extends StatefulWidget {
  final time;
  const Clock({super.key, this.time});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                NeumorphicTheme.isUsingDark(context)
                    ? Container(
                        height: 230,
                        width: 230,
                        decoration: Utils().decoration(
                            cntx: context,
                            isdark: NeumorphicTheme.isUsingDark(context),
                            radius: 250.0 * fem),
                      )
                    : SvgPicture.string(clockbackground),
                Container(
                  height: 18,
                  width: 2,
                  color: NeumorphicTheme.defaultTextColor(context),
                ).paddingOnly(top: 8),
              ],
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 230,
                  width: 230,
                  color: Colors.transparent,
                ),
                Container(
                  height: 2,
                  width: 18,
                  color: NeumorphicTheme.defaultTextColor(context),
                ).paddingOnly(left: 8),
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 230,
                  width: 230,
                  color: Colors.transparent,
                ),
                Container(
                  height: 18,
                  width: 2,
                  color: NeumorphicTheme.defaultTextColor(context),
                ).paddingOnly(bottom: 8),
              ],
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: 230,
                  width: 230,
                  color: Colors.transparent,
                ),
                Container(
                  height: 2,
                  width: 18,
                  color: NeumorphicTheme.defaultTextColor(context),
                ).paddingOnly(right: 8),
              ],
            ),
          ],
        ),
        Container(
          height: 150,
          width: 150,
          child: AnalogClock(
            decoration: Utils().decoration(
                cntx: context,
                isdark: NeumorphicTheme.isUsingDark(context),
                radius: 150 * fem),
            width: 150.0,
            isLive: true,
            hourHandColor: NeumorphicTheme.defaultTextColor(context),
            minuteHandColor: NeumorphicTheme.accentColor(context),
            showSecondHand: false,
            numberColor: Colors.black87,
            showNumbers: false,
            showAllNumbers: false,
            textScaleFactor: 1.4,
            showTicks: false,
            showDigitalClock: false,
            datetime: widget.time,
          ).paddingOnly(
              right: NeumorphicTheme.isUsingDark(context) ? 0 : 5,
              bottom: NeumorphicTheme.isUsingDark(context) ? 0 : 3),
        ),
      ],
    );
  }

  Widget stackwidget({padding, hight, width, Alignment}) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Stack(
      alignment: Alignment,
      children: [
        Container(
          height: 230,
          width: 230,
          decoration: Utils().decoration(
              cntx: context,
              isdark: NeumorphicTheme.isUsingDark(context),
              radius: 250.0 * fem),
        ),
        Padding(
          padding: padding,
          child: Container(
            height: hight,
            width: width,
            color: NeumorphicTheme.defaultTextColor(context),
          ),
        )
      ],
    );
  }
}
