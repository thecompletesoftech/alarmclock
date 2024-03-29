import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/Profile/Controller/ProfileController.dart';
import 'package:clockalarm/View/Auth/Profile/EditProfile.dart';
import 'package:clockalarm/View/Auth/Profile/History.dart';
import 'package:clockalarm/View/Auth/ResetPassword/ResetPassword.dart';
import 'package:clockalarm/Widgets/CardWidget.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController controller = Get.put(ProfileController());
  var box = GetStorage();
  bool isDarkmode = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: controller.darktheme.value == true
            ? mycolor().lightBlack
            : mycolor().lightWhite,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: controller.darktheme.value == true
            ? Brightness.light
            : Brightness.dark));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  profiletext,
                  style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw60022,
                      color: NeumorphicTheme.accentColor(context)),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  box.read('isdark') == true
                      ? box.write('isdark', false)
                      : box.write('isdark', true);
                  setState(() {
                    controller.darktheme.value = !controller.darktheme.value;
                  });
                },
                child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: Utils().decoration(
                        cntx: context,
                        isdark: NeumorphicTheme.isUsingDark(context),
                        radius: 32.5 * fem),
                    child: Image.asset(
                      'assets/ChangeTheme.png',
                      color: NeumorphicTheme.accentColor(context),
                      height: 20,
                      width: 20,
                    )).paddingOnly(left: 10),
              ),
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 5),
        ).marginOnly(top: 8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: ApiHelper().getsnapshotbyuserid('users'),
              builder: (contexts, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: NeumorphicTheme.accentColor(context),
                        ),
                      ),
                    ],
                  );
                }
                if ((snapshot.data == null) ||
                    (snapshot.data!.docs.length < 1)) {
                  return Container();
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext contexts, int index) {
                      var item = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          controller.selectimage != null
                              ? GestureDetector(
                                  onTap: () {
                                    // Permissions()
                                    //     .checkCamerapermission()
                                    //     .then((value) {
                                    //   if (value) {
                                    //     _imagepicker(
                                    //         NeumorphicTheme.isUsingDark(
                                    //             context));
                                    //   }
                                    // });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        border: Border.all(
                                            width: 9.0,
                                            color: NeumorphicTheme.accentColor(
                                                context))),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.file(
                                        File(controller.selectimage),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : ((item['image'] == null) ||
                                      (item['image'].length < 1) ||
                                      (item['image'] == ""))
                                  ? GestureDetector(
                                      onTap: () {
                                        // Permissions()
                                        //     .checkCamerapermission()
                                        //     .then((value) {
                                        //   if (value) {
                                        //     _imagepicker(NeumorphicTheme
                                        //         .isUsingDark(context));
                                        //   }
                                        // });
                                      },
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(60.0),
                                              border: Border.all(
                                                  width: 9.0,
                                                  color: NeumorphicTheme
                                                      .accentColor(context))),
                                          child: CircleAvatar(
                                            radius: 50.0,
                                            backgroundImage: AssetImage(
                                              "assets/demouser.png",
                                            ),
                                            backgroundColor:
                                                NeumorphicTheme.accentColor(
                                                    context),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        // Permissions()
                                        //     .checkCamerapermission()
                                        //     .then((value) {
                                        //   if (value) {
                                        //     _imagepicker(NeumorphicTheme
                                        //         .isUsingDark(context));
                                        //   }
                                        // });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                            border: Border.all(
                                                width: 9.0,
                                                color:
                                                    NeumorphicTheme.accentColor(
                                                        context))),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Container(
                                            child: CachedNetworkImage(
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              imageUrl: item['image'],
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: NeumorphicTheme
                                                            .accentColor(
                                                                context),
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ).paddingOnly(top: 5),
                          SizedBox(height: 32),
                          CardWidget(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                NeumorphicTheme.isUsingDark(context)
                                    ? "assets/DarkUser.png"
                                    : "assets/WhiteUser.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            title: item['name'] ?? '',
                          ),
                          SizedBox(
                              height: NeumorphicTheme.isUsingDark(context)
                                  ? 28
                                  : 20),
                          CardWidget(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Image.asset(
                                  NeumorphicTheme.isUsingDark(context)
                                      ? "assets/Darksign.png"
                                      : "assets/Lightsign.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              title: item['email'] ?? ''),
                          SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  generalsettings,
                                  style: MyTextStyle.Dynamic(
                                      style: MyTextStyle.mw70020,
                                      color:
                                          NeumorphicTheme.isUsingDark(context)
                                              ? mycolor().greenlightcolor
                                              : mycolor().lighttxtcolor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          CardWidget(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                NeumorphicTheme.isUsingDark(context)
                                    ? "assets/DarkEdit.png"
                                    : "assets/LightEdit.png",
                                height: 30,
                                width: 25,
                              ),
                            ),
                            title: editprofiletext,
                            ontap: () {
                              nextscreen(context, EditProfile());
                            },
                          ),
                          SizedBox(
                              height: NeumorphicTheme.isUsingDark(context)
                                  ? 28
                                  : 20),
                          CardWidget(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                NeumorphicTheme.isUsingDark(context)
                                    ? "assets/DarkTime.png"
                                    : "assets/LightTime.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            title: historytext,
                            ontap: () {
                              nextscreen(context, History());
                            },
                          ),
                          SizedBox(
                              height: NeumorphicTheme.isUsingDark(context)
                                  ? 28
                                  : 20),
                          CardWidget(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                NeumorphicTheme.isUsingDark(context)
                                    ? "assets/DarkReset.png"
                                    : "assets/LightReset.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            title: resetpassword,
                            ontap: () {
                              nextscreen(context, ResetPassword());
                            },
                          ),
                          SizedBox(
                              height: NeumorphicTheme.isUsingDark(context)
                                  ? 28
                                  : 20),
                          CardWidget(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                NeumorphicTheme.isUsingDark(context)
                                    ? "assets/DarkLogout.png"
                                    : "assets/LightLogout.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            title: logout,
                            ontap: () {
                              showLogOut(NeumorphicTheme.isUsingDark(context))
                                  .then((value) {
                                if (value == true) {
                                  box.erase();
                                  Navigator.pop(context);
                                  nextscreenwithoutback(context, SignIn());
                                }
                              });
                            },
                          ),
                          SizedBox(
                              height: NeumorphicTheme.isUsingDark(context)
                                  ? 28
                                  : 20),
                          CardWidget(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                NeumorphicTheme.isUsingDark(context)
                                    ? "assets/DarkDelete.png"
                                    : "assets/LightDelete.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            title: deleteaccount,
                            ontap: () {
                              showDeleteaccout(
                                      NeumorphicTheme.isUsingDark(context))
                                  .then((value) {
                                if (value == true) {
                                  relogin(NeumorphicTheme.isUsingDark(context))
                                      .then((value) {
                                    log("vvvvvvvvvvvv");
                                    if (value == true) {
                                      box.erase();
                                      Navigator.pop(context);
                                      nextscreenwithoutback(context, SignIn());
                                    }
                                  });
                                }
                              });
                            },
                          ),
                          SizedBox(
                              height: NeumorphicTheme.isUsingDark(context)
                                  ? 28
                                  : 20),
                        ],
                      );
                    });
              }),
        ),
      ),
    );
  }

  Future showLogOut(isDark) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: isDark ? mycolor().lightBlack : mycolor().lightWhite,
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        logoutpopuptext,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: isDark
                                ? mycolor().lightWhite
                                : mycolor().darkgreen),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDark ? mycolor().darkbalck : mycolor().lightWhite,
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        "Yes",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: isDark
                                ? mycolor().lightWhite
                                : mycolor().darkgreen),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDark ? mycolor().darkbalck : mycolor().lightWhite,
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        "No",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: isDark
                                ? mycolor().lightWhite
                                : mycolor().darkgreen),
                      ),
                    ),
                  ],
                ).paddingAll(6.0),
              ],
            ),
          )),
    );
  }

  Future showDeleteaccout(isDark) async {
    controller.password.clear();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: isDark ? mycolor().darkbalck : mycolor().lightWhite,
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        deleteacpoputext,
                        textAlign: TextAlign.center,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: isDark
                                ? mycolor().lightWhite
                                : mycolor().darkgreen),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDark ? mycolor().darkbalck : mycolor().lightWhite,
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        "Yes",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: isDark
                                ? mycolor().lightWhite
                                : mycolor().darkgreen),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDark ? mycolor().darkbalck : mycolor().lightWhite,
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        "No",
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: isDark
                                ? mycolor().lightWhite
                                : mycolor().darkgreen),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future relogin(isDark) async {
    bool _obscureText = true;
    var passworderror = false;
    var passerrormsg = '';
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: isDark ? mycolor().darkbalck : mycolor().lightWhite,
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        deleteloginmsg,
                        textAlign: TextAlign.center,
                        style: MyTextStyle.Dynamic(
                            style: MyTextStyle.mw40018,
                            color: isDark
                                ? mycolor().lightWhite
                                : mycolor().darkgreen),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextBoxwidget(
                        obsecuretext: _obscureText,
                        suffixshowicon: true,
                        iconorimage: true,
                        child: (_obscureText
                            ? Image.asset(NeumorphicTheme.isUsingDark(context)
                                ? "assets/DarkHide.png"
                                : 'assets/LightHides.png')
                            : Image.asset(NeumorphicTheme.isUsingDark(context)
                                ? "assets/DarkEyes.png"
                                : "assets/LightEye.png")),
                        ontapsufixicon: () {
                          print("object==>>>>>>>>>");
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        controller: controller.password,
                        hinttext: password,
                        accentcolor: NeumorphicTheme.isUsingDark(context)
                            ? mycolor().darktxtcolor
                            : mycolor().lighttxtcolor,
                        basecolor: NeumorphicTheme.isUsingDark(context)
                            ? mycolor().lightBlack
                            : mycolor().lightWhite,
                        validator: (e) {
                          return null;
                        },
                        showerror: passworderror,
                        errormsg: passerrormsg,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? mycolor().darkbalck
                              : mycolor().lightWhite,
                        ),
                        onPressed: () async {
                          if (controller.password.text.length < 1) {
                            setState(() {
                              passworderror = true;
                              passerrormsg = requiredtext + password;
                            });
                          } else if (controller.profileloading.value == false) {
                            controller.deleteUserAccount(context).then((value) {
                              if (value != null) {
                                Navigator.pop(context, value);
                              }
                            });
                          }
                        },
                        child: controller.profileloading.value == true
                            ? Container(
                                width: 120,
                                height: 50,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: isDark
                                      ? mycolor().darktxtcolor
                                      : mycolor().lighttxtcolor,
                                )),
                              )
                            : Text(
                                deleteaccount,
                                style: MyTextStyle.Dynamic(
                                    style: MyTextStyle.mw40018,
                                    color: isDark
                                        ? mycolor().lightWhite
                                        : mycolor().darkgreen),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          })),
    );
  }
}
