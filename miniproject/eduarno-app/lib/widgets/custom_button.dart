import 'package:eduarno/Utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final void Function() onTap;
  final bool isLoading;
  final Color textColor;
  final Color bgColor;
  final double width;
  final AlignmentGeometry alignment;

  const Button({
    Key key,
    @required this.title,
    @required this.onTap,
    this.formKey,
    this.isLoading,
    this.width = double.infinity,
    this.alignment = Alignment.centerLeft,
    this.textColor = Colors.black,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: width,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: bgColor,
            onPrimary: kBlueColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // <-- Radius
            ),
          ),
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
          onPressed: () {
            if (!isLoading) if (formKey != null &&
                formKey.currentState.validate()) onTap();
            if (formKey == null) {
              onTap();
            }
          },
        ),
      ),
    );
  }
}
