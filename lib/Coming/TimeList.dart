import '../Config/Import.dart';

class TimeList extends StatefulWidget {
  const TimeList({super.key});

  @override
  State<TimeList> createState() => _TimeListState();
}

class _TimeListState extends State<TimeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": null},
              {"icon": "assets/person.png", "screenname": null},
            ],
            titletext: '',
            showdivider: false,
            showlistbtn: false,
            showarrow: true,
            showsubtitle: true,
            subtitle: '',
          )),
      body: Center(
        child: Text(
          "Coming Soon",
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw40018,
              color: NeumorphicTheme.accentColor(context)),
        ),
      ),
    );
  }
}
