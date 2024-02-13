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
              ).paddingOnly(right: 10),
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
      ).paddingSymmetric(
          vertical: NeumorphicTheme.isUsingDark(context) ? 3 : 0),
    );
  }
}
