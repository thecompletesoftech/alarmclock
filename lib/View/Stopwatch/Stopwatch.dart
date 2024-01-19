import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": Icons.person_outline_outlined, "screenname": null},
          ], titletext: stopwatch)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(child: StopwatchClock()),
            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    name: lap,
                    txtstyle: MyTextStyle.mw40020,
                    borderRadius: 20.0,
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ButtonWidget(
                    name: start,
                    txtstyle: MyTextStyle.mw40020,
                    borderRadius: 20.0,
                    onTap: () {},
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            SizedBox(height: 20),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AlramCard(
                    showmedium: true,
                    medium: 'Lap',
                    subtitlecolor: NeumorphicTheme.accentColor(context),
                    onchange: (value) {
                      setState(() {
                        isSwitched = !isSwitched;
                      });
                    },
                    swicthvalue: isSwitched,
                    subtitlestyle: MyTextStyle.mw70018,
                    time: '1',
                    showswitchorsubtile: false,
                    subtitle: "00:60:02",
                  ).paddingOnly(bottom: 10, top: 10);
                }),
          ],
        ),
      ),
    );
  }
}
