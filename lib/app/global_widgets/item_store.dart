import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemStore extends StatelessWidget {
  final int? index;
  final String? idStatus;
  final String? idRoute;
  final String? nameClient;
  final String? infoStore;
  final VoidCallback? onPressed;
  const ItemStore(
      {this.index,
      this.idStatus,
      this.idRoute,
      this.nameClient,
      this.infoStore,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 0);
    const double kDefaultPadding = 20.0;
    String iconStartus = '';
    if (idStatus != '') {
      if (idStatus == Constant.ID_STATUS_PENDIENTE)
        iconStartus = Constant.ICON_BLOCK;
      if (idStatus == Constant.ID_STATUS_ENCURSO)
        iconStartus = Constant.ICON_PROGRESS;
      if (idStatus == Constant.ID_STATUS_TERMINADA)
        iconStartus = Constant.ICON_CHECK;
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(Constant.ICON_STORE),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        idRoute.toString(),
                        style: themeApp.text10300,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kDefaultPadding / 2,
                        left: kDefaultPadding / 2,
                        right: kDefaultPadding / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameClient!,
                          style: themeApp.text18boldBlack600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          infoStore!,
                          style: themeApp.text16400Gray,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  idStatus != ''
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            child: SvgPicture.asset(
                              iconStartus,
                              width: 15,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
