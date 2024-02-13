import 'package:clockalarm/View/Auth/Controller/AuthController.dart';
import 'package:flutter/gestures.dart';
import "../../../Config/Import.dart";
import 'package:clockalarm/Widgets/ButtonWidget.dart';

class ForgotPaasword extends StatefulWidget {
  const ForgotPaasword({super.key});

  @override
  State<ForgotPaasword> createState() => _ForgotPaaswordState();
}

class _ForgotPaaswordState extends State<ForgotPaasword> {
  AuthController controller = Get.put(AuthController());
  var emailerror = false;
  var emailerrmsg = '';
  final resetpassemail = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Future CheckValidation() async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controller.resetpassemail.text);
    if (controller.resetpassemail.text.length < 1) {
      setState(() {
        emailerror = true;
        emailerrmsg = requiredtext + email;
      });
      return true;
    } else if (controller.resetpassemail.text.length > 0) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                      suffixshowicon: true,
                      iconorimage: true,
                      child: NeumorphicTheme.isUsingDark(context)
                          ? Image.asset('assets/Darkalternate.png')
                          : Image.asset('assets/Lightalternate.png'),
                      controller: controller.resetpassemail,
                      hinttext: email,
                      accentcolor: NeumorphicTheme.accentColor(context),
                      basecolor: NeumorphicTheme.baseColor(context),
                      validator: (e) {
                        return null;
                      },
                      showerror: emailerror,
                      errormsg: emailerrmsg,
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    Obx(
                      () => Center(
                        child: ButtonWidget(
                          height: 60.0,
                          name: resetpass,
                          loading: controller.forgotpassloader.value,
                          onTap: () async {
                            if (controller.forgotpassloader.value == false) {
                              await CheckValidation().then((value) async {
                                if (value == false) {
                                  // User? user =
                                  await controller.forgotpassword(context);

                                  // print("user" + user.toString());
                                  // if (user != null) {
                                  //   nextscreenwithoutback(
                                  //       context, NewBottomNavigator());
                                  // }
                                }
                              });
                              controller.forgotpassword(context);
                            }
                            // log("object =>>>>");

                            // if (controller.forgotpassloader.value == false) {}
                            // final isvalidForm = _formkey.currentState!.validate();
                            // if (isvalidForm) {
                            //   setState(() {
                            //     emailerror = false;
                            //   });
                            // }
                            // nextscreen(context, ResetPassword());
                          },
                          // child: controller.forgotpassloader.value
                          //     ? Center(
                          //         child: CircularProgressIndicator(
                          //           color:
                          //               NeumorphicTheme.defaultTextColor(context),
                          //         ),
                          //       )
                          //     : Text(
                          //         'Save',
                          //         style: MyTextStyle.Dynamic(
                          //             style: MyTextStyle.mw50018,
                          //             color: NeumorphicTheme.baseColor(context)),
                          //       ),
                        ).paddingOnly(
                            left: NeumorphicTheme.isUsingDark(context) ? 6 : 0,
                            right:
                                NeumorphicTheme.isUsingDark(context) ? 8 : 0),
                      ),
                    ),
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
