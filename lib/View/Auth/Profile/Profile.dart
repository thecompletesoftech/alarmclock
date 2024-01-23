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
                color: mycolor().White,
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
                        _imagepicker();
                      },
                      child: Center(
                        child: CircleAvatar(
                          radius: 70.0,
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
                            _imagepicker();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.file(
                              selectimage!,
                              height: 70,
                              width: 70,
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
                  showDeleteaccout();
                },
              ),
              SizedBox(height: NeumorphicTheme.isUsingDark(context) ? 28 : 20),
            ],
          ),
        ),
      ),
    );
  }

  Future _imagepicker() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NeumorphicTheme.accentColor(context),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: transparentColor,
                  // shadowColor: transparentColor,
                  ),
              onPressed: () {
                _pickcamera();
                Navigator.of(context).pop();
              },
              child: Text(
                "Camera".tr,
                // style: GridListTextStyle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: transparentColor,
                  // shadowColor: transparentColor,
                  ),
              onPressed: () {
                _pickgallary();
                Navigator.of(context).pop();
              },
              child: Text(
                "Gallery".tr,
                // style: GridListTextStyle,
              ),
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                nextscreenwithoutback(context, SignIn());
              },
              child: Text(
                "Yes",
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw40018,
                    color: NeumorphicTheme.accentColor(context)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: transparentColor,
                  // shadowColor: transparentColor,
                  ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw40018,
                    color: NeumorphicTheme.accentColor(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDeleteaccout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NeumorphicTheme.accentColor(context),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: transparentColor,
                  // shadowColor: transparentColor,
                  ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Yes".tr,
                // style: GridListTextStyle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: transparentColor,
                  // shadowColor: transparentColor,
                  ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No".tr,
                // style: GridListTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
