import 'package:brillo/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupTextFields extends StatefulWidget {
  final Widget? prefixIcon;
  final String? label;
  final String? helperText;
  final bool? password;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const SignupTextFields({
    Key? key,
    this.prefixIcon,
    this.label,
    this.helperText,
    this.password = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _SignupTextFieldsState createState() => _SignupTextFieldsState();
}

class _SignupTextFieldsState extends State<SignupTextFields> {
  FocusNode? _focusNode;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: widget.controller,
      focusNode: _focusNode,
      onTap: _requestFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.password! ? _visible : false,
      style: GoogleFonts.dmSans(
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        suffixIcon: widget.password!
            ? IconButton(
                icon: _visible
                    ? Icon(
                        Icons.visibility,
                        color: Color(0xffacacac),
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: Color(0xffacacac),
                      ),
                onPressed: () {
                  setState(() {
                    _visible = !_visible;
                  });
                },
              )
            : SizedBox(),
        prefixIcon: widget.prefixIcon,
        // helperText: _focusNode.hasFocus ? widget.helperText : '',
        // helperStyle: GoogleFonts.roboto(
        //   color: _focusNode.hasFocus ? Constants.purple : Colors.white,
        // ),
        // hintText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 13,
          color: _focusNode!.hasFocus ? kBlue : Colors.black54,
        ),
        labelText: widget.label,

        // fillColor:Colors.black54,
        // filled: true,
        errorStyle: GoogleFonts.dmSans(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 0.5),
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBlue, width: 2),
        ),
      ),
    );
  }
}
