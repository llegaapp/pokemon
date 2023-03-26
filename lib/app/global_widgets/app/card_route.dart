import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardRoute extends StatelessWidget {
  final String? name;
  final bool? selected;
  //final VoidCallback onPressedCard;
  final VoidCallback? onPressedIcon;

  const CardRoute(
      {this.name,
      this.selected = false,
      this.onPressedIcon });

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
        onTap: () {}, //onPressedCard,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: themeApp.colorGenericBox,
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
                  child: SvgPicture.asset(Constant.ICON_ROUTE),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      name!,
                      style: themeApp.textSubheader,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                    height: 40,
                    width: 40,
                    child: GestureDetector(
                      onTap: onPressedIcon,
                      child: selected == true
                          ? SvgPicture.asset(Constant.ICON_CHEVRON_UP)
                          : SvgPicture.asset(Constant.ICON_CHEVRON_DOWN),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
