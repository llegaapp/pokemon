import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../config/constant.dart';
import '../../../../config/responsive_app.dart';
import '../../../../config/string_app.dart';
import '../../supervisor_controller.dart';
import 'package:pokemon_heb/main.dart';

class CardRouteTeamsAnaquelero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<SupervisorController>(
      builder: (_) => Padding(
        padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
        child: Container(
          decoration: BoxDecoration(
            color: themeApp.colorWhite,
            borderRadius: BorderRadius.all(
                Radius.circular(responsiveApp.containerRadius)),
            boxShadow: [
              BoxShadow(
                color: themeApp.colorShadowContainer,
                blurRadius: 7,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  //height: 90,
                  //width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 60,
                            width: 60,
                            child: SvgPicture.asset(Constant.ICON_ROUTE)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _.teamCurrent.route_show.toString(),
                          style: themeApp.textParagraph,
                        ),
                        Row(
                          children: [
                            Text(
                              _.teamCurrent.time_start.toString(),
                              style: themeApp.textParagraphSecondaryBlue,
                            ),
                            Text(
                              _.teamCurrent.time_start.toString() != ''
                                  ? asistenciaStr
                                  : '',
                              style: themeApp.textNote,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
