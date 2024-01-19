import 'package:flutter/cupertino.dart';

import '../../Config/Import.dart';

class AddAlram extends StatefulWidget {
  const AddAlram({super.key});

  @override
  State<AddAlram> createState() => _AddAlramState();
}

class _AddAlramState extends State<AddAlram> {
  var alramlist = [
    {
      "title": "Repeat",
      "subtitle": "Never",
      "showarrow": true,
    },
    {
      "title": "Label",
      "subtitle": "Alarm",
      "showarrow": false,
    },
    {
      "title": "Sound",
      "subtitle": "Apex",
      "showarrow": true,
    },
    {
      "title": "Snooze",
      "subtitle": "Never",
      "showarrow": true,
    }
  ];
  DateTime _selectedTime = DateTime.now();
  String time = "-";
  @override
  Widget build(BuildContext context) {
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
                    Get.back();
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
                Text(save,
                    style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw40014,
                      color: NeumorphicTheme.defaultTextColor(context),
                    )),
              ],
            ).paddingSymmetric(horizontal: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: alramlist.length,
              itemBuilder: (context, index) {
                return AlramCard(
                  showmedium: false,
                  showarrowicon: alramlist[index]['showarrow'],
                  time: alramlist[index]['title'].toString(),
                  subtitle: alramlist[index]['subtitle'].toString(),
                ).paddingOnly(bottom: 10, top: 10);
              },
            )
          ],
        ),
      ),
    );
  }
}
