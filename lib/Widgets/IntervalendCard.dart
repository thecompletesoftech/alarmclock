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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: Utils().decoration(
          cntx: context,
          isdark: NeumorphicTheme.isUsingDark(context),
          radius: 15.5 * fem),
      width: MediaQuery.sizeOf(context).width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw40018,
                color: NeumorphicTheme.defaultTextColor(context)),
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ":",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    minute,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ":",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    second,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  SizedBox(width: 20),
                  Text(
                    medium,
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
    );
  }
}
