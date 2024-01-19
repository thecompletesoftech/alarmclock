import 'package:clockalarm/Widgets/Textwidget.dart';

import '../Config/Import.dart';

class ButtonWidget extends StatefulWidget {
  final String name;
  final Function? onTap;
  final width;
  final double height;
  final style;
  final colorbtn;
  final bool active;
  final double borderRadius;
  final double elevation;
  final showarrow;
  final bordercolor;
  final txtcolor;
  final showon;

  final bool loading;

  ButtonWidget(
      {Key? key,
      required this.name,
      this.onTap,
      this.width = 0.9,
      this.style,
      this.colorbtn = Colors.transparent,
      this.active = false,
      this.borderRadius = 10,
      this.height = 50,
      this.elevation = 0,
      this.bordercolor,
      this.showon = true,
      this.loading = false,
      this.txtcolor,
      this.showarrow = false})
      : super(key: key);
  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: Utils().decoration(
          cntx: context,
          isdark: NeumorphicTheme.isUsingDark(context),
          radius: 10.5 * fem),
      width: size.width * widget.width,
      height: widget.height,
      child: InkWell(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
          child: widget.loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: NeumorphicTheme.accentColor(context),
                ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Textwidget().text(
                          widget.name,
                          MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40024,
                            color: widget.txtcolor ??
                                NeumorphicTheme.accentColor(context),
                          )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
