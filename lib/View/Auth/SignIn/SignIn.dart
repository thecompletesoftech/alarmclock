import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/ForgotPassword/ForgotPaasword.dart';
import 'package:clockalarm/View/Auth/Profile/Profile.dart';
import 'package:clockalarm/View/Auth/SignUp/View/SignUp.dart';
import 'package:clockalarm/View/WorldClock/WorldClock.dart';
import 'package:clockalarm/Widgets/ButtonWidget.dart';
import 'package:flutter/gestures.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailerror = false;
  var emailerrmsg = '';

  var passworderror = false;
  var passerrormsg = '';

  final emailController = TextEditingController();
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
                          login,
                          textAlign: TextAlign.start,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw70024,
                              color: NeumorphicTheme.accentColor(context)),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    TextBoxwidget(
                      controller: emailController,
                      hinttext: email,
                      validator: (e) {
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(e!);

                        if (e.isEmpty) {
                          setState(() {
                            emailerror = true;
                            emailerrmsg = requiredtext + email;
                          });
                          return emailerrmsg;
                        }
                        if (emailValid == false) {
                          setState(() {
                            emailerror = true;
                            emailerrmsg = requiredtext + emailerrormsg;
                          });
                          return emailerrmsg;
                        }
                        return null;
                      },
                      showerror: emailerror,
                      errormsg: emailerrmsg,
                    ),
                    SizedBox(height: 24),
                    TextBoxwidget(
                      hinttext: password,
                      validator: (e) {
                        var regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(e!);
                        if (e.isEmpty) {
                          setState(() {
                            passworderror = true;
                            passerrormsg = requiredtext + password;
                          });
                          return passerrormsg;
                        }
                        if (regex == false) {
                          setState(() {
                            passworderror = true;
                            passerrormsg = requiredtext + passworderrormsg;
                          });
                          return passerrormsg;
                        }
                        return null;
                      },
                      showerror: passworderror,
                      errormsg: passerrormsg,
                    ),
                    SizedBox(height: 13),
                    GestureDetector(
                      onTap: () {
                        nextscreen(context, ForgotPaasword());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            forgotpassword,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw40016,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 51),
                    ButtonWidget(
                      width: 0.76,
                      name: login,
                      onTap: () {
                        final isvalidForm = _formkey.currentState!.validate();
                        if (isvalidForm) {
                          print("error ==>");
                          setState(() {
                            emailerror = false;
                            passworderror = false;
                          });
                          nextscreen(context, Profile());
                        }
                      },
                    ),
                    SizedBox(height: 93),
                    RichText(
                      text: TextSpan(
                          text: account,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw50016,
                              color: NeumorphicTheme.accentColor(context)),
                          children: [
                            TextSpan(
                                text: register,
                                style: MyTextStyle.Dynamic(
                                    style: MyTextStyle.mw60016,
                                    color:
                                        NeumorphicTheme.accentColor(context)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => nextscreen(context, SignUp()))
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
