import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/Widgets/ButtonWidget.dart';
import 'package:flutter/gestures.dart';

import '../../../BottomNavigation/BottomNavigation.dart';
import '../../SignIn/Controller/AuthController.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    var emailerror = false;
    var emailerrmsg = '';

    var passworderror = false;
    var passerrormsg = '';
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
                  validator: (Value) {
                    if (Value!.isEmpty) {
                      return "Please enter name";
                    }
                  },
                ),
                SizedBox(height: 24),
                TextBoxwidget(
                  controller: controller.signUpemail,
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
                  controller: controller.signuppassword,
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
                SizedBox(height: 24),
                TextBoxwidget(
                  controller: controller.signupconfirmpass,
                  hinttext: confirmpassword,
                  validator: (e) {},
                ),
                SizedBox(height: 30),
                Center(
                  child: ButtonWidget(
                    height: 60.0,
                    width: 0.87,
                    name: register,
                    onTap: () {
                      final isvalidForm = _formkey.currentState!.validate();
                      if (isvalidForm) {
                        setState(() {
                          emailerror = false;
                          passworderror = false;
                          // controller.signUp();
                          // nextscreen(context, NewBottomNavigator());
                        });
                      }
                    },
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
