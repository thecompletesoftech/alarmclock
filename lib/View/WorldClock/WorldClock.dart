import 'package:clockalarm/Config/Import.dart';
import 'package:flutter/material.dart';

class worldclock extends StatefulWidget {
  const worldclock({super.key});

  @override
  State<worldclock> createState() => _worldclockState();
}

class _worldclockState extends State<worldclock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              worldclockalrm,
              style: MyTextStyle.Dynamic(
                  style: MyTextStyle.mw60030,
                  color: NeumorphicTheme.accentColor(context)),
            ),
            SizedBox(
              width: 22,
            ),
            Row(
              children: [
                NeumorphicButton(
                  onPressed: () {},
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    depth: 3.0,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.add,
                      color: NeumorphicTheme.accentColor(context)),
                ),
                SizedBox(
                  width: 12,
                ),
                NeumorphicButton(
                  onPressed: () {},
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    depth: 3.0,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.edit,
                      color: NeumorphicTheme.accentColor(context)),
                ),
                SizedBox(
                  width: 12,
                ),
                NeumorphicButton(
                  onPressed: () {},
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    depth: 3.0,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person_outline_rounded,
                      color: NeumorphicTheme.accentColor(context)),
                ),
              ],
            ),
          ],
        ),
        // title: NeumorphicText(
        //   "Neumorphic Design",
        //   textStyle:
        //       NeumorphicTextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        //   style: NeumorphicStyle(color: Colors.black),
        // ),
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
