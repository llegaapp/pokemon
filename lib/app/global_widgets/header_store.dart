import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderStore extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderStore({this.title = '', this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 10);
    return Container(
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
          child: BootstrapContainer(fluid: true, children: [
            BootstrapRow(
              children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-3',
                  child: Column(
                    // Vertically center the widget inside the column
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        child: SvgPicture.asset(Constant.ICON_STORE),
                      ),
                    ],
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-9',
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: themeApp.textSubheaderWhite,
                        ),
                        Text(
                          subtitle,
                          style: themeApp.textNoteWhite,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
