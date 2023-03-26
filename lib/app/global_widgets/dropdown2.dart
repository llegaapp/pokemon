import '../../main.dart';
import 'package:flutter/material.dart';
import 'form_field2.dart';


class Select<T> extends FormField2 {
  Select({
    Key? key,
    String? label,
    String? value,
    ValueChanged? onChange,
    FormFieldSetter? onSaved,
    FormFieldValidator? validator,
    List<DropdownMenuItem> dataList = const [],
  }) : super(
    key: key,
    builder: (FormField2State state) {
      return DropdownButtonFormField<dynamic>(
        isDense: false,
        menuMaxHeight:200,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only( left: 10, right: 10),
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
          labelStyle: themeApp.text16400Gray,
          errorStyle: TextStyle( fontSize: 9, height: 0.3),
          fillColor: themeApp.colorWhite,
          filled: true,
        ),
        value: value!=''? value : null,
        items: dataList ,
        onChanged: (v) {
          value = v;
          if (onChange != null) {
            onChange(v);
          }
          state.didChange();
        },
        onSaved: (v) {
          if (onSaved != null) {
            onSaved(v);
          }
        },
        validator: validator,
      );
    },
  );
}
