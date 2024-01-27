import '../Config/Import.dart';

class CustomeAppbar extends StatelessWidget {
  final titletext;
  final List list;
  final showdivider;
  final showlistbtn;
  final subtitle;
  final showsubtitle;
  final showbtn;
  final showarrow;
  final ontapornavigate;
  final Function? ontapnavigate;
  const CustomeAppbar(
      {super.key,
      this.titletext,
      required this.list,
      this.showdivider = false,
      this.showlistbtn = true,
      this.subtitle,
      this.showsubtitle = false,
      this.showbtn = false,
      this.showarrow = false,
      this.ontapornavigate = false,
      this.ontapnavigate});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showarrow)
                    GestureDetector(
                      onTap: (() {
                        backscreen(context);
                      }),
                      child: Icon(Icons.arrow_back_outlined,
                              color: NeumorphicTheme.defaultTextColor(context))
                          .paddingOnly(bottom: 10, right: 20),
                    ),
                  Text(
                    titletext,
                    style: MyTextStyle.Dynamic(
                        style: MyTextStyle.mw60030,
                        color: NeumorphicTheme.accentColor(context)),
                  ),
                  if (showsubtitle)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        subtitle.toString(),
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw50018,
                            color: NeumorphicTheme.defaultTextColor(context)),
                      ),
                    ),
                ],
              ),
              if (showlistbtn)
                Container(
                    height: 40,
                    child: ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (() {
                              if (ontapornavigate)
                                ontapnavigate!(index);
                              else
                                nextscreen(context, list[index]['screenname']);
                            }),
                            child: Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: Utils().decoration(
                                    cntx: context,
                                    isdark:
                                        NeumorphicTheme.isUsingDark(context),
                                    radius: 32.5 * fem),
                                child: Image.asset(
                                  list[index]['icon'],
                                  color: NeumorphicTheme.accentColor(context),
                                  height: 20,
                                  width: 20,
                                )).paddingOnly(left: 10),
                          );
                        })),
              if (showbtn)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: Utils().decoration(
                      cntx: context,
                      isdark: NeumorphicTheme.isUsingDark(context),
                      radius: 15.5 * fem),
                  width: 120,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sound,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw50016,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: NeumorphicTheme.accentColor(context),
                        size: 15.0,
                      )
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          if (showdivider)
            Divider(
              color: mycolor().lighttxtcolor,
            ),
        ],
      ),
    ).paddingOnly(left: 20, right: 20, top: 40);
  }
}
