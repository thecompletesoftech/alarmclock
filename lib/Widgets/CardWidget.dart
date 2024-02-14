import 'package:clockalarm/Config/Import.dart';

class CardWidget extends StatefulWidget {
  final title;
  final Function? ontap;
  final controller;
  final child;

  const CardWidget({
    super.key,
    this.title = '',
    this.ontap,
    this.controller,
    this.child,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: () {
        widget.ontap!();
      },
      child: CardBackground(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw40018,
                  color: NeumorphicTheme.accentColor(context)),
            ).paddingSymmetric(
                vertical: NeumorphicTheme.isUsingDark(context) ? 8 : 0,
                horizontal: 20),
            Container(
              child: widget.child,
            )
          ],
        ),
      ),
    );
  }
}
