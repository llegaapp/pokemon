import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/constant.dart';
import '../config/responsive_app.dart';
import '../config/string_app.dart';
import 'button2.dart';

class MsgFakeProblemApp extends StatelessWidget {
  final VoidCallback? onPressed;

  const MsgFakeProblemApp({this.onPressed});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Constant.LOGO_GTP,
                  height: responsiveApp.kHeightLogo,
                )),
            Align(
                alignment: Alignment.center,
                child: Text(
                  unwProblem,
                  style: themeApp.textHeaderH1,
                )),
            Padding(
              padding:
                  responsiveApp.edgeInsetsApp!.onlySmallLeftRightEdgeInsets,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: responsiveApp.edgeInsetsApp?.allMediumEdgeInsets,
                decoration: BoxDecoration(
                  border: Border.all(color: themeApp.colorGenericIcon),
                  borderRadius: BorderRadius.all(
                      Radius.circular(responsiveApp.containerRadius)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(Constant.ICON_WARNING)),
                    SizedBox(
                      height: 15.0,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          unwTitleFakeProblem,
                          style: themeApp.textHeaderH2,
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          unwSubtitleFakeProblem,
                          style: themeApp.textParagraph,
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    responsiveApp.edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                child: Button2(
                    title: reintentarStr,
                    color: themeApp.colorPrimaryBlue,
                    onPressed: onPressed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
