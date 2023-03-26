import '../../main.dart';
import 'package:flutter/material.dart';
import 'form_field2.dart';
import 'multiselect.dart';

class MultiSelect extends FormField2 {
  MultiSelect({
    Key? key,
    String? label,
    String? value,
    required Function(List<String>) onChanged,
    FormFieldSetter? onSaved,
    FormFieldValidator? validator,
    List<String> dataList = const [],
    List<String> selectedValues = const [],
  }) : super(
    key: key,
    builder: (FormField2State state) {
      return  DropDownMultiSelect(
        isDense: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          isDense: true,
          border: OutlineInputBorder(),
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeApp.colorGenericIcon),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeApp.colorGenericIcon),
            borderRadius: BorderRadius.circular(15.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeApp.colorGenericIcon),
            borderRadius: BorderRadius.circular(15.0),
          ),
          labelText: label,
          labelStyle: themeApp.textFloatinglabel,
          errorStyle: TextStyle( fontSize: 9, height: 0.3),
          alignLabelWithHint :false,
        ),
        onChanged:onChanged,
        whenEmpty: '',
        options: dataList ,
        selectedValues: selectedValues,
        validator: validator,
      );
    },
  );
}
