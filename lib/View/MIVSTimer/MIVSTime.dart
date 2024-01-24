import 'package:clockalarm/Config/Import.dart';

class MIVSTimer extends StatefulWidget {
  const MIVSTimer({super.key});

  @override
  State<MIVSTimer> createState() => _MIVSTimerState();
}

class _MIVSTimerState extends State<MIVSTimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": AddMIVSTimer()},
              {"icon": "assets/person.png", "screenname": Profile()},
            ],
            titletext: timertext,
            showdivider: true,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Mivstimer(
                    alarmtime: '05:15 pm',
                    duration: '00 : 00 : 00',
                    remaining: '00 : 00 : 00',
                    repeat: '07 : 15 : 00',
                    snooze: '00 : 05 : 00',
                    title: 'Alpha',
                  ).paddingOnly(
                      bottom: NeumorphicTheme.isUsingDark(context) ? 30 : 0);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
