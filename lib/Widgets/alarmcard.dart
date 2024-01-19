import '../Config/Import.dart';
import '../Config/Utils.dart';

class AlramCard extends StatelessWidget {
  final String time;
  final String medium;
  const AlramCard({super.key, required this.time, required this.medium});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      padding: EdgeInsets.fromLTRB(23 * fem, 13 * fem, 22 * fem, 13 * fem),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: Utils().decoration(
          cntx: context,
          isdark: NeumorphicTheme.isUsingDark(context),
          radius: 18.0 * fem),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // bbz (53:508)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 6 * fem, 0 * fem),
                child: Text(
                  time,
                  style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw40020,
                      color: NeumorphicTheme.accentColor(context)),
                ),
              ),
              Container(
                // pmXEk (53:509)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 2 * fem, 190 * fem, 0 * fem),
                child: Text(medium,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: mycolor().greenlightcolor)),
              ),
            ],
          ),
          // Container(
          //   width: 50.0,
          //   child: Switch(
          //     onChanged: ((value) {
          //       setState(() {
          //         isSwitched = value;
          //       });
          //     }),
          //     value: isSwitched,
          //     activeColor: Colors.blue,
          //     activeTrackColor: Colors.yellow,
          //     inactiveThumbColor: Colors.redAccent,
          //     inactiveTrackColor: Colors.orange,
          //   ),
          // ),
        ],
      ),
    ).paddingSymmetric(horizontal: 15);
  }
}
