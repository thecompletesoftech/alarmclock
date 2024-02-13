import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/CheckPermissions.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/Profile/Controller/ProfileController.dart';
import 'package:clockalarm/View/Auth/Profile/EditProfile.dart';
import 'package:clockalarm/View/Auth/Profile/History.dart';
import 'package:clockalarm/View/Auth/ResetPassword/ResetPassword.dart';
import 'package:clockalarm/Widgets/CardWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
    return Obx(
      () => Scaffold(
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
                    // final themeProvider = Provider.of<ThemeProvider>(context,
                    //     listen:
                    //         false); // get the provider, listen false is necessary cause is in a function

                    // setState(() {
                    //   isDarkmode = !isDarkmode;
                    // }); // change the variable

                    // isDarkmode // call the functions
                    //     ? themeProvider.setDarkmode()
                    //     : themeProvider.setLightMode();
                    // MediaQuery.of(context).platformBrightness == Brightness.dark
                    //     ? ThemeMode.dark
                    //     : ThemeMode.light;
                    // if (controller.profileloading.value == false) {
                    //   if (controller.selectimage != null) {
                    //     controller.updateprofile(context);
                    //   } else {
                    //     Navigator.pop(context);
                    //   }
                    // }
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
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: ApiHelper().getsnapshotbyuserid('users'),
                    builder: (context, snapshot) {
                      if ((snapshot.data == null) ||
                          (snapshot.data!.docs.length < 1)) {
                        return Container();
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var item = snapshot.data!.docs[index];
                            return Column(
                              children: [
                                controller.selectimage != null
                                    ? GestureDetector(
                                        onTap: () {
                                          Permissions()
                                              .checkCamerapermission()
                                              .then((value) {
                                            if (value) {
                                              _imagepicker(
                                                  NeumorphicTheme.isUsingDark(
                                                      context));
                                            }
                                          });
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.file(
                                            File(controller.selectimage),
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : ((item['image'] == null) ||
                                            (item['image'].length < 1) ||
                                            (item['image'] == ""))
                                        ? GestureDetector(
                                            onTap: () {
                                              Permissions()
                                                  .checkCamerapermission()
                                                  .then((value) {
                                                if (value) {
                                                  _imagepicker(NeumorphicTheme
                                                      .isUsingDark(context));
                                                }
                                              });
                                            },
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 60.0,
                                                backgroundImage: AssetImage(
                                                  "assets/profile.png",
                                                ),
                                                backgroundColor:
                                                    mycolor().Transparent,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              Permissions()
                                                  .checkCamerapermission()
                                                  .then((value) {
                                                if (value) {
                                                  _imagepicker(NeumorphicTheme
                                                      .isUsingDark(context));
                                                }
                                              });
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
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
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                // : Container(),
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
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
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
                                            color: NeumorphicTheme.isUsingDark(
                                                    context)
                                                ? mycolor().greenlightcolor
                                                : mycolor().lighttxtcolor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 17),
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
                                    showLogOut(NeumorphicTheme.isUsingDark(
                                            context))
                                        .then((value) {
                                      if (value == true) {
                                        box.erase();
                                        Navigator.pop(context);
                                        nextscreenwithoutback(
                                            context, SignIn());
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
                                        NeumorphicTheme.isUsingDark(context));
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
            if (controller.profileloading.value)
              Center(
                child: CircularProgressIndicator(
                  color: NeumorphicTheme.accentColor(context),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future _imagepicker(isDark) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? mycolor().darkbalck : mycolor().lightWhite,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectprofiletext,
              textAlign: TextAlign.center,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw40018,
                  color: isDark ? mycolor().lightWhite : mycolor().darkgreen),
            ),
            SizedBox(
              height: 10,
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
                    _pickcamera();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    cameratext,
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
                    _pickgallary();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    gallarytext,
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
      ),
    );
  }

  Future _pickcamera() async {
    final returnediImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      controller.selectimage = returnediImage!.path;
      log("imag" + controller.selectimage.toString());
    });
  }

  Future _pickgallary() async {
    final returnediImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      controller.selectimage = returnediImage!.path;
      print("imag" + controller.selectimage.toString());
    });
  }

  Future showLogOut(isDark) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: isDark ? mycolor().darkbalck : mycolor().lightWhite,
          content: Container(
            height: 120,
            // height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    logoutpopuptext,
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

  showDeleteaccout(isDark) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: isDark ? mycolor().darkbalck : mycolor().lightWhite,
          content: Container(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  deleteacpoputext,
                  textAlign: TextAlign.center,
                  style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw40018,
                      color:
                          isDark ? mycolor().lightWhite : mycolor().darkgreen),
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
                        // nextscreenwithoutback(context, SignIn());
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
                        Navigator.of(context).pop();
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
}
