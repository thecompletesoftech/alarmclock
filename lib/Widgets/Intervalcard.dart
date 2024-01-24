import '../Config/Import.dart';

class IntervalCard extends StatelessWidget {
  final title;
  final interval;
  const IntervalCard({super.key, this.title, this.interval});

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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      interval.toString(),
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40018,
                          color: NeumorphicTheme.accentColor(context)),
                    ),
                  )),
              SizedBox(
                width: 20,
              ),
              Text(
                times,
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw40018,
                    color: mycolor().greenlightcolor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
