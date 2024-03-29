import '../Config/Import.dart';

class Intervalend extends StatelessWidget {
  final title;
  final hour;
  final minute;
  final second;
  final medium;
  const Intervalend(
      {super.key,
      this.title,
      this.hour,
      this.minute,
      this.second,
      this.medium});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return CardBackground(
      backgroundimage: mediumcardbackground,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw40018,
                color: NeumorphicTheme.defaultTextColor(context)),
          ).paddingOnly(right: 10),
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
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    ":",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  SizedBox(
                    width: 5,
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
                    ":",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    second,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  SizedBox(width: 5),
                  Text(
                    medium,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40014,
                        color: mycolor().greenlightcolor),
                  ),
                ],
              ).paddingSymmetric(
                  horizontal: NeumorphicTheme.isUsingDark(context) ? 8 : 8.0),
            ],
          )
        ],
      ).paddingSymmetric(
          vertical: NeumorphicTheme.isUsingDark(context) ? 8 : 0),
    );
  }
}
