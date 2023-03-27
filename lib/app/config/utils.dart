
import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data_source/prefered_controller.dart';
import 'string_app.dart';

class Utils {
  static var prefs = Get.put(PreferedController());

  static void syncDialog(String subtitle) {
    Get.dialog(
        barrierDismissible: false,
        Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding:
                EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10, top: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 40, // 15%
                          child: Image.asset(
                            Constant.ICON_POKE_BALL,
                            width: 50,
                          ),
                        ),
                        Flexible(
                          flex: 60, // 15%
                          child: Column(
                            children: [
                              Text(
                                sincronizandoStr,
                                style: themeApp.text20boldBlack,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                subtitle,
                                style: themeApp.text16400Gray,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  static Color pokemonColor(String _type) {
    String color = '0xff000000';
    switch (_type) {
      case "normal":
        color = '0xff808080'; //gray
        break;
      case "fighting":
        color = '0xff8b0000'; // Dark Red
        break;
      case "flying":
        color = '0xffD3D3D3'; //White
        break;
      case "poison":
        color = '0xff800080'; //Purple
        break;
      case "ground":
        color = '0xfff5f5dc'; //Beige
        break;
      case "rock":
        color = '0xff654321'; //Brown
        break;
      case "bug":
        color = '0xff7fff00'; //Chartreuse
        break;
      case "ghost":
        color = '0xff301934'; // Dark Purple
        break;
      case "steel":
        color = '0xffa9a9a9'; // Dark Grey
        break;
      case "fire":
        color = '0xffff0000'; // red
        break;
      case "water":
        color = '0xff0000ff'; // blue
        break;
      case "grass":
        color = '0xff008000'; // Green
        break;
      case "electric":
        color = '0xffffff00'; // yellow
        break;
      case "psychic":
        color = '0xffff00ff'; // Magenta
        break;
      case "ice":
        color = '0xff00ffff'; // Cyan
        break;
      case "dragon":
        color = '0xff000080'; // Navy
        break;
      case "dark":
        color = '0xff000000'; // black
        break;
      case "fairy":
        color = '0xfffadadd'; // Pale Pink
        break;
      case "unknown":
        color = '0xffadd8e6'; // light blue
        break;
      case "shadow":
        color = '0xffa9a9a9'; // dark gray
        break;

      default:
        color = '0xff000000'; //
    }
    Color statusColor = Color(int.parse(color));

    return statusColor;
  }
}
