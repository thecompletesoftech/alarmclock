import 'package:alarmplayer/alarmplayer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/View/alarm/AlarmScreen.dart';
import '../../Config/FireBase/Getfirebasetoken.dart';
import '../../Config/Import.dart';

class AlarmHome extends StatefulWidget {
  const AlarmHome({super.key});

  @override
  State<AlarmHome> createState() => _AlarmHomeState();
}

class _AlarmHomeState extends State<AlarmHome> {
  bool isSwitched = false;
  var box = GetStorage();
  Alarmplayer alarmplayer = Alarmplayer();
  AlramController _alramController = Get.put(AlramController());

  @override
  void initState() {
    // alarmplayer.StopAlarm();
    notification();
    Future.delayed(const Duration(milliseconds: 1), () {
      _alramController.setalarmfalse();
      GetFirebasetoken().getfirebasetoken();
    });
    super.initState();
  }

  notification() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction) async {
          // print("action -----" + receivedAction.toString());
          // print("Payload===>>>>>>>>>>" +
          //     receivedAction.payload!['currentTime'].toString());
          // var updatedTime =
          //     add5Minutes(receivedAction.payload!['currentTime'].toString());
          // print("Updated Time: $updatedTime");
          // if (bool.parse(receivedAction.payload!['snooze'].toString()) ==
          //     true) {
          //   // alarmplayer.StopAlarm();
          //   shownotification(
          //       receivedAction.payload!['sound'],
          //       bool.parse(receivedAction.payload!['snooze'].toString()),
          //       updatedTime);
          // }
        },
        onNotificationCreatedMethod:
            (ReceivedNotification receivedNotification) async {},
        onNotificationDisplayedMethod:
            (ReceivedNotification receivedNotification) async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AlarmScreen(
                      data: receivedNotification.payload!,
                      id: receivedNotification.id!,
                    )),
          );
        },
        onDismissActionReceivedMethod:
            (ReceivedAction receivedAction) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: GestureDetector(
            onTap: (() {
              // print("adsddsaf");
              // AwesomeNotifications().cancel(123);
            }),
            child: CustomeAppbar(
              list: [
                {"icon": "assets/add.png", "screenname": AddAlram()},
                {"icon": "assets/Save.png", "screenname": EditAlarm()},
                {"icon": "assets/person.png", "screenname": Profile()},
              ],
              ontapnavigate: (value) {
                switch (value) {
                  case 0:
                    Navigator.of(context).push(createRoutes(AddAlram()));
                    break;
                  case 1:
                    nextscreen(context, EditAlarm());
                    break;
                  case 2:
                    nextscreen(context, Profile());
                    break;
                }
              },
              titletext: alarm,
              ontapornavigate: true,
            ),
          ).marginOnly(top: 5)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            Obx(
              () => GestureDetector(
                onTap: (() async {
                  print("ssasa");
                }),
                child: Clock(
                  time: _alramController.currenttime.value == null ||
                          _alramController.currenttime.value == ""
                      ? DateTime.now()
                      : DateTime.parse(_alramController.currenttime.value),
                ),
              ),
            ),
            SizedBox(height: 50),
            Obx(
              () => _alramController.getalarmisloading.value
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder<QuerySnapshot>(
                      stream: ApiHelper()
                          .getsnapshotbyorderbyuserid("alarm", "date", true),
                      builder: (context, snapshot) {
                        if ((snapshot.data == null) ||
                            (snapshot.data!.docs.length < 1)) {
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
                              return Stack(
                                children: [
                                  AlramCard(
                                    showmedium: true,
                                    medium: "   " +
                                        getAmPm(newitem['dateTime'])
                                            .toString()
                                            .toLowerCase(),
                                    onchange: (value) async {
                                      _alramController.alramstatus(
                                          newitem['id'], value, context);
                                    },
                                    ontapcard: () async {
                                      setState(() {
                                        _alramController.currenttime.value =
                                            newitem['date'].toString();
                                      });
                                    },
                                    swicthvalue: newitem['alarmstatus'],
                                    time: convert12to24(newitem['dateTime'])
                                        .toString(),
                                    showswitchorsubtile: true,
                                    subtitle: "",
                                  ).paddingOnly(
                                      bottom:
                                          NeumorphicTheme.isUsingDark(context)
                                              ? 20
                                              : 0,
                                      left: NeumorphicTheme.isUsingDark(context)
                                          ? 5
                                          : 0,
                                      right:
                                          NeumorphicTheme.isUsingDark(context)
                                              ? 5
                                              : 0,
                                      top: 8),
                                  Positioned(
                                    right: NeumorphicTheme.isUsingDark(context)
                                        ? 10
                                        : 13,
                                    top: NeumorphicTheme.isUsingDark(context)
                                        ? 0
                                        : 4,
                                    child: InkWell(
                                      onTap: () {
                                        ApiHelper().deletedata(
                                            'alarm', newitem['docid']);
                                      },
                                      child: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                        size: 22,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
