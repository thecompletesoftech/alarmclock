import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/View/Auth/Profile/History.dart';
import 'package:clockalarm/Widgets/CardWidget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back,
              color: mycolor().White,
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
              Center(
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundImage: AssetImage("assets/profile.png"),
                  backgroundColor: mycolor().Transparent,
                ),
              ),
              SizedBox(height: 32),
              CardWidget(
                title: bruceBanner,
              ),
              SizedBox(height: 28),
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
                ontap: (){
                  nextscreen(context, History());
                },
              ),
              SizedBox(height: 28),
              CardWidget(
                title: resetpassword,
              ),
              SizedBox(height: 28),
              CardWidget(
                title: logout,
              ),
              SizedBox(height: 28),
              CardWidget(
                title: deleteaccount,
              ),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
