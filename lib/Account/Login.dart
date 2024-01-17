import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../Config/TextStyle.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(child: Image.asset("assets/TivalLogo.png")),
              SizedBox(
                height: 17,
              ),
              Row(
                children: [
                  Text(
                    "Login",
                    style: LoginTextStyle,
                  ),
                ],
              ),
              Neumorphic(
                margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
                style: NeumorphicStyle(
                  depth: NeumorphicTheme.embossDepth(context),
                  boxShape: NeumorphicBoxShape.stadium(),
                ),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                child: TextField(
                    onChanged: (value) {
                      
                    },
                    controller: _controller,
                    // decoration: InputDecoration.collapsed(hintText: this.widget.hint),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
