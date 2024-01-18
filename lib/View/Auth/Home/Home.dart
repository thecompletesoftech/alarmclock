import 'package:clockalarm/Config/Import.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: Text(
          worldclock,
          style: MyTextStyle.Dynamic(
              style: MyTextStyle.mw60030,
              color: NeumorphicTheme.accentColor(context)),
        ),
        title: NeumorphicText(
          "Neumorphic Design",
          textStyle:
              NeumorphicTextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          style: NeumorphicStyle(color: Colors.black),
        ),
        actions: [
          NeumorphicButton(
            onPressed: () {},
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              depth: 3.0,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.favorite_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
