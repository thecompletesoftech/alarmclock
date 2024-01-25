import 'package:flutter_switch/flutter_switch.dart';

import '../Config/Import.dart';

class AlramCard extends StatefulWidget {
  final String time;
  final String? medium;
  final bool showmedium;
  final showarrowicon;
  final subtitle;
  final showswitchorsubtile;
  final subtitlestyle;
  final subtitlecolor;
  final Function? onchange;
  final Function? ontapcard;
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
      this.swicthvalue = true,
      this.ontapcard,
      this.subtitlestyle,
      this.subtitlecolor});

  @override
  State<AlramCard> createState() => _AlramCardState();
}

class _AlramCardState extends State<AlramCard> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: (() {
        widget.ontapcard!();
      }),
      child: CardBackground(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.time,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40020,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                ),
                if (widget.showmedium)
                  Container(
                    child: Text(widget.medium.toString(),
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: mycolor().greenlightcolor)),
                  ),
              ],
            ),
            widget.showswitchorsubtile
                ? FlutterSwitch(
                    width: 70.0,
                    height: 26.0,
                    valueFontSize: 25.0,
                    toggleSize: 25.0,
                    value: widget.swicthvalue!,
                    borderRadius: 30.0,
                    padding: 1.0,
                    showOnOff: false,
                    activeColor: mycolor().darkgreen,
                    inactiveColor: !NeumorphicTheme.isUsingDark(context)
                        ? mycolor().greyscreen
                        : mycolor().darkbalck,
                    onToggle: (val) {
                      widget.onchange!(val);
                    },
                  )

                // Container(
                //     width: 30.0,
                //     height: 10.0,
                //     child: Transform.scale(
                //       scale: 0.8,
                //       child: Switch(
                //         onChanged: ((value) {
                //           widget.onchange!(value);
                //         }),
                //         value: widget.swicthvalue!,
                //         inactiveThumbColor: mycolor().darkgreen,
                //         inactiveTrackColor:
                //             !NeumorphicTheme.isUsingDark(context)
                //                 ? mycolor().greyscreen
                //                 : mycolor().darkbalck,
                //         trackOutlineColor:
                //             MaterialStateProperty.resolveWith((states) {
                //           // If the button is pressed, return green, otherwise blue
                //           if (states.contains(MaterialState.pressed)) {
                //             return Colors.transparent;
                //           }
                //           return Colors.transparent;
                //         }),
                //         activeColor: mycolor().darkgreen,
                //       ),
                //     ),
                //   ).paddingOnly(right: 5)
                : Row(
                    children: [
                      Container(
                        child: Text(
                          widget.subtitle.toString(),
                          style: MyTextStyle.Dynamic(
                              style:
                                  widget.subtitlestyle ?? MyTextStyle.mw50014,
                              color: widget.subtitlecolor ??
                                  mycolor().greenlightcolor),
                        ),
                      ).paddingOnly(right: 15),
                      if (widget.showarrowicon)
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
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
