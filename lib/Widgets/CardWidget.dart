import 'package:clockalarm/Config/Import.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            shadowDarkColor: mycolor().darkshadow,
            depth: 2.0,
            boxShape: buttonradius(r: 20.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 18),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 60,
            alignment: Alignment.center,
            child: Text(
              'Neumorphic Card',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
