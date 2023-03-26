import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardStore extends StatelessWidget {
  final int? index;
  final String? idStatus;
  final String? nameStatus;
  final String? name;
  final String? timeShow;
  final String? comment;
  final VoidCallback? onPressed;
  final String? icon;
  const CardStore(
      {this.index,
      this.idStatus,
      this.nameStatus,
      this.name,
      this.timeShow,
      this.comment = '',
      this.onPressed,
      this.icon});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    const double kDefaultPadding = 20.0;
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding - 5,
      ),
      child: GestureDetector(
        onTap: onPressed,
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
                  height: 90,
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(idStatus != null
                            ? idStatus == Constant.ID_STATUS_PENDIENTE
                                ? Constant.ICON_BLOCK
                                : idStatus == Constant.ID_STATUS_ENCURSO
                                    ? Constant.ICON_PROGRESS
                                    : Constant.ICON_CHECK
                            : Constant.ICON_STORE),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          idStatus != null
                              ? idStatus == Constant.ID_STATUS_PENDIENTE
                                  ? Constant.NAME_STATUS_PENDIENTE
                                  : idStatus == Constant.ID_STATUS_ENCURSO
                                      ? Constant.NAME_STATUS_ENCURSO
                                      : Constant.NAME_STATUS_TERMINADA
                              : nameStatus!,
                          style: idStatus == Constant.ID_STATUS_PENDIENTE
                              ? themeApp.textPendiente
                              : idStatus == Constant.ID_STATUS_ENCURSO
                                  ? themeApp.textEnCurso
                                  : themeApp.textTerminada),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding / 2, right: kDefaultPadding / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: themeApp.text18boldBlack600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          timeShow!,
                          style: themeApp.textParagraph,
                        ),
                      ],
                    ),
                  ),
                )),
                comment!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(Constant.ICON_COMMENT),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
