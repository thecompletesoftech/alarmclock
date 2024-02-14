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
          Container(
            width: 150,
            child: TextBoxwidget(
              iconorimage: true,
              suffixshowicon: true,
              hinttext: 'Alpha',
              toppadding: 10.0,
              bottompadding: 10.0,
              radius: 10.0,
              accentcolor: NeumorphicTheme.accentColor(context),
              basecolor: NeumorphicTheme.baseColor(context),
              validator: (e) {
                return null;
              },
              // showerror: emailerror,
              // errormsg: emailerrmsg,
            ),
          ).paddingOnly(right: 10),
        ],
      ).paddingSymmetric(
          vertical: NeumorphicTheme.isUsingDark(context) ? 4 : 0),
    );
  }
}
