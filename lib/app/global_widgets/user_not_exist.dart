import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';
import '../config/constant.dart';
import '../config/responsive_app.dart';
import '../config/string_app.dart';
import 'boton_salir.dart';

class UserNotExist extends StatelessWidget {
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
              padding: responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
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
                      child: SvgPicture.asset(Constant.ICON_LOCK)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        uneTitle,
                        style: themeApp.textHeaderH2,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        uneSubtitle,
                        style: themeApp.textParagraph,
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        ubHelp,
                        style: themeApp.textParagraph,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  responsiveApp.edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
              child: BotonSalir(),
            ),
          ),
        ],
      ),
    );
  }
}
