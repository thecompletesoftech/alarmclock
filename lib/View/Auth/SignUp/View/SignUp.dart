import 'dart:developer';

import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/Widgets/ButtonWidget.dart';
import 'package:flutter/gestures.dart';
import '../../Controller/AuthController.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthController controller = Get.put(AuthController());
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var nameerror = false;
  var nameerrmsg = '';
  var emailerror = false;
  var emailerrmsg = '';
  var passworderror = false;
  var passerrormsg = '';
  var Cnfpassworderror = false;
  var Cnfpasserrormsg = '';

  @override
  void initState() {
    controller.clearsignupdata();
    super.initState();
  }

  Future CheckValidation() async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controller.signUpemail.text);
    // Name
    if (controller.nameController.text.length < 1) {
      setState(() {
        nameerror = true;
        nameerrmsg = requiredtext + fullname;
      });
      return true;
    } else if (controller.nameController.text.length > 0) {
      setState(() {
        nameerror = false;
        nameerrmsg = '';
      });
    }
    // Email
    if (controller.signUpemail.text.length < 1) {
      setState(() {
        emailerror = true;
        emailerrmsg = requiredtext + email;
      });
      return true;
    } else if (controller.signUpemail.text.length > 0) {
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
    // Password
    if (controller.signuppassword.text.length < 1) {
      setState(() {
        passworderror = true;
        passerrormsg = requiredtext + password;
      });
      return true;
    } else if (controller.signuppassword.text.length > 0) {
      setState(() {
        passworderror = false;
        passerrormsg = '';
      });
    }
    // Confirm passowrd
    if (controller.signupconfirmpass.text.length < 1) {
      setState(() {
        Cnfpassworderror = true;
        Cnfpasserrormsg = requiredtext + confirmpassword;
      });
      return true;
    } else if (controller.signupconfirmpass.text.length > 0) {
      setState(() {
        Cnfpassworderror = false;
        Cnfpasserrormsg = '';
      });
    }
    if (controller.signuppassword.text != controller.signupconfirmpass.text) {
      setState(() {
        Cnfpassworderror = true;
        Cnfpasserrormsg = sameconfirmpassword;
      });
      return true;
    } else if (controller.signuppassword.text ==
        controller.signupconfirmpass.text) {
      setState(() {
        Cnfpassworderror = false;
        Cnfpasserrormsg = '';
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Center(child: Image.asset("assets/TivalLogo.png")),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        register,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw70024,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                TextBoxwidget(
                  controller: controller.nameController,
                  hinttext: fullname,
                  accentcolor: NeumorphicTheme.accentColor(context),
                  basecolor: NeumorphicTheme.baseColor(context),
                  validator: (Value) {
                    if (Value!.isEmpty) {
                      return "Please enter name";
                    }
                  },
                  showerror: nameerror,
                  errormsg: nameerrmsg,
                ),
                SizedBox(height: 24),
                TextBoxwidget(
                  controller: controller.signUpemail,
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
                  controller: controller.signuppassword,
                  hinttext: password,
                  accentcolor: NeumorphicTheme.accentColor(context),
                  basecolor: NeumorphicTheme.baseColor(context),
                  validator: (e) {
                    return null;
                  },
                  showerror: passworderror,
                  errormsg: passerrormsg,
                ),
                SizedBox(height: 24),
                TextBoxwidget(
                  controller: controller.signupconfirmpass,
                  hinttext: confirmpassword,
                  accentcolor: NeumorphicTheme.accentColor(context),
                  basecolor: NeumorphicTheme.baseColor(context),
                  validator: (e) {
                    return null;
                  },
                  showerror: Cnfpassworderror,
                  errormsg: Cnfpasserrormsg,
                ),
                SizedBox(height: 30),
                Obx(
                  () => Center(
                    child: ButtonWidget(
                      height: 60.0,
                      width: 0.87,
                      name: register,
                      loading: controller.signuploader.value,
                      onTap: () {
                        if (controller.signuploader.value == false) {
                          CheckValidation().then((value) => {
                                if (value == false) {controller.signUp(context)}
                              });
                        }
                      },
                    ).paddingOnly(
                        left: NeumorphicTheme.isUsingDark(context) ? 6 : 0,
                        right: NeumorphicTheme.isUsingDark(context) ? 8 : 0),
                  ),
                ),
                SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                      text: alreadyaccount,
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw50016,
                          color: NeumorphicTheme.accentColor(context)),
                      children: [
                        TextSpan(
                            text: login,
                            style: MyTextStyle.Dynamic(
                                style: MyTextStyle.mw60016,
                                color: NeumorphicTheme.accentColor(context)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => nextscreen(context, SignIn()))
                      ]),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
