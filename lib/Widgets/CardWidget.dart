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
      child: CardBackground(
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
