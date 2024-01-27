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
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    name: lap,
                    txtstyle: MyTextStyle.mw40024,
                    issmall: true,
                    borderRadius: 20.0,
                    onTap: () {
                      setState(() {
                        print('object');
                        _lap();
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ButtonWidget(
                    name: isSwitched ? 'Stop' : 'Start',
                    issmall: true,
                    txtstyle: MyTextStyle.mw40024,
                    borderRadius: 20.0,
                    onTap: () {
                      setState(() {
                        toggleTimer();
                      });
                    },
                  ),
                ),
                Expanded( 
                  child: ButtonWidget(
                    name: 'Reset',
                    issmall: true,
                    txtstyle: MyTextStyle.mw40024,
                    borderRadius: 20.0,
                    onTap: () {
                      setState(() {
                        _reset();
                      });
                    },
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
                  return _lapTimes.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _lapTimes
                                  .map((lapTime) => CardBackground(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${_lapTimes.indexOf(lapTime) + 1}',
                                                    style: MyTextStyle.Dynamic(
                                                        style:
                                                            MyTextStyle.mw40020,
                                                        color: NeumorphicTheme
                                                            .accentColor(
                                                                context)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Lap',
                                                    style: MyTextStyle.Dynamic(
                                                        style:
                                                            MyTextStyle.mw70014,
                                                        color: mycolor()
                                                            .greenlightcolor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '$lapTime',
                                              style: MyTextStyle.Dynamic(
                                                  style: MyTextStyle.mw40018,
                                                  color: NeumorphicTheme
                                                      .accentColor(context)),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        )
                      : Container();
                }),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  void _pause() {
    setState(() {
      _stopwatch.stop();
      isSwitched = false;
    });
  }

  void _reset() {
    setState(() {
      _stopwatch.reset();
      _lapTimes.clear();
      _formattedTime = '00:00:00';
      isSwitched = false;
    });
  }

  void toggleTimer() {
    if (_stopwatch.isRunning) {
      _pause();
    } else {
      _start();
    }
  }

  void _lap() {
    if (_stopwatch.elapsedMilliseconds > 0) {
      _lapTimes.insert(0, formatTime(_stopwatch.elapsedMilliseconds));
    }
  }

  void _start() {
    setState(() {
      _stopwatch.start();
      _updateTime();
      isSwitched = true;
    });
  }

  void _stop() {
    setState(() {
      _stopwatch.stop();
      isSwitched = false;
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

  String formatTime(int milliseconds) {
    final hours = milliseconds ~/ Duration.millisecondsPerHour;
    final minutes = (milliseconds ~/ Duration.millisecondsPerMinute) % 60;
    final seconds = (milliseconds ~/ Duration.millisecondsPerSecond) % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
