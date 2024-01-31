import 'dart:async';
import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';

enum Stopwatchenum { start, stop, resume, reset }

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool isSwitched = false;
  Stopwatch _stopwatch = Stopwatch();
  var currentstate = Stopwatchenum.start;
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
              SizedBox(height: 87),
              Center(
                  child: StopwatchClock(
                watchtime: _formattedTime.toString(),
              )),
              SizedBox(height: 97),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ButtonWidget(
                      txtstyle: MyTextStyle.mw40018,
                      issmall: true,
                      borderRadius: 15.0,
                      onTap: isSwitched ? stop : start,
                      name: isSwitched ? 'Stop' : 'Start',
                    ),
                  ),
                  SizedBox(width: 30),
                  if (currentstate == Stopwatchenum.stop)
                    Expanded(
                      child: ButtonWidget(
                        txtstyle: MyTextStyle.mw40018,
                        issmall: true,
                        borderRadius: 15.0,
                        onTap: reset,
                        name: 'Reset',
                        child: Text('Reset'),
                      ),
                    )
                  else if (currentstate == Stopwatchenum.start)
                    Expanded(
                      child: ButtonWidget(
                        txtstyle: MyTextStyle.mw40018,
                        issmall: true,
                        borderRadius: 15.0,
                        onTap: lap,
                        name: 'Lap',
                        child: Text('Lap'),
                      ),
                    )
                  else if (currentstate == Stopwatchenum.reset)
                    Expanded(
                      child: ButtonWidget(
                        txtstyle: MyTextStyle.mw40018,
                        issmall: true,
                        borderRadius: 20.0,
                        onTap: lap,
                        name: 'Lap',
                        child: Text('Lap'),
                      ),
                    ),
                ],
              ).paddingSymmetric(horizontal: 15),
              // Row(
              //   children: [
              //     Expanded(
              //       child: ButtonWidget(
              //         name: lap,
              //         txtstyle: MyTextStyle.mw40024,
              //         issmall: true,
              //         borderRadius: 20.0,
              //         onTap: () {
              //           setState(() {
              //             print('object');
              //             _lap();
              //           });
              //         },
              //       ),
              //     ),
              //     SizedBox(width: 20),
              //     Expanded(
              //       child: ButtonWidget(
              //         name: isSwitched ? 'Stop' : 'Start',
              //         issmall: true,
              //         txtstyle: MyTextStyle.mw40024,
              //         borderRadius: 20.0,
              //         onTap: () {
              //           setState(() {
              //             isSwitched ?
              //             // toggleTimer();
              //           });
              //         },
              //       ),
              //     ),
              //     Expanded(
              //       child: ButtonWidget(
              //         name: 'Reset',
              //         issmall: true,
              //         txtstyle: MyTextStyle.mw40024,
              //         borderRadius: 20.0,
              //         onTap: () {
              //           setState(() {
              //             _reset();
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ).paddingSymmetric(horizontal: 10),

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _lapTimes.map((lapTime) {
                                        return CardBackground(
                                          radius: 15.0,
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
                                                          style: MyTextStyle
                                                              .mw40020,
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
                                                          style: MyTextStyle
                                                              .mw70014,
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
                                        ).paddingOnly(
                                            top: NeumorphicTheme.isUsingDark(
                                                    context)
                                                ? 20
                                                : 0);
                                      }).toList()),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            : Container();
                      })
                  .paddingOnly(
                      top: NeumorphicTheme.isUsingDark(context) ? 20 : 0,
                      left: 15,
                      right: 15),
              SizedBox(height: 20)
            ],
          )),
    );
  }

  void start() {
    setState(() {
      _stopwatch.start();
      isSwitched = true;
      currentstate = Stopwatchenum.start;
    });
  }

  void stop() {
    setState(() {
      _stopwatch.stop();
      currentstate = Stopwatchenum.stop;
      isSwitched = false;
    });
  }

  void reset() {
    setState(() {
      _stopwatch.reset();
      _lapTimes.clear();
      currentstate = Stopwatchenum.reset;
      isSwitched = false;
      // _stopwatch.stop();
    });
  }

  void lap() {
    setState(() {
      if (_stopwatch.elapsedMilliseconds > 0) {
        _lapTimes.insert(0, formatTime(_stopwatch.elapsedMilliseconds));
      }
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
