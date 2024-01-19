import 'package:clockalarm/Config/Import.dart';

class CardWidget extends StatelessWidget {
  final title;
  final Function? ontap;
  const CardWidget({super.key, this.title = '', this.ontap});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return InkWell(
      onTap: () {
        ontap!();
      },
      child: Container(
        decoration: Utils().decoration(
            cntx: context,
            isdark: NeumorphicTheme.isUsingDark(context),
            radius: 10.5 * fem),
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(left: 32.0, top: 16.0, right: 16.0),
        height: 60,
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw40018,
              color: NeumorphicTheme.accentColor(context)),
        ),
      ),
    );
  }
}
