import 'dart:developer';

import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/ForgotPassword/ForgotPaasword.dart';
import 'package:clockalarm/View/Auth/Controller/AuthController.dart';
import 'package:clockalarm/Widgets/ButtonWidget.dart';
import 'package:flutter/gestures.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthController controller = Get.put(AuthController());
  var emailerror = false;
  var emailerrmsg = '';

  var passworderror = false;
  var passerrormsg = '';

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future CheckValidation() async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controller.emailController.text);
    if (controller.emailController.text.length < 1) {
      setState(() {
        emailerror = true;
        emailerrmsg = requiredtext + email;
      });
      return true;
    } else if (controller.emailController.text.length > 0) {
      setState(() {
        emailerror = false;
        emailerrmsg = '';
      });
    }

    if (emailValid == false) {
      setState(() {
        emailerror = true;
        emailerrmsg = requiredtext + emailerrormsg;
      });
      return true;
    } else if (emailValid == true) {
      setState(() {
        emailerror = false;
        emailerrmsg = '';
      });
    }

    if (controller.passwordController.text.length < 1) {
      setState(() {
        passworderror = true;
        passerrormsg = requiredtext + password;
      });
      return true;
    } else if (controller.passwordController.text.length > 0) {
      setState(() {
        passworderror = false;
        passerrormsg = '';
      });
      return false;
    }
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    Center(
                        child: NeumorphicTheme.isUsingDark(context)
                            ? Image.asset(
                                "assets/DarkMode.png",
                                height: 200,
                                width: 150,
                              )
                            : Image.asset(
                                "assets/LightMode.png",
                                height: 200,
                                width: 150,
                              )),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Text(
                            login,
                            textAlign: TextAlign.start,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw60022,
                                color: NeumorphicTheme.accentColor(context)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    TextBoxwidget(
                      iconorimage: true,
                      suffixshowicon: true,
                      child: Image.asset(NeumorphicTheme.isUsingDark(context)
                          ? "assets/Darksign.png"
                          : "assets/Lightsign.png"),
                      controller: controller.emailController,
                      hinttext: email,
                      accentcolor: NeumorphicTheme.accentColor(context),
                      basecolor: NeumorphicTheme.baseColor(context),
                      validator: (e) {
                        return null;
                      },
                      showerror: emailerror,
                      errormsg: emailerrmsg,
                    ),
                    SizedBox(height: 24),
                    TextBoxwidget(
                      obsecuretext: _obscureText,
                      suffixshowicon: true,
                      iconorimage: true,
                      child: (_obscureText
                          ? Image.asset(NeumorphicTheme.isUsingDark(context)
                              ? "assets/DarkEyes.png"
                              : "assets/LightEye.png")
                          : Image.asset(NeumorphicTheme.isUsingDark(context)
                              ? "assets/DarkHide.png"
                              : 'assets/LightHides.png')),
                      ontapsufixicon: () {
                        print("object==>>>>>>>>>");
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      controller: controller.passwordController,
                      hinttext: password,
                      accentcolor: NeumorphicTheme.accentColor(context),
                      basecolor: NeumorphicTheme.baseColor(context),
                      validator: (e) {
                        var regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(e!);
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
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              forgotpassword,
                              style: MyTextStyle.Dynamic(
                                  style: MyTextStyle.mw30016,
                                  color: NeumorphicTheme.accentColor(context)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 51),
                    Obx(
                      () => ButtonWidget(
                        height: 60.0,
                        width: 50,
                        // borderRadius: 25.0,
                        name: login,
                        loading: controller.loginloader.value,
                        onTap: () async {
                          if (controller.loginloader.value == false) {
                            await CheckValidation().then((value) async {
                              if (value == false) {
                                User? user = await controller
                                    .loginUsingEmailPassword(context: context);
                                print("user" + user.toString());
                                if (user != null) {
                                  nextscreenwithoutback(
                                      context, NewBottomNavigator());
                                }
                              }
                            });
                          }
                        },
                      ).paddingOnly(
                          left: NeumorphicTheme.isUsingDark(context) ? 6 : 0,
                          right: NeumorphicTheme.isUsingDark(context) ? 8 : 0),
                    ),
                    SizedBox(height: 93),
                    RichText(
                      text: TextSpan(
                          text: account,
                          style: MyTextStyle.Dynamic(
                              style: MyTextStyle.mw30016,
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
