import 'package:clockalarm/Config/Import.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back,
              color: mycolor().White,
            ),
            Text(
              timerhistory,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw60024,
                  color: NeumorphicTheme.accentColor(context)),
            ),
            Container(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            // MIVSCardWidget(title: "oighogh",)
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            alphatext,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw60024,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: NeumorphicTheme.accentColor(context),
                              ),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    done,
                                    style: MyTextStyle.Dynamic(
                                        style: MyTextStyle.mw50018,
                                        color: Colors.black),
                                  )))
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.lock_clock,
                            color: NeumorphicTheme.accentColor(context),
                          ),
                          Text(
                            "05:15 pm",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw50018,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        duration,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018, color: mycolor().White),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
