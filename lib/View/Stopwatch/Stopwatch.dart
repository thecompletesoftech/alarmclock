import 'dart:async';

import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool isSwitched = false;
  Stopwatch _stopwatch = Stopwatch();
  List<String> _lapTimes = [];
  String _formattedTime = '00:00:00';
  @override
  void initState() {
    sec5Timer();
    super.initState();
  }

  sec5Timer() async {
    await Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

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
            Center(
                child: StopwatchClock(
              watchtime: _formattedTime.toString(),
            )),
            SizedBox(height: 50),
            // Text(
            //   _formattedTime,
            //   style: TextStyle(fontSize: 40),
            // ),
            // Text(_formattedTime.toString()),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    name: lap,
                    txtstyle: MyTextStyle.mw40024,
                    issmall: true,
                    borderRadius: 20.0,
                    onTap: () {
                      // setState(() {
                      //   _lap();
                      // });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ButtonWidget(
                    name: start,
                    issmall: true,
                    txtstyle: MyTextStyle.mw40024,
                    borderRadius: 20.0,
                    onTap: () {
                      setState(() {
                        _start();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    name: 'stop',
                    txtstyle: MyTextStyle.mw40024,
                    issmall: true,
                    borderRadius: 20.0,
                    onTap: () {
                      setState(() {
                        _stop();
                      });
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10),
            _lapTimes.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _lapTimes
                        .map((lapTime) => Text('Lap: $lapTime',
                            style: TextStyle(fontSize: 16)))
                        .toList(),
                  )
                : Container(),
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

  // void _start() {
  //   setState(() {
  //     _stopwatch.start();
  //   });
  // }

  // void _stop() {
  //   setState(() {
  //     _stopwatch.stop();
  //     if (_stopwatch.elapsedMilliseconds > 0) {
  //       _lapTimes.insert(0, formatTime(_stopwatch.elapsedMilliseconds));
  //     }
  //   });
  // }

  // void _lap() {
  //   if (_stopwatch.isRunning) {
  //     setState(() {
  //       _lapTimes.insert(0, formatTime(_stopwatch.elapsedMilliseconds));
  //     });
  //   }
  // }

  // String formatTime(milisecond) {
  //   final hours = _stopwatch.elapsed.inHours % 24;
  //   final minutes = _stopwatch.elapsed.inMinutes % 60;
  //   final seconds = _stopwatch.elapsed.inSeconds % 60;
  //   // int minutes = (milliseconds / 60000).floor();
  //   // int seconds = ((milliseconds % 60000) / 1000).floor();
  //   // int millisecondsPart = (milliseconds % 1000);
  //   return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  // }

  void _start() {
    setState(() {
      _stopwatch.start();
      _updateTime();
    });
  }

  void _stop() {
    setState(() {
      _stopwatch.stop();
    });
  }

  void _reset() {
    setState(() {
      _stopwatch.reset();
    });
  }

  void _updateTime() {
    final hours = _stopwatch.elapsed.inHours % 24;
    final minutes = _stopwatch.elapsed.inMinutes % 60;
    final seconds = _stopwatch.elapsed.inSeconds % 60;

    setState(() {
      _formattedTime =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    });
  }
}
