import '../../Config/Import.dart';
import 'alarmController.dart';

class AlarmHome extends StatefulWidget {
  const AlarmHome({super.key});

  @override
  State<AlarmHome> createState() => _AlarmHomeState();
}

class _AlarmHomeState extends State<AlarmHome> {
  bool isSwitched = false;
  AlramController _alramController = Get.put(AlramController());
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1), () {
      _alramController.getalram();
    });

    // _alramController.currenttime.value = DateTime.now().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": "assets/add.png", "screenname": AddAlram()},
            {"icon": "assets/edit.png", "screenname": EditAlarm()},
            {"icon": "assets/person.png", "screenname": Profile()},
          ], titletext: alarm)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            Obx(
              () => Clock(
                time: _alramController.currenttime.value == null ||
                        _alramController.currenttime.value == ""
                    ? DateTime.now()
                    : DateTime.parse(_alramController.currenttime.value),
              ),
            ),
            SizedBox(height: 50),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("alarm").snapshots(),
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
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot newitem = snapshot.data!.docs[index];
                        return AlramCard(
                          showmedium: true,
                          medium: getAmPm(newitem['dateTime']).toString(),
                          onchange: (value) async {
                            await Alarm.stop(_alramController.alarms[index].id);

                            _alramController.switchlist[index] =
                                !_alramController.switchlist[index];
                          },
                          ontapcard: () async {
                            setState(() {
                              _alramController.currenttime.value =
                                  _alramController.alarms[index].dateTime
                                      .toString();
                            });

                            await _alramController.getalram();
                          },
                          swicthvalue: true,
                          time: convert12to24(newitem['dateTime']).toString(),

                          // convert12to24(_alramController
                          //         .alarms[index].dateTime.hour
                          //         .toString() +
                          //     ":" +
                          //     _alramController
                          //         .alarms[index].dateTime.minute
                          //         .toString()),
                          showswitchorsubtile: true,
                          subtitle: "",
                        ).paddingOnly(bottom: 10, top: 5);
                      });
                }),

            //  ListView.builder(
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: _alramController.alarms.length,
            //     itemBuilder: (context, index) {
            //       return Obx(
            //         () => AlramCard(
            //           showmedium: true,
            //           medium: getAmPm(_alramController
            //                   .alarms[index].dateTime.hour
            //                   .toString())
            //               .toString()
            //               .toLowerCase(),
            //           onchange: (value) async {
            //             await Alarm.stop(
            //                 _alramController.alarms[index].id);

            //             _alramController.switchlist[index] =
            //                 !_alramController.switchlist[index];
            //           },
            //           ontapcard: () async {
            //             setState(() {
            //               _alramController.currenttime.value =
            //                   _alramController.alarms[index].dateTime
            //                       .toString();
            //             });

            //             await _alramController.getalram();
            //           },
            //           swicthvalue: _alramController.switchlist[index],
            //           time: convert12to24(_alramController
            //                   .alarms[index].dateTime.hour
            //                   .toString() +
            //               ":" +
            //               _alramController.alarms[index].dateTime.minute
            //                   .toString()),
            //           showswitchorsubtile: true,
            //           subtitle: "",
            //         ).paddingOnly(bottom: 10, top: 5),
            //       );
            //     },
            //   ),
          ],
        ),
      ),
    );
  }
}
