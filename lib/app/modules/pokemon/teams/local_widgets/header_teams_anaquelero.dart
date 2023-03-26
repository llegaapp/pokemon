import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../main.dart';
import '../../../../config/constant.dart';
import '../../../../config/responsive_app.dart';
import '../../supervisor_controller.dart';

class HeaderTeamsAnaquelero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<SupervisorController>(
      builder: (_) => Container(
        //height: responsiveApp.boxContainerHeight,
        decoration: BoxDecoration(
          color: themeApp.colorPrimaryBlue,
          borderRadius:
              BorderRadius.all(Radius.circular(responsiveApp.containerRadius)),
          boxShadow: [
            BoxShadow(
              color: themeApp.colorShadowContainer,
              blurRadius: 7,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                child: SvgPicture.asset(Constant.ICON_HAPPY_FACE),
              ),
              Expanded(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _.teamCurrent.name_anaquelero.toString(),
                        style: themeApp.textSubheaderWhite,
                      ),
                      Text(
                        _.teamCurrent.profile.toString(),
                        style: themeApp.textNoteWhite,
                      ),
                      Text(
                        _.teamCurrent.active_from.toString(),
                        style: themeApp.textNoteWhite,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
