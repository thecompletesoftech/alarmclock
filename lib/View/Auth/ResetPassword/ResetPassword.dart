import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/Controller/AuthController.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthController controller = Get.put(AuthController());
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var oldpasserror = false;
  var oldpassmsg = '';
  var currentpasserror = false;
  var currentpassmsg = '';
  var confirmpasserror = false;
  var confirmpassmsg = '';

  @override
  void initState() {
    // controller.clearChangepassdata();
    controller.passwordloading.value = false;
    super.initState();
  }

  Future CheckValidation() async {
    if (controller.oldpass.text.length < 1) {
      setState(() {
        oldpasserror = true;
        oldpassmsg = requiredtext + password;
      });
      return true;
    } else if (controller.oldpass.text.length > 0) {
      setState(() {
        oldpasserror = false;
        oldpassmsg = '';
      });
    }

    if (controller.currentpass.text.length < 1) {
      setState(() {
        currentpasserror = true;
        currentpassmsg = requiredtext + password;
      });
      return true;
    } else if (controller.currentpass.text.length > 0) {
      setState(() {
        currentpasserror = false;
        currentpassmsg = '';
      });
    }

    if (controller.confirmpass.text.length < 1) {
      setState(() {
        confirmpasserror = true;
        confirmpassmsg = requiredtext + confirmpassword;
      });
      return true;
    } else if (controller.confirmpass.text.length > 0) {
      setState(() {
        confirmpasserror = false;
        confirmpassmsg = '';
      });
    }

    if (controller.currentpass.text != controller.confirmpass.text) {
      setState(() {
        confirmpasserror = true;
        confirmpassmsg = sameconfirmpassword;
      });
      return true;
    } else if (controller.currentpass.text == controller.confirmpass.text) {
      setState(() {
        confirmpasserror = false;
        confirmpassmsg = '';
      });
      return false;
    }
  }

  bool currentobscureText = true;
  bool newobscureText = true;
  bool confirmobsureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                backscreen(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: NeumorphicTheme.defaultTextColor(context),
              ),
            ),
            Text(
              resetpass,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw60024,
                  color: NeumorphicTheme.accentColor(context)),
            ),
            Container(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        'Current Password',
                        textAlign: TextAlign.start,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40016,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextBoxwidget(
                  obsecuretext: currentobscureText,
                  suffixshowicon: true,
                  iconorimage: true,
                  child: (currentobscureText
                      ? Image.asset(NeumorphicTheme.isUsingDark(context)
                          ? "assets/DarkEyes.png"
                          : "assets/LightEye.png")
                      : Image.asset(NeumorphicTheme.isUsingDark(context)
                          ? "assets/DarkHide.png"
                          : 'assets/LightHides.png')),
                  ontapsufixicon: () {
                    print("object==>>>>>>>>>");
                    setState(() {
                      currentobscureText = !currentobscureText;
                    });
                  },
                  controller: controller.oldpass,
                  accentcolor: NeumorphicTheme.accentColor(context),
                  basecolor: NeumorphicTheme.baseColor(context),
                  hinttext: '******************',
                  validator: (e) {
                    return null;
                  },
                  showerror: oldpasserror,
                  errormsg: oldpassmsg,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        'New Password',
                        textAlign: TextAlign.start,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40016,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextBoxwidget(
                  obsecuretext: newobscureText,
                  suffixshowicon: true,
                  iconorimage: true,
                  child: (newobscureText
                      ? Image.asset(NeumorphicTheme.isUsingDark(context)
                          ? "assets/DarkEyes.png"
                          : "assets/LightEye.png")
                      : Image.asset(NeumorphicTheme.isUsingDark(context)
                          ? "assets/DarkHide.png"
                          : 'assets/LightHides.png')),
                  ontapsufixicon: () {
                    print("object==>>>>>>>>>");
                    setState(() {
                      newobscureText = !newobscureText;
                    });
                  },
                  controller: controller.currentpass,
                  accentcolor: NeumorphicTheme.accentColor(context),
                  basecolor: NeumorphicTheme.baseColor(context),
                  hinttext: '******************',
                  validator: (e) {
                    return null;
                  },
                  showerror: currentpasserror,
                  errormsg: currentpassmsg,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        'Confirm New Password',
                        textAlign: TextAlign.start,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40016,
                            color: NeumorphicTheme.accentColor(context)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextBoxwidget(
                  obsecuretext: confirmobsureText,
                  suffixshowicon: true,
                  iconorimage: true,
                  child: (confirmobsureText
                      ? Image.asset(NeumorphicTheme.isUsingDark(context)
                          ? "assets/DarkEyes.png"
                          : "assets/LightEye.png")
                      : Image.asset(NeumorphicTheme.isUsingDark(context)
                          ? "assets/DarkHide.png"
                          : 'assets/LightHides.png')),
                  ontapsufixicon: () {
                    print("object==>>>>>>>>>");
                    setState(() {
                      confirmobsureText = !confirmobsureText;
                    });
                  },
                  controller: controller.confirmpass,
                  accentcolor: NeumorphicTheme.accentColor(context),
                  basecolor: NeumorphicTheme.baseColor(context),
                  hinttext: '******************',
                  validator: (e) {
                    return null;
                  },
                  showerror: confirmpasserror,
                  errormsg: confirmpassmsg,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: NeumorphicTheme.accentColor(context),
              ),
              child: controller.passwordloading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: NeumorphicTheme.defaultTextColor(context),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        if (controller.passwordloading.value == false) {
                          CheckValidation().then((value) => {
                                if (value == false)
                                  {controller.Changepassword(context)}
                              });
                        }
                      },
                      child: Text(
                        'Save',
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw50018,
                            color: NeumorphicTheme.baseColor(context)),
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
