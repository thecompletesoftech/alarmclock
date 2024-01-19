import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';

class AlramTimesup extends StatefulWidget {
  const AlramTimesup({super.key});

  @override
  State<AlramTimesup> createState() => _AlramTimesupState();
}

class _AlramTimesupState extends State<AlramTimesup> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/list.png", "screenname": null},
              {"icon": "assets/add.png", "screenname": null},
            ],
            titletext: alarm,
            showdivider: true,
            showlistbtn: true,
            showsubtitle: true,
            subtitle: timeuptext,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            checkbox(),
            checkbox(),
            ButtonWidget(
              name: proceed,
              txtstyle: MyTextStyle.mw40020,
              borderRadius: 15.0,
              onTap: () {},
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: Utils().decoration(
                    cntx: context,
                    isdark: NeumorphicTheme.isUsingDark(context),
                    radius: 15.5 * fem),
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.center,
                child: Container()),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  checkbox() {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Row(
      children: [
        Text(
          "next",
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw50012,
              color: NeumorphicTheme.defaultTextColor(context)),
        ),
        Container(
          // autogroupuxtsko6 (QgJJKFcucEceuwEnwRUXtS)
          width: 40,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xff333333),
            borderRadius: BorderRadius.circular(10 * fem),
          ),
          child: Center(
            child: Text(
              "4",
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw50012,
                  color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
        ),
      ],
    );
  }
}
