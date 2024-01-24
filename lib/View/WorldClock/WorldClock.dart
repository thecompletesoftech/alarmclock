import 'package:clockalarm/Config/Import.dart';

class WorldClock extends StatefulWidget {
  const WorldClock({super.key});

  @override
  State<WorldClock> createState() => _WorldClockState();
}

var serachlist = [
  'Abu Dhabi, UAE',
  'Acapulco, Mexico',
  'Accra, Ghana',
  'Acton, USA',
  'Adak, USA',
  'Baghdad, Iraq',
  'Baku, Azerbaijan',
  'Baltimore, USA',
  'Bangalore, India',
  'Cairo, Egypt',
  'Calgary, Canada',
  'Canberra, Australia',
  'Dallas, USA',
  'Damascus, Syria',
  'El Paso, USA',
];
List<String> filteredCategories = [];
TextEditingController searchController = TextEditingController();

@override
class _WorldClockState extends State<WorldClock> {
  void initState() {
    super.initState();
    filteredCategories = serachlist;
    searchController.addListener(updateSearchResults);
  }

  void updateSearchResults() {
    setState(() {
      filteredCategories = serachlist
          .where((category) => category
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _deleteText() {
    setState(() {
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(
            list: [
              {"icon": "assets/add.png", "screenname": AddAlram()},
              {"icon": "assets/edit.png", "screenname": ""},
              {"icon": "assets/person.png", "screenname": Profile()},
            ],
            ontapnavigate: (value) {
              switch (value) {
                case 0:
                  _showNeumorphicBottomSheet(context);
                  break;
                case 1:
                  nextscreen(context, "");
                  break;
                case 2:
                  nextscreen(context, Profile());
                  break;
              }
            },
            titletext: worldclock,
            ontapornavigate: true,
            showarrow: false,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 250),
              items: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            NeumorphicTheme.isUsingDark(context)
                                ? Container(
                                    height: 230,
                                    width: 230,
                                    decoration: Utils().decoration(
                                        cntx: context,
                                        isdark: NeumorphicTheme.isUsingDark(
                                            context),
                                        radius: 250.0 * fem),
                                  )
                                : SvgPicture.string(clockbackground),
                            Container(
                              height: 18,
                              width: 2,
                              color: NeumorphicTheme.defaultTextColor(context),
                            ).paddingOnly(top: 8),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              height: 230,
                              width: 230,
                              color: Colors.transparent,
                            ),
                            Container(
                              height: 2,
                              width: 18,
                              color: NeumorphicTheme.defaultTextColor(context),
                            ).paddingOnly(left: 8),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 230,
                              width: 230,
                              color: Colors.transparent,
                            ),
                            Container(
                              height: 18,
                              width: 2,
                              color: NeumorphicTheme.defaultTextColor(context),
                            ).paddingOnly(bottom: 8),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Container(
                              height: 230,
                              width: 230,
                              color: Colors.transparent,
                            ),
                            Container(
                              height: 2,
                              width: 18,
                              color: NeumorphicTheme.defaultTextColor(context),
                            ).paddingOnly(right: 8),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      child: AnalogClock(
                        decoration: Utils().decoration(
                            cntx: context,
                            isdark: NeumorphicTheme.isUsingDark(context),
                            radius: 150 * fem),
                        width: 150.0,
                        isLive: true,
                        hourHandColor:
                            NeumorphicTheme.defaultTextColor(context),
                        minuteHandColor: NeumorphicTheme.accentColor(context),
                        showSecondHand: false,
                        numberColor: Colors.black87,
                        showNumbers: false,
                        showAllNumbers: false,
                        textScaleFactor: 1.4,
                        showTicks: false,
                        showDigitalClock: false,
                        datetime: DateTime(2019, 1, 1, 9, 12, 15),
                      ),
                    ).paddingOnly(
                        right: NeumorphicTheme.isUsingDark(context) ? 0 : 5,
                        bottom: NeumorphicTheme.isUsingDark(context) ? 0 : 3),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            DotsIndicator(
              dotsCount: 4,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CardBackground(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Bangalore",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40020,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "India",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw70014,
                            color: mycolor().greenlightcolor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "01:00",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40020,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "pm",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw70014,
                            color: mycolor().greenlightcolor),
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _showNeumorphicBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext builderContext) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                selectcity,
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw60018,
                    color: NeumorphicTheme.accentColor(context)),
              ),
              SizedBox(
                height: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextBoxwidget(
                        controller: searchController,
                        hinttext: 'Search',
                        validator: (p0) {},
                        radius: 16.0,
                        neumormargintop: 0.0,
                        neumormarginleft: 0.0,
                        neumormarginbottom: 0.0,
                        textboxvertival: 0.0,
                        ontap: () {},
                        suffixshowicon: true,
                        suffixicon: Icons.search),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // _deleteText();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: Text(
                          cancel,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw40016,
                              color: NeumorphicTheme.defaultTextColor(context)),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCategories.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                filteredCategories[index],
                                style: MyTextStyle.Dynamic(
                                    style: MyTextStyle.mw40018,
                                    color:
                                        NeumorphicTheme.accentColor(context)),
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
