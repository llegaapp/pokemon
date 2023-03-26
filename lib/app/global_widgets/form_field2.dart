import 'package:flutter/material.dart';

class FormField2 extends StatefulWidget {
  final Function(FormField2State)? builder;

  FormField2({
    Key? key,
    this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormField2State();
}

class FormField2State extends State<FormField2> {
  didChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return widget.builder!(this);
  }
}
