import '../Config/Import.dart';

class Timercard extends StatelessWidget {
  final title;
  final hour;
  final minute;
  final second;
  const Timercard({super.key, this.title, this.hour, this.minute, this.second});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        hours,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40010,
                            color: mycolor().greenlightcolor),
                      ),
                      Text(
                        hour,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    ],
                  ),
                  Text(
                    ":",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  Column(
                    children: [
                      Text(
                        miniute,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40010,
                            color: mycolor().greenlightcolor),
                      ),
                      Text(
                        minute,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    ],
                  ),
                  Text(
                    ":",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw40018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  Column(
                    children: [
                      Text(
                        seconds,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40010,
                            color: mycolor().greenlightcolor),
                      ),
                      Text(
                        second,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    ],
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
