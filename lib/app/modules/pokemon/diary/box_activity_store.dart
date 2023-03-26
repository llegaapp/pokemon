import 'package:pokemon_heb/app/config/hexcolor.dart';
import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:pokemon_heb/app/config/theme_app.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../config/constant.dart';
import '../../../config/responsive_app.dart';
import '../pokemon_controller.dart';

class BoxActivityStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<PokemonController>(
      builder: (_) => Padding(
        padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: themeApp.colorGenericBox.withOpacity(0.5),
          ),
          child: _.itemClientDetailSup!.comida != null &&
                  _.itemClientDetailSup!.comida!.toeat == true
              ? activityToEat(_)
              : Row(
                  children: [
                    // Check-in
                    itemActivity(
                      title: textCheckin,
                      hours: _.itemClientDetailSup!.checkin == null
                          ? '-'
                          : _.itemClientDetailSup!.checkin!.time_start
                              .toString(),
                      score: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _.itemClientDetailSup!.checkin == null
                                ? '-'
                                : _.itemClientDetailSup!.checkin!.distance
                                    .toString(),
                            style: themeApp.textParagraph,
                          ),
                          _.itemClientDetailSup!.checkin != null
                              ? Container(
                                  height: 15,
                                  width: 15,
                                  child:
                                      _.itemClientDetailSup!.checkin!.color ==
                                              ''
                                          ? Container()
                                          : CircleAvatar(
                                              backgroundColor: HexColor(_
                                                  .itemClientDetailSup!
                                                  .checkin!
                                                  .color
                                                  .toString()),
                                              radius: 20,
                                            ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    // Comida
                    itemActivity(
                        title: textComida,
                        hours: _.itemClientDetailSup!.comida == null
                            ? '-'
                            : _.itemClientDetailSup!.comida!.time_start ?? '',
                        score: Text(
                          _.itemClientDetailSup!.comida == null
                              ? '-'
                              : _.itemClientDetailSup!.comida!.time_end ==
                                      'null'
                                  ? '-'
                                  : _.itemClientDetailSup!.comida!.time_end
                                      .toString(),
                        )),
                    // Check-out
                    itemActivity(
                      title: textCheckout,
                      hours: _.itemClientDetailSup!.checkout == null
                          ? '-'
                          : _.itemClientDetailSup!.checkout!.time_start
                              .toString(),
                      score: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _.itemClientDetailSup!.checkout == null
                                ? '-'
                                : _.itemClientDetailSup!.checkout!.distance
                                    .toString(),
                            style: themeApp.textParagraph,
                          ),
                          _.itemClientDetailSup!.checkout != null
                              ? Container(
                                  height: 15,
                                  width: 15,
                                  child:
                                      _.itemClientDetailSup!.checkout!.color ==
                                              ''
                                          ? Container()
                                          : CircleAvatar(
                                              backgroundColor: HexColor(_
                                                  .itemClientDetailSup!
                                                  .checkout!
                                                  .color
                                                  .toString()),
                                              radius: 20,
                                            ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget activityToEat(PokemonController _) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: SvgPicture.asset(Constant.ICON_POKE_BALL),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Text(
              textComida,
              style: themeApp.textParagraph,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            beginStr,
                            style: themeApp.textNoteNeutralGrey,
                          ),
                          Text(
                            _.itemClientDetailSup!.comida!.time_start
                                .toString(),
                            style: themeApp.textNote,
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            currentStr,
                            style: themeApp.textNoteNeutralGrey,
                          ),
                          Text(
                            _.itemClientDetailSup!.comida!.current.toString(),
                            style: themeApp.textNote,
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            endStr,
                            style: themeApp.textNoteNeutralGrey,
                          ),
                          Text(
                            '-',
                            style: themeApp.textNote,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class itemActivity extends StatelessWidget {
  final String title;
  final String hours;
  final Widget score;

  const itemActivity(
      {required this.title, required this.hours, required this.score});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: Text(
                    title,
                    style: themeApp.textNote,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: Text(
                    hours,
                    style: themeApp.textSubheader,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: score,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
