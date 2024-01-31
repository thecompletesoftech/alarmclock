import '../Config/Import.dart';

class TimeNameCard extends StatelessWidget {
  final title;
  final interval;
  const TimeNameCard({super.key, this.title, this.interval});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return CardBackground(
      backgroundimage: mediumcardbackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw40018,
                color: NeumorphicTheme.defaultTextColor(context)),
          ),
          Row(
            children: [
              Neumorphic(
                  style: NeumorphicStyle(
                    depth: NeumorphicTheme.embossDepth(context),
                    boxShape: buttonradius(),
                  ),
                  child: Container(
                    // height: 50,
                    width: 146,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      interval.toString(),
                      textAlign: TextAlign.center,
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40018,
                          color: NeumorphicTheme.accentColor(context)),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
