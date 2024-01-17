import 'package:clockalarm/Config/Import.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    Center(child: Image.asset("assets/TivalLogo.png")),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          "Login",
                          textAlign: TextAlign.start,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw70024,
                              color: NeumorphicTheme.accentColor(context)),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    TextBoxwidget(
                        hinttext: 'Email',
                        hintstyle: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: NeumorphicTheme.accentColor(context)),
                        validator: (e) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(e!);

                          if (e.isEmpty) {
                            return 'emailrequired';
                          }
                          if (emailValid == false) {
                            return 'emailvalid';
                          }
                        }),
                    SizedBox(height: 24),
                    TextBoxwidget(
                      hinttext: 'Password',
                      hintstyle: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40018,
                          color: NeumorphicTheme.accentColor(context)),
                      validator: (e) {},
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw40016,
                              color: NeumorphicTheme.accentColor(context)),
                        ),
                      ],
                    ),
                    SizedBox(height: 51),
                    SizedBox(height: 93),
                    RichText(
                      text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw50016,
                              color: NeumorphicTheme.accentColor(context)),
                          children: [
                            TextSpan(
                              text: 'Register',
                              style: MyTextStyle.Dynamic(
                                  style: MyTextStyle.mw60016,
                                  color: NeumorphicTheme.accentColor(context)),
                              // recognizer: TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
                            )
                          ]),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
