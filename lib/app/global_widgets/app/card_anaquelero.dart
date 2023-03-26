import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardAnaquelero extends StatelessWidget {
  final int? index;
  final String? id_base;
  final String? name_base;
  final String? id_back;
  final String? name_back;
  final VoidCallback? onPressed;
  CardAnaquelero(
      {this.index = 0,
      this.id_base,
      this.name_base,
      this.id_back,
      this.name_back,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    const double kDefaultPadding = 20.0;
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: themeApp.colorWhite,
            borderRadius: BorderRadius.all(
                Radius.circular(responsiveApp.containerRadius)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: SvgPicture.asset(Constant.ICON_HAPPY_FACE),
                ),
                Expanded(
                  child: name_base == '-' ||
                          name_base == '' ||
                          name_base == textVacant
                      ? name_back == '-' || name_back == ''
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                textVacant,
                                style: themeApp.textParagraphSecondaryOrange,
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                id_back! + ' ' + name_back!,
                                style: themeApp.textParagraphSecondaryBlue,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            id_base! + ' ' + name_base!,
                            style: themeApp.textParagraphSecondaryBlue,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
