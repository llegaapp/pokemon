import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final String? tip;
  final EdgeInsets? padding;
  final Color? iconColor;
  final Color? background;
  final TextStyle? style;

  Button1(
      {this.label,
      this.iconColor,
      this.iconData,
      this.onPressed,
      this.tip,
      this.padding,
      this.background,
      this.style});

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (iconData != null) {
      if (label == null) {
        result = IconButton(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: onPressed,
        );
      } else {
        result = ElevatedButton.icon(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          label: Text(this.label!),
          onPressed: onPressed,
        );
      }
    } else {
      result = ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(this.background),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(this.padding),
          fixedSize: MaterialStateProperty.all<Size>(const Size(240, 50)),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
        ),
        child: Text(
          this.label ?? '',
          style: this.style,
        ),
        onPressed: onPressed,
      );
    }
    if (this.padding != null) {
      result = Container(padding: this.padding, child: result);
    }

    if (tip != null) {
      result = Tooltip(
        child: result,
        message: tip!,
      );
    }
    return result;
  }
}
