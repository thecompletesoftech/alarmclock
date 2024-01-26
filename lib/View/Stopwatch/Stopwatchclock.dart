import '../../Config/Import.dart';

class StopwatchClock extends StatefulWidget {
  const StopwatchClock({super.key});

  @override
  State<StopwatchClock> createState() => _StopwatchClockState();
}

class _StopwatchClockState extends State<StopwatchClock> {
  @override
  Widget build(BuildContext context) {
      Stopwatch _stopwatch = Stopwatch();
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Stack(
      alignment: Alignment.center,
      children: [
        NeumorphicTheme.isUsingDark(context)
            ? Container(
                alignment: Alignment.center,
                height: 250,
                width: 250,
                decoration: Utils().decoration(
                    cntx: context,
                    isdark: NeumorphicTheme.isUsingDark(context),
                    radius: 250.0 * fem),
                child: Text(
             formatTime(_stopwatch.elapsedMilliseconds),
                  style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw70036,
                      color: NeumorphicTheme.accentColor(context)),
                ),
              )
            : Image.asset("assets/stopwatch.png",height: 250),
        if (NeumorphicTheme.isUsingDark(context) == false)
          Text(
         formatTime(_stopwatch.elapsedMilliseconds),
            style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw70036,
                color: NeumorphicTheme.accentColor(context)),
          ).paddingOnly(
              right: NeumorphicTheme.isUsingDark(context) ? 0 : 7,
              bottom: NeumorphicTheme.isUsingDark(context) ? 0 : 5),
        Container(
                height: 195,
                width: 195,
                child: Image.asset("assets/dottedborder.png"))
            .paddingOnly(
                right: NeumorphicTheme.isUsingDark(context) ? 0 : 7,
                bottom: NeumorphicTheme.isUsingDark(context) ? 0 : 5),
      ],
    );
  }
}
