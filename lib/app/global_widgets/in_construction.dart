import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../config/constant.dart';
import '../config/responsive_app.dart';
import '../config/string_app.dart';
import 'boton_salir.dart';

class InConstruction extends StatelessWidget {
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
              child: SvgPicture.asset(Constant.IMG_CONSTRUCTION)),
          Padding(
            padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        titleConstructionStr,
                        style: themeApp.textHeaderH2,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        subtitleConstructionStr,
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
