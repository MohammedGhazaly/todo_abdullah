import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validatorFunction;
  final String? hintText;
  final Widget? prefix;
  final void Function()? tapFuntion;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final bool? enabled;
  const CustomTextFormField(
      {super.key,
      required this.textEditingController,
      this.validatorFunction,
      this.hintText,
      this.prefix,
      this.tapFuntion,
      this.textInputType,
      this.focusNode,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      focusNode: focusNode,
      onTap: tapFuntion,
      controller: textEditingController,
      validator: validatorFunction,
      keyboardType: textInputType,
      decoration: InputDecoration(
          prefixIcon: prefix,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(8)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8))),
    );
  }
}
