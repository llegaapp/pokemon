import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../config/constant.dart';
import '../config/string_app.dart';

class EmptyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: BootstrapContainer(fluid: true, children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12',
              child: Container(
                padding: new EdgeInsets.all(0.0),
                child: SizedBox(
                  width: 70,
                  child: SvgPicture.asset(
                    Constant.ICON_GROUP_GROUPS,
                    color: themeApp.colorBlack,
                  ),
                ),
              ),
            ),
            BootstrapCol(
              sizes: 'col-12',
              child: Text(
                sinResultadosStr,
                textAlign: TextAlign.center,
                style: themeApp.text20boldBlack,
              ),
            ),
            BootstrapCol(
              sizes: 'col-12',
              child: Text(
                noRegistrosStr,
                textAlign: TextAlign.center,
                style: themeApp.text16boldBlack400,
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
