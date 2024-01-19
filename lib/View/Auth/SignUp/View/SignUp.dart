import 'package:clockalarm/Config/Import.dart';
import 'package:clockalarm/Widgets/ButtonWidget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                hinttext: fullname,
                validator: (e) {},
              ),
              SizedBox(height: 24),
              TextBoxwidget(
                hinttext: email,
                validator: (e) {},
              ),
              SizedBox(height: 24),
              TextBoxwidget(
                hinttext: password,
                validator: (e) {},
              ),
              SizedBox(height: 24),
              TextBoxwidget(
                hinttext: confirmpassword,
                validator: (e) {},
              ),
              SizedBox(height: 30),
              Center(
                child: ButtonWidget(height: 60.0, width: 0.87, name: register),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
