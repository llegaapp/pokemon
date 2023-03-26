import 'package:get/get.dart';

import '../../main.dart';
import 'form_field2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Input2 extends FormField2 {
  Input2({
    Key? key,
    double? width,
    String? label,
    String? value,
    ValueChanged? onChange,
    FormFieldSetter? onSaved,
    TextEditingController? controller,
    FocusNode? focusNode,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onFieldSubmitted,
    bool? enable,
    int? maxLength,
    TextInputType? textInputType,
    Widget? suffixIcon,
    bool obscureText = false,
  }) : super(
          key: key,
          builder: (state) {
            return TextFormField(
              keyboardType:
                  textInputType == null ? TextInputType.text : textInputType,
              maxLength: maxLength == null ? null : maxLength,
              readOnly: enable == null ? false : !enable,
              cursorColor: themeApp.colorPrimaryBlue,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                isDense: true,
                border: OutlineInputBorder(),
                counterText: '',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeApp.colorGenericIcon),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeApp.colorGenericIcon),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeApp.colorGenericIcon),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: label,
                labelStyle: themeApp.text16400Gray,
                errorStyle: TextStyle(fontSize: 9, height: 0.3),
                fillColor: themeApp.colorWhite,
                filled: true,
                hintStyle: themeApp.text16400Gray,
                suffixIcon: suffixIcon == null ? null : suffixIcon,
              ),
              controller: controller == null
                  ? TextEditingController(text: value)
                  : controller,
              onChanged: (v) {
                if (onChange != null) {
                  onChange(v);
                }
              },
              onSaved: (v) {
                if (onSaved != null) {
                  onSaved(v);
                }
              },
              onFieldSubmitted: (v) {
                if (onFieldSubmitted != null) {
                  onFieldSubmitted(v);
                }
              },
              validator: validator,
              inputFormatters: inputFormatters,
              focusNode: focusNode,
              obscureText: obscureText,
            );
          },
        );
}
