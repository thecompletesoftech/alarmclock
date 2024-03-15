import 'package:clockalarm/View/alarm/Sound.dart';
import 'package:flutter/cupertino.dart';
import '../../Config/Import.dart';
import 'Repeat.dart';

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
    _alramController.selectedweekdaylist.clear();
    _alramController.currentsoundpath.value = "resource://raw/immigrantsong";
    _alramController.currentsoundassets.value = "assets/ringtone/Super-Mario.mp3";
    _alramController.currentsound.value = "Immigrant Song";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.isUsingDark(context)
          ? mycolor().shadowcolordark
          : mycolor().lighterWhite,
      body: Stack(
        children: [
          Container(
            height: 100,
            color: NeumorphicTheme.baseColor(context),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              color: NeumorphicTheme.isUsingDark(context)
                  ? mycolor().shadowcolordark
                  : mycolor().lighterWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20),
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
                          await _alramController.setAlarm(
                              _selectedTime,
                              isSwitched,
                              _alramController.currentsoundpath.value,
                              context);
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
                          dateTimePickerTextStyle: TextStyle(
                              color: NeumorphicTheme.accentColor(context)),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (newTime) {
                          setState(() {
                            _selectedTime = newTime;
                            time =
                                "${_selectedTime.hour} : ${_selectedTime.minute}";
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
                    bgshow: true,
                    ontapcard: () {
                      Navigator.of(context).push(createRoutes(Repeat()));
                    },
                  ).paddingOnly(
                      bottom: NeumorphicTheme.isUsingDark(context) ? 15 : 5,
                      top: NeumorphicTheme.isUsingDark(context) ? 15 : 5),
                  AlramCard(
                    showmedium: false,
                    showswitchorsubtile: false,
                    showarrowicon: false,
                    time: "Label",
                    subtitle: "Alarm",
                    bgshow: true,
                    ontapcard: () {},
                  ).paddingOnly(
                      bottom: NeumorphicTheme.isUsingDark(context) ? 15 : 5,
                      top: NeumorphicTheme.isUsingDark(context) ? 15 : 5),
                  Obx(
                    () => AlramCard(
                      showmedium: false,
                      showswitchorsubtile: false,
                      showarrowicon: true,
                      bgshow: true,
                      time: "Sound",
                      subtitle: _alramController.currentsound.value.toString(),
                      ontapcard: () {
                        Navigator.of(context).push(createRoutes(Sound()));
                      },
                    ).paddingOnly(
                        bottom: NeumorphicTheme.isUsingDark(context) ? 15 : 5,
                        top: NeumorphicTheme.isUsingDark(context) ? 15 : 5),
                  ),
                  AlramCard(
                    showmedium: false,
                    showswitchorsubtile: true,
                    showarrowicon: false,
                    bgshow: true,
                    time: "Snooze",
                    subtitle: "",
                    ontapcard: () {},
                    onchange: (value) {
                      setState(() {
                        isSwitched = !isSwitched;
                      });
                    },
                    swicthvalue: isSwitched,
                  ).paddingOnly(
                      bottom: NeumorphicTheme.isUsingDark(context) ? 15 : 5,
                      top: NeumorphicTheme.isUsingDark(context) ? 15 : 5),
                ],
              ),
            ),
          ),
          Obx(() => _alramController.addalarmisloading.value
              ? Center(child: CircularProgressIndicator())
              : Container()),
        ],
      ),
    );
  }
}
