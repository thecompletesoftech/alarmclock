import 'package:clockalarm/Config/Import.dart';

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
      filteredCategories = controller.searchlist
          .where((category) => category['name']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
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
    return Scaffold(
      body: Column(
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
              itemCount: filteredCategories.length > 0
                  ? filteredCategories.length
                  : controller.searchlist.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var items = filteredCategories.length > 0
                    ? filteredCategories[index]
                    : controller.searchlist[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.setup(items['timezone']);
                      },
                      child: Row(
                        children: [
                          Text(
                            items['name'],
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40018,
                                color: NeumorphicTheme.accentColor(context)),
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
    );
  }
}
