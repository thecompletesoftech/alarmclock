import '../Config/Import.dart';

class AlphaAlarmCard extends StatelessWidget {
  final title;
  final hour;
  final minute;
  final time;
  const AlphaAlarmCard({
    super.key,
    this.title,
    this.hour,
    this.minute,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return CardBackground(
      backgroundimage: mediumcardbackground,
      child: Padding(
        padding: EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: NeumorphicTheme.isUsingDark(context) ? 6 : 0,
            bottom: NeumorphicTheme.isUsingDark(context) ? 6 : 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw40018,
                  color: NeumorphicTheme.accentColor(context)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      hour,
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40018,
                          color: NeumorphicTheme.accentColor(context)),
                    ),
                    Text(
                      ":",
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40018,
                          color: NeumorphicTheme.accentColor(context)),
                    ),
                    Text(
                      minute,
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40018,
                          color: NeumorphicTheme.accentColor(context)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      time,
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40014,
                          color: mycolor().greenlightcolor),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
