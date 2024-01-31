import 'package:clockalarm/View/alarm/Sound.dart';
import 'package:flutter/cupertino.dart';

import '../../Config/Import.dart';
import 'Repeat.dart';
import 'alarmController.dart';

class AddAlram extends StatefulWidget {
  const AddAlram({super.key});

  @override
  State<AddAlram> createState() => _AddAlramState();
}

class _AddAlramState extends State<AddAlram> {
  AlramController _alramController = Get.put(AlramController());

  DateTime _selectedTime = DateTime.now();
  String time = "-";
  bool isSwitched = false;
  @override
  void initState() {
    _alramController.currentsoundpath.value =
        "assets/ringtone/ImmigrantSong.mp3";
    _alramController.currentsound.value = "Immigrant Song";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (() {
                    backscreen(context);
                  }),
                  child: Text(cancel,
                      style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40014,
                        color: NeumorphicTheme.defaultTextColor(context),
                      )),
                ),
                Text(
                  addalarm,
                  style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw60018,
                      color: NeumorphicTheme.accentColor(context)),
                ),
                GestureDetector(
                  onTap: () async {
                    await _alramController.setAlarm(_selectedTime, isSwitched,
                        _alramController.currentsoundpath.value, context);
                    await _alramController.getalram(context);

                    backscreen(context);
                  },
                  child: Text(save,
                      style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40014,
                        color: NeumorphicTheme.defaultTextColor(context),
                      )),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle:
                        TextStyle(color: NeumorphicTheme.accentColor(context)),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (newTime) {
                    setState(() {
                      _selectedTime = newTime;
                      time = "${_selectedTime.hour} : ${_selectedTime.minute}";
                    });
                  },
                ),
              ),
            ),
            AlramCard(
              showmedium: false,
              showswitchorsubtile: false,
              showarrowicon: true,
              time: "Repeat",
              subtitle: "Never",
              ontapcard: () {
                nextscreen(context, Repeat());
              },
            ).paddingOnly(bottom: 10, top: 10),
            AlramCard(
              showmedium: false,
              showswitchorsubtile: false,
              showarrowicon: false,
              time: "Label",
              subtitle: "Alarm",
              ontapcard: () {},
            ).paddingOnly(bottom: 10, top: 10),
            Obx(
              () => AlramCard(
                showmedium: false,
                showswitchorsubtile: false,
                showarrowicon: true,
                time: "Sound",
                subtitle: _alramController.currentsound.value.toString(),
                ontapcard: () {
                  nextscreen(context, Sound());
                },
              ).paddingOnly(bottom: 10, top: 10),
            ),
            AlramCard(
              showmedium: false,
              showswitchorsubtile: true,
              showarrowicon: false,
              time: "Snooze",
              subtitle: "",
              ontapcard: () {},
              onchange: (value) {
                setState(() {
                  isSwitched = !isSwitched;
                });
              },
              swicthvalue: isSwitched,
            ).paddingOnly(bottom: 10, top: 10),
          ],
        ),
      ),
    );
  }
}
