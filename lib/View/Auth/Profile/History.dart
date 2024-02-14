import 'package:clockalarm/Config/Import.dart';

import '../../../Widgets/TimerHistoryCard.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (() {
                  backscreen(context);
                }),
                child: Icon(
                  Icons.arrow_back,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              Text(
                timerhistory,
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw60022,
                    color: NeumorphicTheme.accentColor(context)),
              ),
              Container(),
            ],
          ).paddingSymmetric(horizontal: 15),
        ).marginOnly(top: 8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 20 : 0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TimerHistoryCard(
                    alarmtime: '05:15 pm',
                    duration: '00 : 45 : 00',
                    remaining: '00 : 00 : 00',
                    repeat: '00 : 05 : 00',
                    snooze: '07 : 15 : 00',
                    title: 'Alpha',
                  ).paddingOnly(
                      bottom: NeumorphicTheme.isUsingDark(context) ? 30 : 0);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
