import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:pokemon_heb/app/config/utils.dart';
import 'package:pokemon_heb/main.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderScheduleSupervisor extends StatelessWidget {
  final String dateCurrent;
  final String count;
  final String total;

  const HeaderScheduleSupervisor(
      {this.dateCurrent = '', this.count = '', this.total = ''});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Container(
      height: responsiveApp.boxContainerHeight + 30,
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
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: SvgPicture.asset(Constant.ICON_SCHEDULE),
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
                      rutasDelDiaStr,
                      style: themeApp.textSubheaderWhite,
                    ),
                    Text(
                      dateCurrent == '' ? Utils.getFechaHoy() : dateCurrent,
                      style: themeApp.textNoteWhite,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineThickness: 1.0,
                        dashColor: themeApp.colorBlue2Opacity,
                      ),
                    ),
                    Text(
                      mostrandoStr + count + de2Str + total + rutasStr,
                      style: themeApp.textNoteWhite,
                    ),
                   Expanded(child:  Text(
                     deslizarStr,
                     style: themeApp.textNoteWhite10,
                   ),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
