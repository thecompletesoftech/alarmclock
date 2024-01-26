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
            {"icon": "assets/person.png", "screenname": Profile()},
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
                    txtstyle: MyTextStyle.mw40024,
                    issmall: true,
                    borderRadius: 20.0,
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ButtonWidget(
                    name: start,
                    issmall: true,
                    txtstyle: MyTextStyle.mw40024,
                    borderRadius: 20.0,
                    onTap: () {},
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                padding: EdgeInsets.zero,
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
                    time: '1 ',
                    showswitchorsubtile: false,
                    subtitle: "00:60:02",
                  ).paddingOnly(bottom: 10);
                }),
          ],
        ),
      ),
    );
  }

  void _start() {
    setState(() {
      _stopwatch.start();
    });
  }

  void _stop() {
    setState(() {
      _stopwatch.stop();
      if (_stopwatch.elapsedMilliseconds > 0) {
        _lapTimes.insert(0, formatTime(_stopwatch.elapsedMilliseconds));
      }
    });
  }

  void _lap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _lapTimes.insert(0, formatTime(_stopwatch.elapsedMilliseconds));
      });
    }
  }

  String formatTime(int milliseconds) {
    int minutes = (milliseconds / 60000).floor();
    int seconds = ((milliseconds % 60000) / 1000).floor();
    int millisecondsPart = (milliseconds % 1000);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${(millisecondsPart ~/ 100).toString()}';
  }
}
