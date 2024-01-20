import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/TimerCard.dart';

class AddMIVSTimer extends StatefulWidget {
  const AddMIVSTimer({super.key});

  @override
  State<AddMIVSTimer> createState() => _AddMIVSTimerState();
}

class _AddMIVSTimerState extends State<AddMIVSTimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": null},
              {"icon": "assets/person.png", "screenname": null},
            ],
            titletext: timertext,
            showdivider: true,
            showbtn: true,
            showlistbtn: false,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                   Intervalend(
                    title: interduration,
                    hour: "12",
                    minute: "00",
                    second: "00",
                    medium: "AM",
                  ),
                  SizedBox(height: 10),
                  IntervalCard(
                    title: reperatinterval,
                    interval: 4,
                  ),
                  SizedBox(height: 20),
                 
                  SizedBox(height: 20),
                  Timercard(
                      title: intervalend,
                      hour: "00",
                      minute: "00",
                      second: "00"),
                  SizedBox(height: 20),
                  Timercard(
                      title: totalduration,
                      hour: "00",
                      minute: "00",
                      second: "00"),
                  SizedBox(height: 20),
                  Timercard(
                      title: snoozetxt, hour: "00", minute: "00", second: "00"),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    name: go,
                    txtstyle: MyTextStyle.mw40020,
                    borderRadius: 15.0,
                    onTap: () {
                      nextscreen(context, PendingTimer());
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ButtonWidget(
                    name: reset,
                    txtstyle: MyTextStyle.mw40020,
                    borderRadius: 15.0,
                    onTap: () {},
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
