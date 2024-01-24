import '../Config/Import.dart';

class LargeCardBackground extends StatelessWidget {
  final child;
  final backgroundimage;
  final height;
  const LargeCardBackground({
    super.key,
    this.child,
    this.backgroundimage = null, this.height = 47.0,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    var size = MediaQuery.of(context).size;
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
          alignment: Alignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/largecard.png',
                  width: size.width,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: size.width,
                  child: child,
                ),
              )
            ],
          ).paddingOnly(left: 8);
  }
}
