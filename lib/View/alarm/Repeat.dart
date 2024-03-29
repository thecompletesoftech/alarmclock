import 'dart:developer';

import '../../Config/Import.dart';

class Repeat extends StatefulWidget {
  const Repeat({super.key});

  @override
  State<Repeat> createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {
  AlramController _alramController = Get.put(AlramController());

  String time = "-";
  bool isSwitched = false;
  var selected = [];

  @override
  void initState() {
    setState(() {
      selected = List.filled(_alramController.alramlist.length, false);
    });
    setdata();
    super.initState();
  }

  setdata() {
    for (var i = 0; i < _alramController.alramlist.length; i++) {
      _alramController.selectedweekdaylist
                  .contains(_alramController.alramlist[i]['id']) ==
              true
          ? setState(() {
              selected[i] = true;
            })
          : setState(() {
              selected[i] = false;
            });
    }
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
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          backscreen(context);
                        }),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: mycolor().greenlightcolor,
                              size: 15.0,
                              fill: 0.5,
                            ),
                            SizedBox(width: 5),
                            Text(back,
                                style: MyTextStyle.Dynamic(
                                  style: MyTextStyle.mw40014,
                                  color:
                                      NeumorphicTheme.defaultTextColor(context),
                                )),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 20, vertical: 5),
                      Center(
                        child: Text(
                          repeat,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw60018,
                              color: NeumorphicTheme.accentColor(context)),
                        ),
                      ).paddingSymmetric(horizontal: 20),
                    ],
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _alramController.alramlist.length,
                    itemBuilder: (context, index) {
                      return AlramCard(
                        showmedium: false,
                        showswitchorsubtile: false,
                        showarrowicon: false,
                        showcheck: selected[index],
                        bgshow: true,
                        time: _alramController.alramlist[index]['title']
                            .toString(),
                        subtitle: "",
                        ontapcard: () {
                          if (_alramController.selectedweekdaylist.contains(
                                  _alramController.alramlist[index]['id']) ==
                              true) {
                            setState(() {
                              selected[index] = false;
                            });
                            _alramController.selectedweekdaylist.remove(
                                _alramController.alramlist[index]['id']);
                          } else {
                            _alramController.selectedweekdaylist
                                .add(_alramController.alramlist[index]['id']);
                            setState(() {
                              selected[index] = true;
                            });
                          }
                          print(
                              _alramController.selectedweekdaylist.toString());
                          // nextscreen(context, Repeat());
                        },
                        onchange: (value) {
                          setState(() {
                            isSwitched = !isSwitched;
                          });
                        },
                        swicthvalue: isSwitched,
                      ).paddingOnly(
                          bottom: NeumorphicTheme.isUsingDark(context) ? 15 : 5,
                          top: NeumorphicTheme.isUsingDark(context) ? 15 : 0,
                          left: 5,
                          right: 5);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
