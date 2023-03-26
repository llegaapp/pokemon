import 'dart:convert';
import 'dart:io';
import 'package:pokemon_heb/app/config/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:pokemon_heb/main.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../data_source/prefered_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'string_app.dart';

class Utils {
  static var prefs = Get.put(PreferedController());
  static const MESES = [
    'N/A',
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  static const DIAS = [
    'N/A',
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  static bool userBlocked = false;
  static bool userNotExist = false;
  static bool userNotProfile = false;
  static bool userDayNotWorking = false;
  static String idClientCurrent = '0';
  static int countHomeInfo = 0;
  static bool withoutSending = false;
  static bool withoutSendingStores = false;
  static bool withoutSendingTeams = false;

  static Future<bool> hasInternet({bool sendMessage = false}) async {
    bool _hasInternet = await InternetConnectionChecker().hasConnection;
    if (!_hasInternet && sendMessage) {
      Get.snackbar(
        'Warning',
        'No hubo couminación con el servidor. Favor de volver a intentar',
        icon: Icon(Icons.error, color: Colors.red),
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
      );
    }
    return _hasInternet;
  }

  static void snackErrorMessagge(String title, String subtitle) {
    Get.snackbar(
      title,
      subtitle,
      icon: Icon(Icons.error, color: Colors.red),
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void setPreferedLogin(Map<String, dynamic> data) {
    prefs.token = data['token'].toString();
    prefs.usercode = data['usercode'].toString();
    prefs.deviceId = data['deviceId'].toString();
    prefs.grouper = data['grouper'].toString();
    prefs.expire = data['expire'].toString();
    prefs.userGuest = data['userGuest'] as bool;
    prefs.refresh();
  }

  static void setClearToken() {
    prefs.token = '';
    prefs.refresh();
  }

  static void setCurrentDate() {
    prefs.currentDate = getDateCurrent();
    prefs.refresh();
  }

  static String getFechaHoy() {
    final DateTime now = DateTime.now();
    return DIAS[now.weekday] +
        ' ' +
        now.day.toString() +
        ' de ' +
        MESES[now.month] +
        ', ' +
        now.year.toString();
  }

  static String getFechaStr(String dateStr) {
    var value = getFechaHoy();
    DateTime? now;
    if (dateStr != '') {
      now = DateTime.tryParse(dateStr.substring(0, 10));
      if (now != null) {
        value = DIAS[now.weekday] +
            ' ' +
            now.day.toString() +
            ' de ' +
            MESES[now.month] +
            ', ' +
            now.year.toString();
      }
    }
    return value;
  }

  static String getDateCurrentShow() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getDateCurrent() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getTimeCurrent() {
    var now = new DateTime.now();
    var formatter = new DateFormat('hh:MM:ss');
    String formattedTime = formatter.format(now);
    return formattedTime;
  }

  static String getDeviceDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getTimeZone() {
    DateTime dateTime = DateTime.now().toLocal();
    return dateTime.timeZoneOffset.inHours.toString();
  }

  static String getDateTimeToUTC() {
    DateTime dateTime = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(dateTime.toUtc());
    return formattedDate;
  }

  static String getChcekToDateTimeToUTC(String checkTime) {
    DateTime dateTime = DateTime.now();
    var formatterDate = DateFormat('yyyy-MM-dd');
    var formatterDateTime = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatterDate.format(dateTime);
    formattedDate = formattedDate + ' ' + checkTime + ':00';
    formattedDate =
        formatterDateTime.format(DateTime.parse(formattedDate).toUtc());
    return formattedDate;
  }

  static String getUTCToDateTimeLocal(String dateUTC, int timeZone) {
    DateTime dateTime = DateTime.parse(dateUTC).add(Duration(hours: timeZone));
    var formatter = DateFormat('HH:mm');
    String formattedDate = formatter.format(dateTime.toLocal());
    return formattedDate;
  }

  static String getDateCurrentPicture() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getTimeCurrentPicture() {
    var now = new DateTime.now();
    var formatter = new DateFormat('hh:MM');
    String formattedTime = formatter.format(now);
    return formattedTime;
  }

  static Widget getDialog(
      {String? title, textConfirm, VoidCallback? onPressed}) {
    {
      return Container(
          child: AlertDialog(
        contentPadding: EdgeInsets.all(5.0),
        content: Container(
          width: 300.0,
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.info_outline,
                      color: themeApp.colorPrimaryBlue,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    titleAppStr,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: themeApp.colorPrimaryBlue),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    cancelBtn(),
                    SizedBox(
                      width: 10.0,
                    ),
                    confirmBtn(textConfirm: textConfirm, onPressed: onPressed),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
  }

  static Widget confirmBtn({textConfirm, VoidCallback? onPressed}) {
    {
      return TextButton(
          onPressed: onPressed,
          child: Text(
            textConfirm,
            style: TextStyle(
                color: themeApp.colorPrimaryBlue,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ));
    }
  }

  static Widget cancelBtn() {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          "Cancelar",
          style: TextStyle(
              color: themeApp.colorPrimaryBlue,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ));
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  static String readTimestamp(int timestamp) {
    var format = new DateFormat('yyyy-MM-dd HH:mm:ss');
    var date =
        new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000).toUtc();
    var time = format.format(date);
    return time;
  }

  static bool expiredSesssion() {
    int diff = -1;
    //Utils.prefs.expire = '164322527310817';
    if (Utils.prefs.expire != '') {
      var date = Utils.readTimestamp(int.parse(Utils.prefs.expire));
      diff = DateTime.parse(date).difference(DateTime.now()).inMinutes;
    }
    return diff < 0;
  }

  static initParametros() {
    Utils.userBlocked = false;
    Utils.userNotExist = false;
    Utils.userNotProfile = false;
    Utils.userDayNotWorking = false;
    if (Utils.prefs.currentDate.isEmpty) {
      Utils.prefs.currentDate = Utils.getDateCurrent();
    }
  }

  static validateDay(String _value) {
    if (_value == 'L')
      return '[L] Lunes';
    else if (_value == 'M')
      return '[M] Martes';
    else if (_value == 'W')
      return '[W] Mirérccoles';
    else if (_value == 'J')
      return '[J] Jueves';
    else if (_value == 'V')
      return '[V] Viernes';
    else if (_value == 'S')
      return '[S] Sábado';
    else if (_value == 'D')
      return '[D] Domingo';
    else
      return '';
  }

  static Future<File?> seleccionaImagen(int Op) async {
    PickedFile pickedFile;
    File? file;
    if (Op == 1) {
      try {
        pickedFile = (await ImagePicker().getImage(
          source: ImageSource.camera,
          maxHeight: 500,
          maxWidth: 500,
          imageQuality: 50,
        ))!;
      } catch (e) {
        return null;
      }
    } else {
      try {
        pickedFile = (await ImagePicker().getImage(
          source: ImageSource.gallery,
          maxHeight: 500,
          maxWidth: 500,
          imageQuality: 50,
        ))!;
      } catch (e) {
        return null;
      }
    }
    if (pickedFile == null) return file;
    return File(pickedFile.path);
  }

  static String getFormatoImage(String cad) {
    switch (cad) {
      case Constant.FORMAT_PNG:
        return Constant.FORMAT_IMAGE_PNG;
        break;
      case Constant.FORMAT_JPG:
        return Constant.FORMAT_IMAGE_JPG;
        break;
      case Constant.FORMAT_JPEG:
        return Constant.FORMAT_IMAGE_JPEG;
        break;
      case Constant.FORMAT_GIF:
        return Constant.FORMAT_IMAGE_GIF;
        break;
      case Constant.FORMAT_BMP:
        return Constant.FORMAT_IMAGE_BMP;
        break;
      case Constant.FORMAT_RAW:
        return Constant.FORMAT_IMAGE_RAW;
        break;
      default:
        return Constant.FORMAT_IMAGE_JPG;
    }
  }

  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get localFile async {
    final path = await localPath;
    return File('$path/log_gestion.txt');
  }

  static Future<File> writeLog(String content) async {
    final file = await localFile;

    return file.writeAsString('$content');
  }

  static Future<String> selBase64Image() async {
    String _b64Image = '';
    try {
      File? fileImage = (await Utils.seleccionaImagen(1))!;
      if (fileImage != null) {
        String thumbnail = basename(fileImage.path);
        final bytes = fileImage.readAsBytesSync();
        var arr = thumbnail.split('.');
        String base64Image = base64Encode(bytes);
        if (arr.length >= 2) {
          var formato = Utils.getFormatoImage(arr[1]);
          _b64Image = formato + base64Image;
        }
      }
      return _b64Image;
    } catch (e) {
      return _b64Image;
    }
  }

  static int getDistanceCoordinates(String latA, longA, latB, longB) {
    double startLatitude = double.tryParse(latA) ?? 0.0;
    double startLongitude = double.tryParse(longA) ?? 0.0;
    double endLatitude = double.tryParse(latB) ?? 0.0;
    double endLongitude = double.tryParse(longB) ?? 0.0;
    if (startLatitude == 0.0 ||
        startLongitude == 0.0 ||
        endLatitude == 0.0 ||
        endLongitude == 0.0) {
      return -1;
    } else {
      return Geolocator.distanceBetween(
              startLatitude, startLongitude, endLatitude, endLongitude)
          .round();
    }
  }

  static bool validateGeofence(
      String latA, longA, latB, longB, int mtsAllowed) {
    int distance = getDistanceCoordinates(latA, longA, latB, longB);
    if (distance == -1) {
      return false;
    } else {
      return distance <= mtsAllowed;
    }
  }

  static String birthDateValidator(String value) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    String str1 = value;
    List<String> str2 = str1.split('/');
    String day = str2.isNotEmpty ? str2[0] : '';
    String month = str2.length > 1 ? str2[1] : '';
    String year = str2.length > 2 ? str2[2] : '';
    if (value.isEmpty) {
      return dateBirthEmptyStr;
    } else if (int.parse(day) >= 32) {
      return validaDayStr;
    } else if (int.parse(month) > 13) {
      return validaMonthStr;
    } else if ((int.parse(year) > int.parse(formatted)) ||
        (int.parse(year) < 1900)) {
      return validaYearStr;
    } else {
      if (!esFechaValida(year: year, month: month, day: day))
        return validaDateBirthStr;
    }
    return '';
  }

  static bool esFechaValida({required String year, month, day}) {
    bool _result = false;
    if (double.parse(year) >= 1900) {
      bool _esBisiesto = esBisiesto(double.parse(year));
      int daysMonth;
      switch (int.parse(month)) {
        case 1:
          daysMonth = 31;
          break;
        case 2:
          if (_esBisiesto)
            daysMonth = 29;
          else
            daysMonth = 28;
          break;
        case 3:
          daysMonth = 31;
          break;
        case 4:
          daysMonth = 30;
          break;
        case 5:
          daysMonth = 31;
          break;
        case 6:
          daysMonth = 30;
          break;
        case 7:
          daysMonth = 31;
          break;
        case 8:
          daysMonth = 31;
          break;
        case 9:
          daysMonth = 30;
          break;
        case 10:
          daysMonth = 31;
          break;
        case 11:
          daysMonth = 30;
          break;
        case 12:
          daysMonth = 31;
          break;
        default:
          daysMonth = 0;
      }
      _result = int.parse(day) <= daysMonth;
    }
    return _result;
  }

  static bool esBisiesto(double anio) {
    return anio % 4 == 0 && (anio % 100 != 0 || anio % 400 == 0);
  }

  static bool isSameDay() {
    int diffDays = -1;
    try {
      diffDays = DateTime.now()
          .difference(DateTime.parse(Utils.prefs.currentDate))
          .inDays;
    } catch (error) {}
    return (diffDays == 0);
  }

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
