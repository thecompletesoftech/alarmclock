import 'package:clockalarm/Config/Import.dart';

class CardWidget extends StatelessWidget {
  final title;
  final Function? ontap;
  final controller;
  final child;
  final icon;
  const CardWidget(
      {super.key,
      this.title = '',
      this.ontap,
      this.controller,
      this.child,
      this.icon});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: () {
        ontap!();
      },
      child: CardBackground(
        child: Row(
          children: [
            Text(
              title,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw40018,
                  color: NeumorphicTheme.accentColor(context)),
            ).paddingSymmetric(
                vertical: NeumorphicTheme.isUsingDark(context) ? 8 : 0,
                horizontal: 20),
            // Icon(Icons.abc)
          ],
        ),
      ),
    );
  }
}
