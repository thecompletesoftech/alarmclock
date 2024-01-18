import '../Config/Import.dart';

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
    this.radius = 5,
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
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: buttonradius(),
          ),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 18),
          child: TextFormField(
            onChanged: (value) {
              widget.onchange(value);
            },
            cursorColor: NeumorphicTheme.accentColor(context),
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
                        color: widget.outerborderclr ??
                            NeumorphicTheme.baseColor(context),
                      ),
                      borderRadius: BorderRadius.circular(10))
                  : widget.showborder
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.outerborderclr ??
                                NeumorphicTheme.baseColor(context),
                          ),
                        )
                      : InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.outerborderclr ??
                        NeumorphicTheme.baseColor(context),
                    width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
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
                        color: NeumorphicTheme.baseColor(context),
                      ),
                    )
                  : widget.showoutlineborder
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: NeumorphicTheme.baseColor(context),
                          ),
                          borderRadius: BorderRadius.circular(15))
                      : InputBorder.none,
              labelText: widget.label,
              labelStyle: widget.labelstyle,
              hintText: widget.hinttext,
              hintStyle: widget.hintstyle ??
                  MyTextStyle.Dynamic(
                      style: MyTextStyle.mw40018,
                      color: NeumorphicTheme.accentColor(context)),
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
                                  NeumorphicTheme.accentColor(context),
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
