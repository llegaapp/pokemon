import 'package:pokemon_heb/app/config/utils.dart';
import 'package:pokemon_heb/app/global_widgets/button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../config/string_app.dart';

class BotonSalir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Button2(
        title: titleSalirStr,
        color: themeApp.colorPrimaryBlue,
        onPressed: () async {
          Utils.userBlocked = false;
          Utils.userNotExist = false;
          Utils.userNotProfile = false;
          Get.back();
        });
  }
}
