import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constant.dart';
import '../../config/responsive_app.dart';

class StatusStore extends StatelessWidget {
  final String idstatus;
  final String hours;
  final String activity;
  final bool notification;

  const StatusStore(
      {required this.idstatus,
      required this.hours,
      this.activity = '',
      this.notification = false});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Padding(
      padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
      child: Container(
        decoration: BoxDecoration(
          color: themeApp.colorWhite,
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
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: idstatus == Constant.ID_STATUS_PENDIENTE
                          ? SvgPicture.asset(Constant.ICON_BLOCK)
                          : idstatus == Constant.ID_STATUS_ENCURSO
                              ? SvgPicture.asset(Constant.ICON_PROGRESS)
                              : SvgPicture.asset(Constant.ICON_CHECK),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        idstatus == Constant.ID_STATUS_PENDIENTE
                            ? Constant.NAME_STATUS_PENDIENTE
                            : idstatus == Constant.ID_STATUS_ENCURSO
                                ? Constant.NAME_STATUS_ENCURSO
                                : Constant.NAME_STATUS_TERMINADA,
                        style: idstatus == Constant.ID_STATUS_PENDIENTE
                            ? themeApp.textPendiente
                            : idstatus == Constant.ID_STATUS_ENCURSO
                                ? themeApp.textEnCurso
                                : themeApp.textTerminada),
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
                        hours,
                        style: themeApp.textParagraph,
                      ),
                      activity != ''
                          ? Container(
                              child: Row(
                                children: [
                                  Text(
                                    activity,
                                    style: themeApp.textParagraphSecondaryBlue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    activityStr,
                                    style: themeApp.textNoteNeutralGrey,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              notification
                  ? Container(
                      padding: EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(Constant.ICON_TRANSFER))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
