import 'package:clockalarm/View/Auth/ResetPassword/ResetPassword.dart';
import 'package:flutter/gestures.dart';

import "../../../Config/Import.dart";
import 'package:clockalarm/Widgets/ButtonWidget.dart';

class ForgotPaasword extends StatefulWidget {
  const ForgotPaasword({super.key});

  @override
  State<ForgotPaasword> createState() => _ForgotPaaswordState();
}

class _ForgotPaaswordState extends State<ForgotPaasword> {
  var emailerror = false;
  var emailerrmsg = '';
  final emailController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(
                      height: 51,
                    ),
                    Row(
                      children: [
                        Text(
                          forgotpassword,
                          textAlign: TextAlign.start,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw70020,
                              color: NeumorphicTheme.accentColor(context)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Text(
                      longtext,
                      textAlign: TextAlign.start,
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw40014,
                          color: mycolor().greenlightcolor),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    TextBoxwidget(
                      controller: emailController,
                      hinttext: email,
                      accentcolor: NeumorphicTheme.accentColor(context),
                      basecolor: NeumorphicTheme.baseColor(context),
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
                    SizedBox(
                      height: 44,
                    ),
                    ButtonWidget(
                      height: 60.0,
                      name: resetpass,
                      onTap: () {
                        // final isvalidForm = _formkey.currentState!.validate();
                        // if (isvalidForm) {
                        //   setState(() {
                        //     emailerror = false;
                        //   });
                        // }
                        nextscreen(context, ResetPassword());
                      },
                    ).paddingOnly(
                        left: NeumorphicTheme.isUsingDark(context) ? 6 : 0,
                        right: NeumorphicTheme.isUsingDark(context) ? 8 : 0),
                    SizedBox(
                      height: 119,
                    ),
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
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
