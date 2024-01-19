import '../../Config/Import.dart';

class StopwatchClock extends StatefulWidget {
  const StopwatchClock({super.key});

  @override
  State<StopwatchClock> createState() => _StopwatchClockState();
}

class _StopwatchClockState extends State<StopwatchClock> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 250,
          width: 250,
          decoration: Utils().decoration(
              cntx: context,
              isdark: NeumorphicTheme.isUsingDark(context),
              radius: 250.0 * fem),
          child: Text(
            "10:00:00",
            style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw70036,
                color: NeumorphicTheme.accentColor(context)),
          ),
        ),
        Container(
            height: 180,
            width: 180,
            child: Image.asset("assets/dottedborder.png")),
      ],
    );
  }
}
