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
    _alramController.currentsoundpath.value = "resource://raw/immigrantsong";
    _alramController.currentsound.value = "Immigrant Song";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Stack(
        children: [
          Container(
            height: 100,
            color: NeumorphicTheme.isUsingDark(context)
                ? mycolor().shadowcolordark
                : mycolor().lighterWhite,
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              color: NeumorphicTheme.baseColor(context),
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
                    ontapcard: () {
                      Navigator.of(context).push(createRoutes(Repeat()));
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
                        Navigator.of(context).push(createRoutes(Sound()));
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
          ),
          Obx(() => _alramController.addalarmisloading.value
              ? Center(child: CircularProgressIndicator())
              : Container()),
        ],
      ),
    );
  }
}
