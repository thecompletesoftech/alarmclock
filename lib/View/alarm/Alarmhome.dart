import '../../Config/Import.dart';

class AlarmHome extends StatefulWidget {
  const AlarmHome({super.key});

  @override
  State<AlarmHome> createState() => _AlarmHomeState();
}

class _AlarmHomeState extends State<AlarmHome> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": "assets/add.png", "screenname": AddAlram()},
            {"icon": "assets/edit.png", "screenname": ""},
            {"icon": "assets/person.png", "screenname": Profile()},
          ], titletext: alarm)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            Clock(),
            SizedBox(height: 50),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return AlramCard(
                  showmedium: true,
                  medium: 'pm',
                  onchange: (value) {
                    setState(() {
                      isSwitched = !isSwitched;
                    });
                  },
                  swicthvalue: isSwitched,
                  time: '6:45',
                  showswitchorsubtile: true,
                  subtitle: "",
                ).paddingOnly(bottom: 10, top: 5);
              },
            )
          ],
        ),
      ),
    );
  }
}
