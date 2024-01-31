import 'package:clockalarm/Config/Import.dart';

import '../../Config/Api.dart';

class MIVSTimer extends StatefulWidget {
  const MIVSTimer({super.key});

  @override
  State<MIVSTimer> createState() => _MIVSTimerState();
}

class _MIVSTimerState extends State<MIVSTimer> {
  Mivsctrl _mivsctrl = Get.put(Mivsctrl());
  var box = GetStorage();
  @override
  void initState() {
    _mivsctrl.getmivstime(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
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
              SizedBox(height: 15),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("mivstime")
                      .where("uid", isEqualTo: box.read('uid'))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          noanyalarfound,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw50018,
                              color: NeumorphicTheme.defaultTextColor(context)),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        DocumentSnapshot newitem = snapshot.data!.docs[index];
                        return Mivstimer(
                          alarmtime: '05:15 pm',
                          duration: newitem['totalDuration'],
                          remaining: newitem['intervalDuration'],
                          repeat: newitem['intervalEnd'],
                          snooze: newitem['snoozeDuration'],
                          title: 'Alpha',
                        ).paddingOnly(
                            bottom:
                                NeumorphicTheme.isUsingDark(context) ? 30 : 0);
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
