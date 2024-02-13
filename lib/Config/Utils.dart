import 'package:clockalarm/Config/Import.dart';

class Utils {
  BoxDecoration decoration(
      {radius,
      isdark,
      cntx,
      shadow = true,
      shadowwithcolor = false,
      backgroundcolor = null}) {
    double baseWidth = 390;
    double fem = MediaQuery.of(cntx).size.width / baseWidth;
    return BoxDecoration(
      color: backgroundcolor != null
          ? backgroundcolor
          : !shadowwithcolor
              ? NeumorphicTheme.baseColor(cntx)
              : mycolor().shadowcolordark,
      borderRadius: BorderRadius.circular(radius),
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
          : shadow
              ? [
                  BoxShadow(
                      color: Color(0x51000000),
                      offset: Offset(10.0444440842 * fem, 10.0444440842 * fem),
                      blurRadius: 10 * fem),
                  BoxShadow(
                    color: Color(0x875c5c5c),
                    offset: Offset(-2 * fem, -2 * fem),
                    blurRadius: 12,
                  ),
                ]
              : [],
    );
  }
}
