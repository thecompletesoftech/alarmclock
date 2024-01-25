import '../../Config/Import.dart';
import '../../Widgets/ButtonWidget.dart';

class Sound extends StatefulWidget {
  const Sound({super.key});

  @override
  State<Sound> createState() => _SoundState();
}

class _SoundState extends State<Sound> {
  var soundlist = [
    {"title": "Immigrant Song"},
    {"title": "Super Mario"},
    {"title": "Breaking"},
    {"title": "Canopy"},
    {"title": "Thursday"},
    {"title": "Chalet"},
    {"title": "Quad"},
    {"title": "Steps"},
    {"title": "Chirp"},
    {"title": "Valley"}
  ];

  String time = "-";
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
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
                ).paddingSymmetric(horizontal: 5, vertical: 5),
                Center(
                  child: Text(
                    "Sound",
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw60018,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            Container(
              decoration: Utils().decoration(
                  cntx: context,
                  isdark: NeumorphicTheme.isUsingDark(context),
                  radius: 18.0 * fem),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: soundlist.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          soundlist[index]['title'].toString(),
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw40020,
                              color: NeumorphicTheme.accentColor(context)),
                        ),
                        if (index != soundlist.length - 1) Divider()
                      ],
                    ),
                  ).paddingOnly(top: 5);
                },
              ).paddingOnly(top: 10, bottom: 5),
            ),
            SizedBox(height: 58),
            ButtonWidget(
              width: 68.0,
              name: none,
              txtstyle: MyTextStyle.mw40020,
              borderRadius: 20.0,
              onTap: () {},
            ),
            SizedBox(height: 20),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
