import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';

import 'heading_title_text.dart';

enum CustomField { clickable, input, password }

class CustomTextField extends StatelessWidget {
  final Color fillColor;
  final TextEditingController textEditingController;
  final List<TextInputFormatter> textFormatter;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final String hintText;
  final String labelText;
  final CustomField customField;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool isPrefixIcon;
  final String? Function(String?)? validator;
  final void Function() ontap;
  final bool isSuffixIcon;
  final bool isReadOnly;
  final bool showHeadingTitle;
  final String? Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.textFormatter,
    this.keyboardType = TextInputType.name,
    this.textCapitalization = TextCapitalization.none,
    required this.hintText,
    this.labelText = '',
    this.customField = CustomField.input,
    this.prefixIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.isPrefixIcon = false,
    required this.ontap,
    this.isSuffixIcon = false,
    this.fillColor = Colors.white,
    this.validator,
    this.isReadOnly = true,
    this.onChanged,
    this.showHeadingTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: field(customField),
    );
  }

  Widget field(CustomField customField) {
    switch (customField) {
      case CustomField.input:
        return inputTextField();
      case CustomField.clickable:
        return clickableField();
      default:
        return Container();
    }
  }

  Widget clickableField() {
    return Column(
      children: [
        if (showHeadingTitle)
          Row(
            children: [
              HeadingTitleText(
                fontSize: FontSize.normal,
                title: labelText,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        TextField(
          readOnly: isReadOnly,
          controller: textEditingController,
          onTap: ontap,
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            suffixIconConstraints: isSuffixIcon
                ? BoxConstraints(minHeight: 48, maxHeight: 48)
                : BoxConstraints(minHeight: 10, minWidth: 10),
            prefixIconConstraints: isPrefixIcon
                ? BoxConstraints(minHeight: 48, maxHeight: 48)
                : BoxConstraints(minHeight: 10, minWidth: 10),
            prefixIcon: prefixIcon,
            
            suffixIcon: suffixIcon,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.orangeProfile),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget inputTextField() {
    return Column(
      children: [
        Row(
          children: [
            HeadingTitleText(
              fontSize: FontSize.normal,
              title: labelText,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: textEditingController,
          inputFormatters: textFormatter,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          validator: validator,
          onTap: ontap,
          decoration: InputDecoration(
            suffixIconConstraints: isSuffixIcon
                ? BoxConstraints(minHeight: 48, maxHeight: 48)
                : BoxConstraints(minHeight: 10, minWidth: 10),
            prefixIconConstraints: isPrefixIcon
                ? BoxConstraints(minHeight: 48, maxHeight: 48)
                : BoxConstraints(minHeight: 10, minWidth: 10),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor,
            filled: true,
            // label: HeadingTitleText(fontSize: FontSize.normal, title: 'Birthday'),
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.orangeProfile),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
