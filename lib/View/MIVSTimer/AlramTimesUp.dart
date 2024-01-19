import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/alarm/Addalarm.dart';

class AlramTimesUp extends StatelessWidget {
  const AlramTimesUp({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": Icons.add, "screenname": AddAlram()},
            {"icon": Icons.person_outline_outlined, "screenname": null},
          ], titletext: timertext)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Divider(color: NeumorphicTheme.accentColor(context)),
              SizedBox(
                height: 1,
              ),
              Container(
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 10.5 * fem),
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  height: 330,
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alphatext,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw60024,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: Utils().decoration(
                                      cntx: context,
                                      isdark:
                                          NeumorphicTheme.isUsingDark(context),
                                      radius: 32.5 * fem),
                                  child: Icon(
                                    Icons.pause_rounded,
                                    color: NeumorphicTheme.accentColor(context),
                                  )),
                              SizedBox(width: 15),
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: Utils().decoration(
                                      cntx: context,
                                      isdark:
                                          NeumorphicTheme.isUsingDark(context),
                                      radius: 32.5 * fem),
                                  child: Icon(
                                    Icons.power_settings_new_outlined,
                                    color: NeumorphicTheme.accentColor(context),
                                  )),
                          
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.add_alarm_outlined,
                            color: NeumorphicTheme.accentColor(context),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "05:15 pm",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw50018,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            duration,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40018,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                          Text(
                            timetext,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40020,
                                color: NeumorphicTheme.accentColor(context)),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            remianingtext,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40018,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                          Text(
                            remianingtimetext,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40020,
                                color:  NeumorphicTheme.accentColor(context)),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snoozetext,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40018,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                          Text(
                            snoozetime,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40020,
                                color: NeumorphicTheme.accentColor(context)),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            repeattext,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40018,
                                color:
                                    NeumorphicTheme.defaultTextColor(context)),
                          ),
                          Text(
                            repeattime,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40020,
                                color: NeumorphicTheme.accentColor(context)),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  )),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
