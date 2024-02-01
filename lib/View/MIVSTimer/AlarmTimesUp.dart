import 'package:clockalarm/Widgets/largeCardBackground.dart';

import '../../Coming/TimeList.dart';
import '../../Config/Import.dart';
import '../../Widgets/AlphaAlarmCard.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/RepeatIntervalCard.dart';

class AlramTimesup extends StatefulWidget {
  const AlramTimesup({super.key});

  @override
  State<AlramTimesup> createState() => _AlramTimesupState();
}

class _AlramTimesupState extends State<AlramTimesup> {
  var checkdata = [];
  var list = [
    {
      'id': 1,
      'name': 'Start next interval only',
    },
    {
      'id': 2,
      'name': 'Start Next Interval Increase Interval \nby Snooze Duration',
    },
    {
      'id': 3,
      'name': 'Start Next Interval Decrease Interval \nby Snooze Duration',
    },
    {
      'id': 4,
      'name': 'Cancel All Intervals',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/list.png", "screenname": TimeList()},
              {"icon": "assets/add.png", "screenname": TimeList()},
            ],
            titletext: alarm,
            showdivider: true,
            showarrow: true,
            showlistbtn: true,
            showsubtitle: true,
            subtitle: timeuptext,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              AlphaAlarmCard(
                  title: alarmeat, hour: '5', minute: '15', time: 'PM'),
              SizedBox(height: 20),
              RepeatIntervalCard(title: repeatinttext, interval: 4),
              SizedBox(height: 20),
              LargeCardBackground(
                child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: list.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var items = list[index];
                          var show = checkdata
                              .where((element) => element['id'] == items['id']);
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    show.length > 0
                                        ? checkdata.remove(items)
                                        : checkdata.add(items);
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(items['name'].toString(),
                                          style: MyTextStyle.Dynamic(
                                            style: MyTextStyle.mw50012,
                                            color: NeumorphicTheme.isUsingDark(
                                                    context)
                                                ? mycolor().White
                                                : mycolor().lighttxtcolor,
                                          )),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        show.length > 0
                                            ? Image.asset(
                                                NeumorphicTheme.isUsingDark(
                                                        context)
                                                    ? 'assets/uncheckbox.png'
                                                    : 'assets/checkboxbg.png',
                                                height: 30,
                                              )
                                            : Image.asset(
                                                NeumorphicTheme.isUsingDark(
                                                        context)
                                                    ? 'assets/uncheckbox.png'
                                                    : 'assets/uncheckbg.png',
                                                height: 30,
                                              ),
                                        if (show.length > 0)
                                          Icon(
                                            Icons.done,
                                            color: NeumorphicTheme
                                                .defaultTextColor(context),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ).paddingSymmetric(
                                vertical: 15,
                              ),
                            ],
                          );
                        })
                    .paddingOnly(
                        bottom: NeumorphicTheme.isUsingDark(context) ? 0 : 20,
                        top: NeumorphicTheme.isUsingDark(context) ? 0 : 20),
              ),
              SizedBox(height: 150),
              ButtonWidget(
                name: proceed,
                txtstyle: MyTextStyle.mw40020,
                borderRadius: 15.0,
                onTap: () {},
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  checkbox(title) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Row(
      children: [
        Text(
          title,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw50012,
              color: NeumorphicTheme.defaultTextColor(context)),
        ),
        Image.asset(
          "assets/checkbox.png",
          height: 20,
          width: 20,
        )
      ],
    );
  }
}
