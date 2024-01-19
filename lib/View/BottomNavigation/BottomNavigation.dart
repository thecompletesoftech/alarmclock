import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/Config/SvgString.dart';
import 'package:clockalarm/View/Auth/Home/Home.dart';
import 'package:clockalarm/View/alarm/Alarmhome.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewBottomNavigator extends StatefulWidget {
  NewBottomNavigator({super.key, this.passIndex, this.userId});
  final int? passIndex;
  final String? userId;
  @override
  State<NewBottomNavigator> createState() => New_BottomNavigatorState();
}

class New_BottomNavigatorState extends State<NewBottomNavigator> {
  int selectedIndex = 0;
  String? userId;
  void initState() {
    super.initState();
    selectedIndex = widget.passIndex ?? 0;
    userId = widget.userId;
    setState(() {});
  }

  int backIndex = 0;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: selectedIndex == 0
          ? AlarmHome()
          : selectedIndex == 1
              ? SignIn()
              : selectedIndex == 2
                  ? Home()
                  : SignIn(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          unselectedItemColor: NeumorphicTheme.accentColor(context),
          selectedItemColor: NeumorphicTheme.isUsingDark(context)
              ? mycolor().lightWhite
              : mycolor().lightBlack,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: MyTextStyle.Dynamic(
              style: MyTextStyle.mw50010,
              color: NeumorphicTheme.accentColor(context)),
          selectedLabelStyle: MyTextStyle.Dynamic(
              style: MyTextStyle.mw50010,
              color: NeumorphicTheme.isUsingDark(context)
                  ? mycolor().White
                  : NeumorphicTheme.baseColor(context)),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 56,
                  width: 57,
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 15.5 * fem),
                  child: Center(
                    child: SvgPicture.string(
                      internetsvg,
                      height: 30.0,
                    ),
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(13.0))),
                  child: Container(
                    height: 56,
                    width: 57,
                    child: Center(
                      child: SvgPicture.string(
                        inactiveinternetsvg,
                        height: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
              label: worldclock,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 56,
                  width: 57,
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 15.5 * fem),
                  child: Center(
                    child: SvgPicture.string(
                      alarmsvg,
                      height: 30.0,
                    ),
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(13.0))),
                  child: Container(
                    height: 56,
                    width: 57,
                    child: Center(
                      child: SvgPicture.string(
                        inactivealarmsvg,
                        height: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
              label: alarm,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 56,
                  width: 57,
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 15.5 * fem),
                  child: Center(
                    child: SvgPicture.string(
                      stopwatchsvg,
                      height: 30.0,
                    ),
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(13.0))),
                  child: Container(
                    height: 56,
                    width: 57,
                    child: Center(
                      child: SvgPicture.string(
                        inactivestopwatchsvg,
                        height: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
              label: stopwatch,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 56,
                  width: 57,
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 15.5 * fem),
                  child: Center(
                    child: SvgPicture.string(
                      timersvg,
                      height: 30.0,
                    ),
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(13.0))),
                  child: Container(
                    height: 56,
                    width: 57,
                    child: Center(
                      child: SvgPicture.string(
                        inactivetimersvg,
                        height: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
              label: mivstimer,
            ),
          ],
          currentIndex: selectedIndex,
          backgroundColor: NeumorphicTheme.baseColor(context),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) async {
    backIndex = selectedIndex;
    setState(() {
      selectedIndex = index;
    });
  }
}
