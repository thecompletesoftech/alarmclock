import '../../Config/Import.dart';

class Repeat extends StatefulWidget {
  const Repeat({super.key});

  @override
  State<Repeat> createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {
  var alramlist = [
    {"title": "Sunday"},
    {"title": "Monday"},
    {"title": "Tuesday"},
    {"title": "Wednesday"},
    {"title": "Thursday"},
    {"title": "Friday"},
    {"title": "Saturday"}
  ];

  String time = "-";
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Stack(
              children: [
                GestureDetector(
                  onTap: (() {
                    backscreen(context);
                  }),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: mycolor().greenlightcolor,
                        size: 15.0,
                        fill: 0.5,
                      ),
                      SizedBox(width: 5),
                      Text(back,
                          style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40014,
                            color: NeumorphicTheme.defaultTextColor(context),
                          )),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 20, vertical: 5),
                Center(
                  child: Text(
                    repeat,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw60018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                ).paddingSymmetric(horizontal: 20),
              ],
            ),
            SizedBox(height: 40),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: alramlist.length,
              itemBuilder: (context, index) {
                return AlramCard(
                  showmedium: false,
                  showswitchorsubtile: false,
                  showarrowicon: false,
                  time: alramlist[index]['title'].toString(),
                  subtitle: "",
                  ontapcard: () {
                    nextscreen(context, Repeat());
                  },
                  onchange: (value) {
                    setState(() {
                      isSwitched = !isSwitched;
                    });
                  },
                  swicthvalue: isSwitched,
                ).paddingOnly(bottom: 15, top: 10);
              },
            )
          ],
        ),
      ),
    );
  }
}