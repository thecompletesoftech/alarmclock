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
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: 150),
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
                controller: controller.currentpass,
                hinttext: '******************',
                validator: (e) {
                  return null;
                },
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
                controller: controller.currentpass,
                hinttext: '******************',
                validator: (e) {
                  return null;
                },
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
                controller: controller.currentpass,
                hinttext: '******************',
                validator: (e) {
                  return null;
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
