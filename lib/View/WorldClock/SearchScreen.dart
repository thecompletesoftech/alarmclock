import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/Json/Json.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  WorldController controller = Get.put(WorldController());
  TextEditingController searchController = TextEditingController();
  List filteredCategories = [];

  void updateSearchResults(keyword) {
    setState(() {
      filteredCategories = Searchlist.where((category) => category['name']
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // setState(() {
    //   filteredCategories.addAll(Searchlist);
    // });
    super.initState();
  }

  void _deleteText() {
    setState(() {
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.isUsingDark(context)
          ? mycolor().shadowcolordark
          : mycolor().lighterWhite,
      body: Obx(
        () => Stack(
          children: [
            Container(
              height: 100,
              color: NeumorphicTheme.baseColor(context),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                color: NeumorphicTheme.isUsingDark(context)
                    ? mycolor().shadowcolordark
                    : mycolor().lighterWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 20,
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
                                accentcolor:
                                    NeumorphicTheme.accentColor(context),
                                basecolor: NeumorphicTheme.baseColor(context),
                                onchange: (e) {
                                  updateSearchResults(e);
                                },
                                radius: 16.0,
                                neumormargintop: 0.0,
                                neumormarginleft: 0.0,
                                neumormarginbottom: 0.0,
                                textboxvertival: 0.0,
                                ontap: () {},
                                suffixshowicon: true,
                                suffixicon: Icons.search)
                            .paddingOnly(right: 10),
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
                                  color: mycolor().greenlightcolor),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCategories.length > 0
                          ? filteredCategories.length
                          : Searchlist.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var items = filteredCategories.length > 0
                            ? filteredCategories[index]
                            : Searchlist[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (controller.addclockloading.value == false) {
                                  controller.setup(items['timezone'], context);
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    items['timezone'],
                                    style: MyTextStyle.Dynamic(
                                        style: MyTextStyle.mw40018,
                                        color: NeumorphicTheme.accentColor(
                                            context)),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 10),
            ),
            if (controller.addclockloading.value)
              Center(
                child: CircularProgressIndicator(
                  color: NeumorphicTheme.accentColor(context),
                ),
              )
          ],
        ),
      ),
    );
  }
}
