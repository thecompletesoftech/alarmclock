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
            showarrow: true,
            showlistbtn: true,
            showsubtitle: true,
            subtitle: timeuptext,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Intervalend(
              title: alarmeat,
              hour: "",
              minute: "00",
              second: "00",
              medium: "AM",
            ),
            SizedBox(height: 20),
            IntervalCard(
              title: reperatinterval,
              interval: 4,
            ),
            // checkbox(),
            // checkbox(),
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

  checkbox(title) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Row(
      children: [
        Text(
          title,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw50012,
              color: NeumorphicTheme.defaultTextColor(context)),
        ),
        Image.asset(
          "assets/checkbox.png",
          height: 20,
          width: 20,
        )
      ],
    );
  }
}
