import 'package:clockalarm/Config/Import.dart';

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
          preferredSize: Size.fromHeight(70),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/TimeMachine.png", "screenname": PendingTimer()},
              {"icon": "assets/person.png", "screenname": Profile()},
            ],
            titletext: timerlist,
            showdivider: true,
            borderonindex: 3,
          ).marginOnly(top: 5)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 10 : 0),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("mivstime")
                      // .where("uid", isEqualTo: box.read('uid'))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
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
                      itemCount: 1,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        DocumentSnapshot newitem = snapshot.data!.docs[index];
                        return Mivstimer(
                          alarmtime: '05:15 pm',
                          duration: newitem['totalDuration'],
                          remaining: newitem['totalDuration'].toString(),
                          repeat: newitem['intervalEnd'],
                          snooze: newitem['snoozeDuration'],
                          title: 'Alpha',
                        ).paddingOnly(
                            bottom:
                                NeumorphicTheme.isUsingDark(context) ? 30 : 0);
                      },
                    ).paddingOnly(top: 10);
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          nextscreen(context, AddMIVSTimer());
        },
        child: Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: Utils().decoration(
                shadow: true,
                shadowwithcolor:
                    NeumorphicTheme.isUsingDark(context) ? true : false,
                backgroundcolor: NeumorphicTheme.accentColor(context),
                cntx: context,
                isdark: NeumorphicTheme.isUsingDark(context),
                radius: 32.5),
            child: Icon(Icons.add,
                size: 25,
                color: NeumorphicTheme.isUsingDark(context)
                    ? mycolor().Black
                    : mycolor().White)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
