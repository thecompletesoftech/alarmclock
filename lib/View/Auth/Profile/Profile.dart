import 'dart:developer';
import 'dart:io';

import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/Profile/History.dart';
import 'package:clockalarm/Widgets/CardWidget.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? selectimage;

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
              profiletext,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw60030,
                  color: NeumorphicTheme.accentColor(context)),
            ),
            Container(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              selectimage == null
                  ? GestureDetector(
                      onTap: () {
                        _imagepicker(NeumorphicTheme.isUsingDark(context));
                      },
                      child: Center(
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: AssetImage(
                            "assets/profile.png",
                          ),
                          backgroundColor: mycolor().Transparent,
                        ),
                      ),
                    )
                  : selectimage != null
                      ? GestureDetector(
                          onTap: () {
                            _imagepicker(NeumorphicTheme.isUsingDark(context));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.file(
                              selectimage!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(),
              SizedBox(height: 32),
              CardWidget(
                title: bruceBanner,
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 28 : 20),
              CardWidget(
                title: mailtext,
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      generalsettings,
                      style: MyTextStyle.Dynamic(
                          style: MyTextStyle.mw70020,
                          color: NeumorphicTheme.accentColor(context)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17),
              CardWidget(
                title: historytext,
                ontap: () {
                  nextscreen(context, History());
                },
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 28 : 20),
              CardWidget(
                title: resetpassword,
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 28 : 20),
              CardWidget(
                title: logout,
                ontap: () {
                  showLogOut(NeumorphicTheme.isUsingDark(context));
                },
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 28 : 20),
              CardWidget(
                title: deleteaccount,
                ontap: () {
                  showDeleteaccout(NeumorphicTheme.isUsingDark(context));
                },
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 28 : 20),
            ],
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
      selectimage = File(returnediImage!.path);
      // print("imgpath" + _selectedImage.toString());
      log("imag" + selectimage.toString());
    });
  }

  Future _pickgallary() async {
    final returnediImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectimage = File(returnediImage!.path);
      // print("imgpath" + _selectedImage.toString());
      print("imag" + selectimage.toString());
    });
  }

  showLogOut(isDark) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: isDark ? mycolor().darkbalck : mycolor().lightWhite,
          content: Container(
            height: 100,
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
                        nextscreenwithoutback(context, SignIn());
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
