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
            Obx(
              () => _alramController.getalarmisloading.value
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("alarm")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              noanyalarfound,
                              style: MyTextStyle.Dynamic(
                                  style: MyTextStyle.mw50018,
                                  color: NeumorphicTheme.defaultTextColor(
                                      context)),
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot newitem =
                                  snapshot.data!.docs[index];
                              return AlramCard(
                                showmedium: true,
                                medium: getAmPm(newitem['dateTime']).toString(),
                                onchange: (value) async {
                                  await Alarm.stop(newitem['id']);
                                  _alramController.alramstatus(
                                      newitem['id'],
                                      newitem['alarmstatus'] == true
                                          ? false
                                          : true);
                                },
                                ontapcard: () async {
                                  setState(() {
                                    _alramController.currenttime.value =
                                        newitem['date'].toString();
                                  });

                                  await _alramController.getalram();
                                },
                                swicthvalue: newitem['alarmstatus'],
                                time: convert12to24(newitem['dateTime'])
                                    .toString(),
                                showswitchorsubtile: true,
                                subtitle: "",
                              ).paddingOnly(bottom: 10, top: 5);
                            });
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
