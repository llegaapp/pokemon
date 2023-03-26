import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemTeam extends StatelessWidget {
  final int? index;
  final int? teamRadioVal;
  final String? idAnaquelero;
  final String? nameAnaquelero;
  final String? routeSow;
  final VoidCallback? onPressed;
  const ItemTeam(
      {this.index,
      this.teamRadioVal,
      this.idAnaquelero,
      this.nameAnaquelero,
      this.routeSow,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 0);
    const double kDefaultPadding = 20.0;
    String iconStartus = '';
    if (teamRadioVal != 0) {
      if (teamRadioVal == -1) iconStartus = Constant.ICON_GROUP_GROUPS186;
      if (teamRadioVal == 1) iconStartus = Constant.ICON_GROUP_GROUPS219;
    }

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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Container(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: SvgPicture.asset(Constant.ICON_HAPPY_FACE),
                          ),
                          Text(
                            idAnaquelero.toString(),
                            style: themeApp.text10300,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Container(
                      //height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kDefaultPadding / 2,
                            right: kDefaultPadding / 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameAnaquelero!,
                              style: themeApp.text18boldBlack600,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              routeSow!,
                              style: themeApp.text16400Gray,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      teamRadioVal != 0
                          ? Container(
                              child: SvgPicture.asset(
                                iconStartus,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
