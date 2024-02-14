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
            Container(
              width: 50,
              child: TextBoxwidget(
                iconorimage: true,
                suffixshowicon: true,
                hinttext: '4',
                hintstyle: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw40016,
                    color: NeumorphicTheme.accentColor(context)),
                toppadding: 10.0,
                bottompadding: 10.0,
                leftpadding: 10.0,
                radius: 10.0,
                keyboradtype: TextInputType.number,
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw40016,
                    color: NeumorphicTheme.accentColor(context)),
                accentcolor: NeumorphicTheme.accentColor(context),
                basecolor: NeumorphicTheme.baseColor(context),
                validator: (e) {
                  return null;
                },
                // showerror: emailerror,
                // errormsg: emailerrmsg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
