library multiselect;
import 'package:pokemon_heb/app/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class _TheState {}

var _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow(
      {Key? key,
      required this.onChange,
      required this.selected,
      required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: selected,
            onChanged: (x) {
              onChange(x!);
              _theState.notify();
            }),
        Text(text)
      ],
    );
  }
}
class DropDownMultiSelect extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final Function(List<String>) onChanged;
  final bool isDense;
  final bool enabled;
  final FormFieldValidator? validator;
  final InputDecoration? decoration;
  final String? whenEmpty;
  final Widget Function(List<String> selectedValues)? childBuilder;
  final Widget Function(String option)? menuItembuilder;

  const DropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.whenEmpty,
    this.validator,
    this.childBuilder,
    this.menuItembuilder,
    this.isDense = false,
    this.enabled = true,
    this.decoration,
  }) : super(key: key);
  @override
  _DropDownMultiSelectState createState() => _DropDownMultiSelectState();
}

class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      child: Stack(
        children: [
          _theState.rebuild(() => widget.childBuilder != null
              ? widget.childBuilder!(widget.selectedValues)
              : Align(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(widget.selectedValues.length > 0
                          ? widget.selectedValues
                              .reduce((a, b) => a + ' , ' + b)
                          : widget.whenEmpty ?? '')),
                  alignment: Alignment.centerLeft)),
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: widget.decoration != null
                  ? widget.decoration
                  : InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
              isDense: true,
              onChanged: widget.enabled ? (x) {} : null,
              value: null,
              validator: widget.validator,
              selectedItemBuilder: (context) {
                return widget.options
                    .map((e) => DropdownMenuItem(
                          child: Container(),
                        ))
                    .toList();
              },
              items: widget.options
                  .map((x) => DropdownMenuItem(
                        child: _theState.rebuild(() {
                          return widget.menuItembuilder != null
                              ? widget.menuItembuilder!(x)
                              : _SelectRow(
                                  selected: widget.selectedValues.contains(x),
                                  text: Utils.validateDay( x ),
                                  onChange: (isSelected) {
                                    if (isSelected) {
                                      var ns = widget.selectedValues;
                                      ns.add(x);
                                      widget.onChanged(ns);
                                    } else {
                                      var ns = widget.selectedValues;
                                      ns.remove(x);
                                      widget.onChanged(ns);
                                    }
                                  },
                                );
                        }),
                        value: x,
                        onTap: () {
                          if (widget.selectedValues.contains(x)) {
                            var ns = widget.selectedValues;
                            ns.remove(x);
                            widget.onChanged(ns);
                          } else {
                            var ns = widget.selectedValues;
                            ns.add(x);
                            widget.onChanged(ns);
                          }
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
