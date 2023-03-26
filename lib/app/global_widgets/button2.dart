import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {
  final String? title;
  final Color? color;
  final VoidCallback? onPressed;

  const Button2({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Container(
      width: double.infinity,
      height: responsiveApp.buttonHeigth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsiveApp.buttonRadius),
          ),
          primary: color,
        ),
        child: Text(
          title!,
          style: themeApp.textButton,
        ),
      ),
    );
  }
}
