import '../Config/Import.dart';

class AlramCard extends StatelessWidget {
  final String time;
  final String? medium;
  final bool showmedium;
  final showarrowicon;
  final subtitle;
  final showswitchorsubtile;
  final Function? onchange;
  final bool? swicthvalue;
  const AlramCard(
      {super.key,
      required this.time,
      this.medium,
      required this.showmedium,
      this.showarrowicon = false,
      this.subtitle,
      this.showswitchorsubtile = false,
      this.onchange,
      this.swicthvalue = true});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      padding: EdgeInsets.fromLTRB(23 * fem, 13 * fem, 22 * fem, 13 * fem),
      width: MediaQuery.of(context).size.width,
      decoration: Utils().decoration(
          cntx: context,
          isdark: NeumorphicTheme.isUsingDark(context),
          radius: 18.0 * fem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 6 * fem, 0 * fem),
                child: Text(
                  time,
                  style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw40020,
                      color: NeumorphicTheme.accentColor(context)),
                ),
              ),
              if (showmedium)
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 2 * fem, 190 * fem, 0 * fem),
                  child: Text(medium.toString(),
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40018,
                          color: mycolor().greenlightcolor)),
                ),
            ],
          ),
          showswitchorsubtile
              ? Container(
                  width: 30.0,
                  height: 10.0,
                  child: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      onChanged: ((value) {
                        onchange!(value);
                      }),
                      value: swicthvalue!,
                      inactiveThumbColor: mycolor().darkgreen,
                      inactiveTrackColor: mycolor().darkbalck,
                      trackOutlineColor:
                          MaterialStateProperty.resolveWith((states) {
                        // If the button is pressed, return green, otherwise blue
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.transparent;
                        }
                        return Colors.transparent;
                      }),
                      activeColor: mycolor().darkgreen,
                    ),
                  ),
                )
              : Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 6 * fem, 0 * fem),
                      child: Text(
                        subtitle,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw50014,
                            color: mycolor().greenlightcolor),
                      ),
                    ),
                    if (showarrowicon)
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 6 * fem, 0 * fem),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: mycolor().greenlightcolor,
                            fill: 0.5,
                          )),
                  ],
                )
        ],
      ),
    ).paddingSymmetric(horizontal: 15);
  }
}
