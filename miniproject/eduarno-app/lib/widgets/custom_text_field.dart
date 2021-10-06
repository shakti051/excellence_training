import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode focusNode;
  final String title;
  final String val;
  final Color titleColor;
  final Color textColor;
  final String hint;
  final String helperText;
  final String label;
  final Color hintColor;
  final int maxLength;
  final MaxLengthEnforcement maxLengthEnforced;
  final int maxLine;
  final TextEditingController controller;
  final String Function(String) validator;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatter;
  final bool isEnabled;
  final int minLine;
  final bool isReadOnly;
  final bool isRequired;
  final bool obscureText;
  final bool capitalize;
  final void Function() onTap;

  const CustomTextField(
      {Key key,
      this.label,
      this.val,
      this.minLine,
      this.title,
      this.titleColor = Colors.green,
      this.textColor = Colors.black,
      @required this.hint,
      this.hintColor = Colors.grey,
      this.maxLine = 1,
      @required this.controller,
      this.validator,
      this.textInputType = TextInputType.name,
      this.inputFormatter,
      this.isEnabled,
      this.isReadOnly = false,
      this.onTap,
      this.isRequired = true,
      this.obscureText = false,
      this.focusNode,
      this.helperText,
      this.maxLength,
      this.maxLengthEnforced,
      this.capitalize = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          textCapitalization: capitalize
              ? TextCapitalization.characters
              : TextCapitalization.none,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: focusNode,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
          onTap: onTap,
          readOnly: isReadOnly,
          validator: validator,
          enabled: isEnabled ?? true,
          inputFormatters: inputFormatter,
          controller: controller,
          maxLines: maxLine,
          minLines: minLine,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforced,
          obscureText: obscureText,
          keyboardType: textInputType,
          cursorColor: titleColor,
          decoration: InputDecoration(
            fillColor: Color(0xffF6F7FA),
            filled: true,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xffF6F7FA), width: 0)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 0)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.green, width: 1),
            ),
            labelText: hint,
            labelStyle: TextStyle(
                color: Color(0xff9D9FA0),
                fontWeight: FontWeight.w400,
                fontSize: 16),
            hintText: hint,
            hintStyle: TextStyle(
                color: Color(0xff9D9FA0),
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        )
      ],
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  final String title;
  final Color titleColor;
  final String hint;
  final String label;
  final Color hintColor;
  final int maxLine;
  final TextEditingController controller;
  final String Function(String) validator;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatter;
  final bool isEnabled;
  final bool isReadOnly;
  final bool isRequired;
  final bool obscureText;
  final void Function() onTap;

  const CustomPasswordTextField({
    Key key,
    this.title,
    this.titleColor = Colors.green,
    this.label,
    @required this.hint,
    this.hintColor = Colors.green,
    this.maxLine = 1,
    @required this.controller,
    this.validator,
    this.textInputType = TextInputType.name,
    this.inputFormatter,
    this.isEnabled,
    this.isReadOnly = false,
    this.onTap,
    this.isRequired = true,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
        text: TextSpan(
          text: widget.title,
          style:
              TextStyle(color: widget.titleColor, fontWeight: FontWeight.bold),
        ),
      ),
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        onTap: widget.onTap,
        readOnly: widget.isReadOnly,
        enabled: widget.isEnabled ?? true,
        inputFormatters: widget.inputFormatter,
        controller: widget.controller,
        maxLines: widget.maxLine,
        obscureText: !_passwordVisible,
        keyboardType: widget.textInputType,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          // icon: Icon(Icons.person),
          // hintText: 'What do people call you?',
          // labelText: widget.label,

          // labelStyle: TextStyle(
          //     color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          fillColor: Color(0xffF6F7FA),
          filled: true,
          border: InputBorder.none,
          // focusedBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffF6F7FA), width: 0)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.label,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Color(0xff9D9FA0),
            fontWeight: FontWeight.w400,
          ),
          labelStyle: TextStyle(
            color: Color(0xff9D9FA0),
            fontWeight: FontWeight.w400,
          ),
          focusColor: Colors.black,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Color(0xff9D9FA0),
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    ]);
  }
}
