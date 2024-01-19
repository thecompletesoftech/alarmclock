import '../Config/Import.dart';

class CustomeAppbar extends StatelessWidget {
  final titletext;
  final List list;
  const CustomeAppbar({super.key, this.titletext, required this.list});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titletext,
            style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw60030,
                color: NeumorphicTheme.accentColor(context)),
          ),
          Container(
              height: 50,
              child: ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (() {
                        print("hii");
                        nextscreen(context, list[index]['screenname']);
                      }),
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: Utils().decoration(
                              cntx: context,
                              isdark: NeumorphicTheme.isUsingDark(context),
                              radius: 32.5 * fem),
                          child: Icon(
                            list[index]['icon'],
                            color: NeumorphicTheme.accentColor(context),
                          )).paddingOnly(left: 10),
                    );
                  }))
        ],
      ),
    ).paddingSymmetric(horizontal: 20, vertical: 40);
  }
}
