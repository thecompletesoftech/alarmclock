import 'package:clockalarm/Config/Import.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: TextBoxwidget(
              validator: (e) {},
            ),
          )
        ],
      ),
    );
  }
}
