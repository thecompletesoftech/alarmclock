import '../Config/Import.dart';

class BtnBackground extends StatelessWidget {
  final child;
  final issmall;
  final borderRadius;
  final width;
  final height;
  final showcard2;
  const BtnBackground({
    super.key,
    this.child,
    this.issmall = false,
    this.borderRadius = 10.5,
    this.width = 0.9,
    this.height = 50,
    this.showcard2 = false,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    var size = MediaQuery.of(context).size;
    return NeumorphicTheme.isUsingDark(context)
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: size.width * width,
            height: height,
            decoration: Utils().decoration(
                cntx: context,
                isdark: NeumorphicTheme.isUsingDark(context),
                radius: borderRadius * fem),
            child: child,
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.string(
                width: size.width,
                issmall
                    ? smallbtnbackground
                    : showcard2
                        ? cardbackground2
                        : cardbackground,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 20,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: child,
                ),
              )
            ],
          ).paddingOnly(left: 8);
  }
}
