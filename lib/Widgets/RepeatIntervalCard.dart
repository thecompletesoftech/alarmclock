import '../Config/Import.dart';

class RepeatIntervalCard extends StatelessWidget {
  final title;
  final interval;
  const RepeatIntervalCard({super.key, this.title, this.interval});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return CardBackground(
      backgroundimage: mediumcardbackground,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw40018,
                  color: NeumorphicTheme.accentColor(context)),
            ).paddingOnly(right: 5),
            Row(
              children: [
                Neumorphic(
                    style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: buttonradius(),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                      child: Text(
                        interval.toString(),
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
