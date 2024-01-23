import '../Config/Import.dart';

class CardBackground extends StatelessWidget {
  final child;
  final backgroundimage;
  const CardBackground({
    super.key,
    this.child,
    this.backgroundimage = null,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return NeumorphicTheme.isUsingDark(context)
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: Utils().decoration(
                cntx: context,
                isdark: NeumorphicTheme.isUsingDark(context),
                radius: 18.0 * fem),
            child: child,
          )
        : Stack(
            children: [
              SvgPicture.string(
                backgroundimage == null ? cardbackground : backgroundimage,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 20, top: 15),
                  width: MediaQuery.of(context).size.width,
                  child: child,
                ),
              )
            ],
          );
  }
}
