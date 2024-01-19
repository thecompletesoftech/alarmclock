import 'package:clockalarm/Config/Import.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
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
                          Container(
                              height: 50,
                              width: 100,
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
                                        color:
                                            NeumorphicTheme.baseColor(context)),
                                  )))
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/alramclock.png")),
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
                            "timetext",
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
                            "remianingtimetext",
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40020,
                                color: mycolor().greenlightcolor),
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
                            "snoozetime",
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
                            "repeattime",
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

              // Container(
              //     decoration: Utils().decoration(
              //         cntx: context,
              //         isdark: NeumorphicTheme.isUsingDark(context),
              //         radius: 10.5 * fem),
              //     width: MediaQuery.sizeOf(context).width,
              //     padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              //     height: 330,
              //     alignment: Alignment.topLeft,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               betatext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw60024,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             ),
              //             Container(
              //                 height: 50,
              //                 width: 100,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: NeumorphicTheme.accentColor(context),
              //                 ),
              //                 child: TextButton(
              //                     onPressed: () {},
              //                     child: Text(
              //                       done,
              //                       style: MyTextStyle.Dynamic(
              //                           style: MyTextStyle.mw50018,
              //                           color:
              //                               NeumorphicTheme.baseColor(context)),
              //                     )))
              //           ],
              //         ),
              //         SizedBox(height: 2),
              //         Row(
              //           children: [
              //             Container(
              //                 height: 20,
              //                 width: 20,
              //                 child: Image.asset("assets/alramclock.png")),
              //             SizedBox(width: 4),
              //             Text(
              //               "05:15 pm",
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw50018,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 28),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               duration,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               timetext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               remianingtext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               remianingtimetext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: mycolor().greenlightcolor),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               snoozetext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               snoozetime,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               repeattext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               repeattime,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //       ],
              //     )),
              // SizedBox(
              //   height: 24,
              // ),
              // Container(
              //     decoration: Utils().decoration(
              //         cntx: context,
              //         isdark: NeumorphicTheme.isUsingDark(context),
              //         radius: 10.5 * fem),
              //     width: MediaQuery.sizeOf(context).width,
              //     padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              //     height: 330,
              //     alignment: Alignment.topLeft,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               gammatext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw60024,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             ),
              //             Container(
              //                 height: 50,
              //                 width: 100,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: NeumorphicTheme.accentColor(context),
              //                 ),
              //                 child: TextButton(
              //                     onPressed: () {},
              //                     child: Text(
              //                       done,
              //                       style: MyTextStyle.Dynamic(
              //                           style: MyTextStyle.mw50018,
              //                           color:
              //                               NeumorphicTheme.baseColor(context)),
              //                     )))
              //           ],
              //         ),
              //         SizedBox(height: 2),
              //         Row(
              //           children: [
              //             Container(
              //                 height: 20,
              //                 width: 20,
              //                 child: Image.asset("assets/alramclock.png")),
              //             SizedBox(width: 4),
              //             Text(
              //               "05:15 pm",
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw50018,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 28),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               duration,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               timetext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               remianingtext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               remianingtimetext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: mycolor().greenlightcolor),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               snoozetext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               snoozetime,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               repeattext,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40018,
              //                   color:
              //                       NeumorphicTheme.defaultTextColor(context)),
              //             ),
              //             Text(
              //               repeattime,
              //               style: MyTextStyle.Dynamic(
              //                   style: MyTextStyle.mw40020,
              //                   color: NeumorphicTheme.accentColor(context)),
              //             )
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //       ],
              //     )),
              // SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
