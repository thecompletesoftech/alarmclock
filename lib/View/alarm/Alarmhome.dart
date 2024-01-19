import '../../Config/Import.dart';
import '../../Config/Utils.dart';

class AlarmHome extends StatefulWidget {
  const AlarmHome({super.key});

  @override
  State<AlarmHome> createState() => _AlarmHomeState();
}

class _AlarmHomeState extends State<AlarmHome> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": Icons.add, "screenname": null},
            {"icon": Icons.edit, "screenname": null},
            {"icon": Icons.person_outline_outlined, "screenname": null},
          ], titletext: alarm)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 230,
                  width: 230,
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 250.0 * fem),
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
                    hourHandColor: Colors.white,
                    minuteHandColor: NeumorphicTheme.accentColor(context),
                    showSecondHand: false,
                    numberColor: Colors.black87,
                    showNumbers: false,
                    showAllNumbers: false,
                    textScaleFactor: 1.4,
                    showTicks: false,
                    showDigitalClock: false,
                    datetime: DateTime(2019, 1, 1, 9, 12, 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return AlramCard(
                  medium: 'pm',
                  time: '6:45',
                ).paddingOnly(bottom: 20, top: 10);
              },
            )
          ],
        ),
      ),
    );
  }
}
