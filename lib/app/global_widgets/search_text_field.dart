import '../../main.dart';
import '../config/string_app.dart';
import 'form_field2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SearchTextField extends FormField2 {
  SearchTextField({
    Key? key,
    double? width,
    String? label,
    String? value,
    ValueChanged? onChange,
    FormFieldSetter? onSaved,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onSubmitted,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    bool? enable,
  }) : super(
    key: key,
    builder: (state) {
      return TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (v) {
          if (onSubmitted != null) {
            onSubmitted(v);
          }
        },
        decoration: InputDecoration(
            hintText: buscarStr,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
            border: OutlineInputBorder(),
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themeApp.colorGenericIcon),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themeApp.colorGenericIcon),
              borderRadius: BorderRadius.circular(15.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themeApp.colorGenericIcon),
              borderRadius: BorderRadius.circular(15.0),
            ),
            suffixIcon: InkWell(
              child: Icon(
                Icons.search_off_outlined,
                size: 16,
                color: themeApp.colorGenericIcon,
              ),
            )),
      );
    },
  );
}
