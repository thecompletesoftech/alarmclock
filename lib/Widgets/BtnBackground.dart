import '../Config/Import.dart';

class BtnBackground extends StatelessWidget {
  final child;
  final issmall;
  final borderRadius;
  final width;
  final height;
  const BtnBackground({
    super.key,
    this.child,
    this.issmall = false,
    this.borderRadius = 10.5,
    this.width = 0.9,
    this.height = 50,
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
            children: [
              SvgPicture.string(
                issmall ? smallbtnbackground : cardbackground,
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
