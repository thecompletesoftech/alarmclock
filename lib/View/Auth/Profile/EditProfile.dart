import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/CheckPermissions.dart';
import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/Profile/Controller/ProfileController.dart';
import 'package:clockalarm/Widgets/CardWidget.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController controller = Get.put(ProfileController());

  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
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
              Text(
                editprofiletext,
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw60024,
                    color: NeumorphicTheme.accentColor(context)),
              ),
              GestureDetector(
                  onTap: () async {
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? ThemeMode.dark
                        : ThemeMode.light;
                    // if (controller.profileloading.value == false) {
                    //   if (controller.selectimage != null) {
                    //     controller.updateprofile(context);
                    //   } else {
                    //     Navigator.pop(context);
                    //   }
                    // }
                  },
                  child: Container()),
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
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60.0),
                                                  border: Border.all(
                                                      width: 9.0,
                                                      color: NeumorphicTheme
                                                          .accentColor(
                                                              context))),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(60.0),
                                                border: Border.all(
                                                    width: 9.0,
                                                    color: NeumorphicTheme
                                                        .accentColor(context))),
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
                                        ),
                              // SvgPicture.string(camera, color: mycolor().White,height: 50,),
                              Center(
                                child: GestureDetector(
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
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                    color: NeumorphicTheme.accentColor(context),
                                  ).paddingOnly(top: 20),
                                ),
                              ),
                              SizedBox(height: 32),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Text(
                                      fullname,
                                      style: MyTextStyle.Dynamic(
                                          style: MyTextStyle.mw40018,
                                          color: NeumorphicTheme.accentColor(
                                              context)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: NeumorphicTheme.isUsingDark(context)
                                      ? 14
                                      : 5),
                              TextBoxwidget(
                                hintstyle: MyTextStyle.Dynamic(
                                    style: MyTextStyle.mw40018,
                                    color: NeumorphicTheme.defaultTextColor(
                                        context)),
                                controller: controller.nameContoller,
                                hinttext: '',
                                suffixshowicon: true,
                                iconorimage: true,
                                child: Image.asset(
                                  NeumorphicTheme.isUsingDark(context)
                                      ? 'assets/DarkEdit.png'
                                      : 'assets/LightEdit.png',
                                  height: 30,
                                  width: 25,
                                ),
                                accentcolor:
                                    NeumorphicTheme.accentColor(context),
                                basecolor: NeumorphicTheme.baseColor(context),
                                validator: (e) {
                                  return null;
                                },
                              ),
                              SizedBox(
                                  height: NeumorphicTheme.isUsingDark(context)
                                      ? 28
                                      : 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Text(
                                      emailaddtext,
                                      style: MyTextStyle.Dynamic(
                                          style: MyTextStyle.mw40018,
                                          color: NeumorphicTheme.accentColor(
                                              context)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: NeumorphicTheme.isUsingDark(context)
                                      ? 14
                                      : 5),
                              TextBoxwidget(
                                readtype: true,
                                hinttext: item['email'] ?? '',
                                hintstyle: MyTextStyle.Dynamic(
                                    style: MyTextStyle.mw40018,
                                    color: NeumorphicTheme.defaultTextColor(
                                        context)),
                                accentcolor:
                                    NeumorphicTheme.accentColor(context),
                                basecolor: NeumorphicTheme.baseColor(context),
                                validator: (e) {
                                  return null;
                                },
                              ),
                            ],
                          );
                        });
                  }),
            ),
          ),
          // if (controller.profileloading.value)
          //   Center(
          //     child: CircularProgressIndicator(
          //       color: NeumorphicTheme.accentColor(context),
          //     ),
          //   )
        ],
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
              child: controller.profileloading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: NeumorphicTheme.defaultTextColor(context),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        if (controller.profileloading.value == false) {
                          if (controller.selectimage != null) {
                            controller.EditProfileprofile(context);
                          } else {
                            Navigator.pop(context);
                          }
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
            height: 130,
            child: Column(
              children: [
                Text(
                  logoutpopuptext,
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
                ),
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
