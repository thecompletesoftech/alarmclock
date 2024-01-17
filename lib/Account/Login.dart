import 'package:flutter/material.dart';


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
                    style: MyTextStyle.Dynamic(
                      style: MyTextStyle.mw70024
                    ),
                  ),
                ],
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
