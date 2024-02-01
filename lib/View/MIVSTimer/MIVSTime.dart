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
          preferredSize: Size.fromHeight(80),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/TimeMachine.png", "screenname": PendingTimer()},
              {"icon": "assets/person.png", "screenname": Profile()},
            ],
            titletext: timerlist,
            showdivider: true,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("mivstime")
                      // .where("uid", isEqualTo: box.read('uid'))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
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
                      // itemCount: snapshot.data!.docs.length,
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
                cntx: context,
                isdark: NeumorphicTheme.isUsingDark(context),
                radius: 32.5),
            child: Icon(
              Icons.add,
              color: NeumorphicTheme.accentColor(context),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
