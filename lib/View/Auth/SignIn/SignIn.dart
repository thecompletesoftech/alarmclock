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
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                Center(child: Image.asset("assets/TivalLogo.png")),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw70024,
                          color: NeumorphicTheme.accentColor(context)),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                TextBoxwidget(
                  hinttext: 'Email',
                  validator: (e) {},
                ),
                SizedBox(height: 24),
                TextBoxwidget(
                  hinttext: 'Password',
                  validator: (e) {},
                ),
                SizedBox(height: 13),
                Text("Forgot Password?")
              ],
            ),
          )
        ],
      ),
    );
  }
}
