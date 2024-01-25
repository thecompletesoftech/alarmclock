import 'package:clockalarm/Config/Import.dart';

import '../../../Widgets/TimerHistoryCard.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: false,
        title: Row(
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
                  style: MyTextStyle.mw60024, color: mycolor().lighttxtcolor),
            ),
            Container(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: 10),
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
