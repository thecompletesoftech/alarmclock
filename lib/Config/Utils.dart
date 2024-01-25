import 'package:clockalarm/Config/Import.dart';

class Utils {
  BoxDecoration decoration({radius, isdark, cntx}) {
    double baseWidth = 390;
    double fem = MediaQuery.of(cntx).size.width / baseWidth;
    return BoxDecoration(
      color: NeumorphicTheme.baseColor(cntx),
      borderRadius: BorderRadius.circular(radius * fem),
      boxShadow: !isdark
          ? [
              BoxShadow(
                color: Color(0x60ffffff),
                offset: Offset(-10 * fem, -10 * fem),
                blurRadius: 10 * fem,
              ),
              BoxShadow(
                color: Color(0x0a000000),
                offset: Offset(10.0444440842 * fem, 10.0444440842 * fem),
                blurRadius: 10 * fem,
              ),
            ]
          : [
              BoxShadow(
                color: Color(0x51000000),
                offset: Offset(10.0444440842 * fem, 10.0444440842 * fem),
                blurRadius: 10 * fem,
              ),
              BoxShadow(
                color: Color(0x875c5c5c),
                offset: Offset(-2 * fem, -2 * fem),
                blurRadius: 6 * fem,
                spreadRadius: 1
              ),
            ],
    );
  }
}
