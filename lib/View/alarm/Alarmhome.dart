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
    _alramController.getalram();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": "assets/add.png", "screenname": AddAlram()},
            {"icon": "assets/edit.png", "screenname": ""},
            {"icon": "assets/person.png", "screenname": Profile()},
          ], titletext: alarm)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            Clock(),
            SizedBox(height: 50),
            Obx(
              () => _alramController.alarms.length == 0
                  ? Center(child: Text("No Any alram found"))
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _alramController.alarms.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => AlramCard(
                            showmedium: true,
                            medium: 'pm',
                            onchange: (value) async {
                              await Alarm.stop(
                                  _alramController.alarms[index].id);
                              setState(() {
                                _alramController.switchlist[index] =
                                    !_alramController.switchlist[index];
                              });
                            },
                            swicthvalue: _alramController.switchlist[index],
                            time: _alramController.alarms[index].dateTime.hour
                                    .toString() +
                                ":" +
                                _alramController.alarms[index].dateTime.minute
                                    .toString() +
                                " ",
                            showswitchorsubtile: true,
                            subtitle: "",
                          ).paddingOnly(bottom: 10, top: 5),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
