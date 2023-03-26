import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoAddress extends StatelessWidget {
  final String? text;

  const InfoAddress({
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 10);
    const double kDefaultPadding = 0.0;
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding, right: kDefaultPadding, top: 20),
      child: GestureDetector(
        child: Container(
          height: 100,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: themeApp.colorWhite,
            border: Border.all(
              color: themeApp.colorGenericIcon,
              width: 1, //                   <--- border width here
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(responsiveApp.containerRadius)),
          ),
          child: BootstrapContainer(fluid: true, children: [
            BootstrapRow(
              children: <BootstrapCol>[
                BootstrapCol(
                    sizes: 'col-3',
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 15,),
                        SvgPicture.asset(
                          Constant.ICON_MAP,
                          width: 50,
                        ),
                      ],
                    )),
                BootstrapCol(
                    sizes: 'col-9',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        text!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: themeApp.text16400Black,
                      ),
                    )),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
