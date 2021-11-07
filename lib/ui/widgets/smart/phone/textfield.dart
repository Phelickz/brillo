import 'package:brillo/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './countries.dart';

import 'model.dart';

class IntlPhoneField extends StatefulWidget {
  final bool? obscureText;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final bool? readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool? autoValidate;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  // final int maxLength;
  final bool? enabled;
  final Brightness? keyboardAppearance;
  final String? initialValue;
  final Function(String)? onChange;

  /// 2 Letter ISO Code
  // final String initialCountryCode;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool? showDropdownIcon;

  final BoxDecoration? dropdownDecoration;
  final List<TextInputFormatter>? inputFormatters;

  IntlPhoneField({
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.number,
    this.autoValidate = false,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    // this.maxLength = 10,
    this.enabled = true,
    this.keyboardAppearance = Brightness.light,
    this.onChange,
  });

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  FocusNode? _focusNode;

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

  Map<String, String> _selectedCountry =
      countries.firstWhere((item) => item['code'] == 'NG');
  List<Map<String, String>> filteredCountries = countries;
  FormFieldValidator<String>? validator;
  // final TextInputFormatter formatter =
  //     TextInputFormatter.withFunction((oldValue, newValue) {
  //   if (newValue.text.length <= oldValue.text.length) return newValue;
  //   return newValue.text.length > 10 ? oldValue : newValue;
  // });

  @override
  void initState() {
    _focusNode = FocusNode();
    // setSomething();
    validator = widget.autoValidate!
        ? (value) => value!.length != 10 ? 'Invalid Mobile Number' : null
        : widget.validator;
    super.initState();
  }

  // Future<void> setSomething() async {
  //   setState(() {
  //     _selectedCountry = countries.firstWhere((item) => item['code'] == 'NGN');
  //   });
  // }

  Future<void> _changeCountry() async {
    filteredCountries = countries;
    await showDialog(
      // barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (ctx, setState) => Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      labelText: 'Search by Country Name',
                      labelStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredCountries = countries
                            .where((country) =>
                                country['name']!.toLowerCase().contains(value))
                            .toList();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredCountries.length,
                      itemBuilder: (ctx, index) => Column(
                        children: <Widget>[
                          ListTile(
                            leading: Text(
                              filteredCountries[index]['flag']!,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            title: Text(
                              filteredCountries[index]['name']!,
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            ),
                            trailing: Text(
                              filteredCountries[index]['dial_code']!,
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            ),
                            onTap: () {
                              _selectedCountry = filteredCountries[index];
                              setState(() {});
                              Navigator.of(context).pop();
                              
                            },
                          ),
                          Divider(thickness: 1, color: Colors.black87),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(alignment: Alignment.topLeft, child: _buildFlagsButton()),
          SizedBox(width: 4),
          Expanded(
            child: TextFormField(
              
              initialValue: widget.initialValue,
              readOnly: widget.readOnly!,
              obscureText: widget.obscureText!,
              textAlign: widget.textAlign!,
              // onTap: _requestFocus,
              controller: widget.controller,
              focusNode: _focusNode,
              // style: GoogleFonts.dmSans(
              //   color: Colors.white,
              // ),

              onFieldSubmitted: (s) {
                if (widget.onSubmitted != null) widget.onSubmitted!(s);
              },
              decoration: InputDecoration(
                // prefixIcon: widget.prefixIcon,
                helperText:
                    _focusNode!.hasFocus ? 'Your primary phone number' : '',
                helperStyle: GoogleFonts.roboto(
                  color: _focusNode!.hasFocus ? kDarkBlue : Colors.white24,
                ),
                // hintText: label,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: _focusNode!.hasFocus ? kDarkBlue : Color(0xffacacac),
                ),
                labelText: 'Phone Number',
                // fillColor: Colors.grey[800],
                // filled: true,
                errorStyle: GoogleFonts.dmSans(
                  color: Colors.red[400],
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(0)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(0)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kDarkBlue, width: 2),
                ),
              ),
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              onSaved: (value) {
                if (widget.onSaved != null)
                  widget.onSaved!(
                    PhoneNumber(
                      countryISOCode: _selectedCountry['code'],
                      countryCode: _selectedCountry['dial_code'],
                      number: value,
                    ),
                  );
              },
              // onChanged: widget.onChange,
              onChanged: (value) {
                if (widget.onChanged != null)
                  widget.onChanged!(
                    PhoneNumber(
                      countryISOCode: _selectedCountry['code'],
                      countryCode: _selectedCountry['dial_code'],
                      number: value,
                    ),
                  );
              },
              validator: validator,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,

              enabled: widget.enabled,
              keyboardAppearance: widget.keyboardAppearance,
              // onTap: _requestFocus,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildFlagsButton() {
    return Container(
      // height: ,
      decoration: BoxDecoration(
        // border: Border(
        //   bottom: BorderSide(
        //     color: Color.fromRGBO(255, 255, 255, 0.2),
        //     width: 1,
        //   )
        // ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        color: Colors.grey[900],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.5, horizontal: 4),
          child: Row(
            children: <Widget>[
              if (widget.showDropdownIcon!) ...[
                Icon(Icons.arrow_drop_down),
                SizedBox(width: 4)
              ],
              Text(
                _selectedCountry['flag']!,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 8),
              FittedBox(
                child: Text(
                  _selectedCountry['dial_code']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white54,
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        onTap: _changeCountry,
      ),
    );
  }
}
