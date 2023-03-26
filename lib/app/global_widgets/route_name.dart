import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RouteName extends StatelessWidget {
  final String? text;

  const RouteName({
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 10);
    const double kDefaultPadding = 35.0;
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: GestureDetector(
        child: Container(
          height: 70,
          padding: const EdgeInsets.only(top: 10),
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
          child: BootstrapContainer(fluid: true, children: [
            BootstrapRow(
              children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-3',
                  child: SvgPicture.asset(
                    Constant.ICON_ROUTE,
                    width: 50,
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-9',
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                    child:
                    Text(
                      overflow: TextOverflow.ellipsis,
                      text!,
                      style: themeApp.text16400Black,
                    ),
                  )
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
