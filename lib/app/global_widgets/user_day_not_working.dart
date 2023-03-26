import 'package:flutter/material.dart';
import '../../main.dart';
import '../config/constant.dart';
import '../config/responsive_app.dart';
import 'package:flutter_svg/svg.dart';
import '../config/string_app.dart';
import 'boton_salir.dart';

class UserDayNotWorking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Constant.LOGO_GTP,
                height: responsiveApp.kHeightLogo,
              )),
          Align(
              alignment: Alignment.center,
              child: Text(
                titleAccesoStr,
                style: themeApp.textHeaderH1,
              )),
          Padding(
            padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: responsiveApp.edgeInsetsApp?.allMediumEdgeInsets,
              decoration: BoxDecoration(
                border: Border.all(color: themeApp.colorGenericIcon),
                borderRadius: BorderRadius.all(
                    Radius.circular(responsiveApp.containerRadius)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(Constant.ICON_NOTWORKING)),
                  SizedBox(
                    height: 40.0,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        unwTitle,
                        style: themeApp.textHeaderH2,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        unwSubtitle,
                        style: themeApp.textParagraph,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
