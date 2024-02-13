import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../Config/Color.dart';
import '../Config/TextStyle.dart';

class TextBoxwidget extends StatefulWidget {
  final labeltxt;
  final suffixicon;
  final Bgcolor;
  final Function? ontap;
  final TextEditingController? controller;
  final bool readtype;
  final style;
  final bool iconorimage;
  final String? imagepath;
  final String? hinttext;
  final hintstyle;
  final bool suffixshowicon;
  final inputformate;
  final keyboradtype;
  final height;
  final width;
  final maxline;
  final double radius;
  final leftpadding;
  final toppadding;
  final bottompadding;
  final bool? obsecuretext;
  final Function? ontapsufixicon;
  final showprefixicon;
  final suffix_icon_color;
  final double size;
  final maxlength;
  final showborder;
  final descbox;
  final prefixicon;
  final showoutlineborder;
  final child;
  final label;
  final labelstyle;
  final outerborderclr;
  final autofocus;
  final onchange;
  final String? Function(String?)? validator;
  final errormsg;
  final showerror;
  final neumormargintop;
  final neumormarginbottom;
  final textboxvertival;
  final neumormarginleft;
  final accentcolor;
  final basecolor;

  TextBoxwidget({
    Key? key,
    this.labeltxt,
    // this.prefixicon,
    this.suffixicon,
    this.Bgcolor,
    this.ontap,
    this.controller,
    this.readtype = false,
    this.style,
    this.iconorimage = false,
    this.imagepath,
    this.hinttext,
    this.hintstyle,
    this.suffixshowicon = false,
    this.keyboradtype = TextInputType.text,
    this.height,
    this.width,
    this.maxline = 1,
    this.radius = 15.0,
    this.leftpadding = 20.0,
    this.obsecuretext = false,
    this.ontapsufixicon,
    this.suffix_icon_color,
    this.size = 20.0,
    this.showborder = false,
    this.showoutlineborder = false,
    required this.validator,
    this.maxlength,
    this.descbox = false,
    this.showprefixicon = false,
    this.prefixicon = null,
    this.child,
    this.inputformate,
    this.label,
    this.labelstyle,
    this.toppadding = 15.0,
    this.bottompadding = 15.0,
    this.outerborderclr,
    this.autofocus = false,
    this.onchange,
    this.errormsg = '',
    this.showerror = false,
    this.neumormarginleft = 8.0,
    this.neumormargintop = 2.0,
    this.neumormarginbottom = 4.0,
    this.textboxvertival = 2.0,
    required this.accentcolor,
    required this.basecolor,
  }) : super(key: key);

  @override
  State<TextBoxwidget> createState() => _TextBoxwidgetState();
}

class _TextBoxwidgetState extends State<TextBoxwidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: widget.basecolor,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    offset: -Offset(9, 9),
                    color: widget.basecolor == mycolor().lightBlack
                        ? Color.fromRGBO(56, 56, 56, 0.68)
                        : Color.fromRGBO(255, 255, 255, 0.68),
                    inset: true),
                BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(9, 9),
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    inset: true),
              ]),
          child: TextFormField(
            onChanged: (value) {
              widget.onchange(value);
            },
            cursorColor: widget.accentcolor,
            inputFormatters: widget.inputformate,
            validator: widget.validator,
            maxLines: widget.maxline,
            keyboardType: widget.keyboradtype,
            obscureText: widget.obsecuretext!,
            onTap: () {
              widget.ontap!();
            },
            style: widget.style,
            autofocus: widget.autofocus,
            readOnly: widget.readtype,
            controller: widget.controller,
            maxLength: widget.maxlength,
            decoration: InputDecoration(
              enabledBorder: widget.showoutlineborder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.outerborderclr ?? widget.basecolor,
                      ),
                      borderRadius: BorderRadius.circular(10))
                  : widget.showborder
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.outerborderclr ?? widget.basecolor,
                          ),
                        )
                      : InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIconConstraints: BoxConstraints(
                maxWidth: widget.showprefixicon ? 80 : 0,
                maxHeight: widget.showprefixicon ? 70 : 0,
              ),
              prefixIcon: widget.showprefixicon ? widget.prefixicon : null,
              isDense: true,
              contentPadding: EdgeInsets.only(
                  left: widget.leftpadding,
                  top: widget.toppadding,
                  bottom: widget.bottompadding),
              border: widget.showborder
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.basecolor,
                      ),
                    )
                  : widget.showoutlineborder
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.basecolor,
                          ),
                          borderRadius: BorderRadius.circular(15))
                      : InputBorder.none,
              labelText: widget.label,
              labelStyle: widget.labelstyle,
              hintText: widget.hinttext,
              hintStyle: widget.hintstyle ??
                  MyTextStyle.Dynamic(
                    style: MyTextStyle.mw30016,
                    color: widget.accentcolor,
                  ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: widget.suffixshowicon ? 30 : 0,
                maxHeight: widget.suffixshowicon ? 20 : 0,
              ),
              suffixIcon: widget.suffixshowicon
                  ? widget.iconorimage
                      ? GestureDetector(
                          onTap: () {
                            widget.ontapsufixicon!();
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: widget.child),
                        )
                      : GestureDetector(
                          onTap: () {
                            widget.ontapsufixicon!();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              widget.suffixicon,
                              color: widget.suffix_icon_color ??
                                  widget.accentcolor,
                              size: widget.size,
                            ),
                          ),
                        )
                  : Padding(
                      padding: EdgeInsets.all(5),
                    ),
            ),
          ),
        ),
        if (widget.showerror)
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
            ),
            child: Text(
              widget.errormsg,
              style: MyTextStyle.Dynamic(
                  color: mycolor().Redcolor, style: MyTextStyle.mw40014),
            ),
          ),
      ],
    );
  }
}
