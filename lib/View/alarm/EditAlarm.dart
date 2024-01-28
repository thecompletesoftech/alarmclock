import '../../Config/Import.dart';

class EditAlarm extends StatefulWidget {
  const EditAlarm({super.key});

  @override
  State<EditAlarm> createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          comingSoon,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw50018,
              color: NeumorphicTheme.defaultTextColor(context)),
        ),
      ),
    );
  }
}
