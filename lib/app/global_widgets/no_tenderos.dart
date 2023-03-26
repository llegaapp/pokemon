import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../config/constant.dart';
import '../config/string_app.dart';
import '../../main.dart';

class NoTenderos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 200,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SvgPicture.asset(
                  Constant.ICON_HAPPY_FACE,
                  width: 80,
                  color: themeApp.colorGenericIcon,
                ),
                SizedBox(height: 10),
                Text(
                  noHayTenderosStr,
                  style: themeApp.text18boldBlack600,
                ),
                SizedBox(height: 5),
                Text(
                  paraMostrarStr,
                  style: themeApp.text16400Gray,
                ),
              ],
            )));
  }
}
