import '../../Config/Import.dart';

class AlarmHome extends StatefulWidget {
  const AlarmHome({super.key});

  @override
  State<AlarmHome> createState() => _AlarmHomeState();
}

class _AlarmHomeState extends State<AlarmHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomeAppbar(list: [
            {"icon": Icons.abc_outlined, "screenname": null},
            {"icon": Icons.add, "screenname": null},
            {"icon": Icons.add, "screenname": null},
          ], titletext: alarm)),
      body: Column(
        children: [],
      ),
    );
  }
}
