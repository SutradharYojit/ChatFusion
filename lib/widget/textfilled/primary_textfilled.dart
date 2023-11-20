import 'package:flutter/material.dart';
import '../../resources/resources.dart';

// this primary textfilled where we use this in all over the app
class PrimaryTextFilled extends StatelessWidget {
  const PrimaryTextFilled({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines,
    this.autofocus,
    this.prefixText,
    this.maxLength,
    this.readOnly,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textCapitalization,
    this.validator,
    this.contentPadding,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool? autofocus;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      controller: controller,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType,
      maxLines: maxLines ?? null,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        contentPadding:contentPadding?? null,
        fillColor: Colors.white,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        hintText: hintText,
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        // border: buildOutlineInputBorder(),
        errorBorder: buildErrorOutlineInputBorder(),
        focusedErrorBorder: buildErrorOutlineInputBorder(),
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xff9370DB)),
    borderRadius: BorderRadius.circular(15),
  );
}

OutlineInputBorder buildErrorOutlineInputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
    borderRadius: BorderRadius.circular(15),
  );
}
