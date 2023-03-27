import 'package:flutter/material.dart';

class ThemeApp {
  Color colorGrey = Color.fromARGB(255, 209, 210, 205);
  Color colorWhite = white;
  Color colorBlack = Colors.black;
  Color colorNeutralWhite = Color(0xffffffff);
  Color colorPrimaryBlue = Color(0xff004c97);
  Color colorSecondaryBlue = Color(0xff009fdf);
  Color colorSecondaryBlueOpacy25 = Color(0xff009fdf).withOpacity(0.25);

  Color colorGenericIcon = Color(0xffbcdcf2);
  Color colorButtonDisable = Color(0xffced2d8);
  Color colorShadowContainer = Color(0xffbcdcf2).withOpacity(0.5);
  Color colorGenericBox = Color(0xffe4f4ff);
  Color colorBlue2Opacity = Color(0xffE4F4FF).withOpacity(0.5);
  Color colorNeutralBlack = Color(0xff000000);
  Color colorBackGround = Color(0xFFf7fafc);
  Color colorGray = Color(0xFF83899C);
  Color colorNeutralGrey = Color(0xff808080);
  Color colorSecundaryGreen = Color(0xFF03C395);
  Color colorFooter = Color(0xff808080);

  Color colorCompanion = Color(0xff7dc244);

  Color colorPrimary = Color(0xffd9d9d9);
  Color colorPrimaryRed = Color(0xffde002b);
  Color colorPrimaryGeen = Color(0xff40a6ac);

  late Color colorBackground;
  late Color colorBackgroundGray;
  late Color colorDefaultText;
  late Color colorBackgroundDialog;
  late MaterialColor primarySwatch;
  List<Color> colorsGradient = [];
  late TextStyle text10white;
  late TextStyle text12bold;
  TextStyle text12white = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  // App Gestion
  TextStyle? textHeaderH1;
  TextStyle? textHeaderH2;
  TextStyle? textHeaderH2SecondaryBlue;
  TextStyle? textSubheader;
  TextStyle? textSubheaderWhite;
  TextStyle textParagraph = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  TextStyle? textFloatinglabelError;
  TextStyle textParagraph14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  TextStyle? textParagraphSecondaryBlue;
  TextStyle? textParagraphSecondaryOrange;
  TextStyle? textButton;
  TextStyle? textButtonlink;
  TextStyle? textCTAButtonlink;
  TextStyle? textCTAlink;
  TextStyle? textLink;
  TextStyle? textNote;
  TextStyle? textNoteWhite;
  TextStyle? textNoteWhite10;
  TextStyle? textNoteSecondaryBlue;
  TextStyle? textNoteNeutralGrey;
  TextStyle? textLabel;
  TextStyle? textPlaceholder;
  TextStyle? textFloatinglabel;
  TextStyle? textPendiente;
  TextStyle? textEnCurso;
  TextStyle? textTerminada;
  TextStyle? textDisabled;
  //

  TextStyle? text10300;
  TextStyle? text12grey;
  TextStyle? text14;
  TextStyle? text14Disabled;
  TextStyle? text14Italic;
  TextStyle? text14primary;
  TextStyle? text14purple;
  TextStyle? text14grey;
  TextStyle? text14bold;
  TextStyle? text14boldPimary;
  TextStyle? text14boldWhite;
  TextStyle? text14boldWhiteShadow;

  TextStyle? text14Companyon;
  TextStyle? text16;
  TextStyle? text16400Gray;
  TextStyle? text16400Black;
  TextStyle? text16400Blue;
  TextStyle? text16bold;
  TextStyle? text16400;
  TextStyle? text16boldWhite;
  TextStyle? text16boldBlack;
  TextStyle? text18boldPrimary;
  TextStyle? text18bold;
  TextStyle? text16boldBlack400;
  TextStyle? text18boldWhite;

  TextStyle? text18boldBlack600;
  TextStyle? text20;
  TextStyle? text20700Black;
  TextStyle? text20bold;
  TextStyle? text20boldBlack;

  TextStyle? text20boldPrimary;
  TextStyle? text20boldWhite;
  TextStyle? text20negative;
  TextStyle? text22primaryShadow;

  TextStyle? textHeader;
  TextStyle? text14boldBlack400;
  TextStyle? text12dWhite;
  TextStyle? text14Black;
  TextStyle? text12Red;
  TextStyle? text12RedBold;

  init() {
    colorsGradient = [Colors.blue, white];
    colorBackgroundDialog = _backgroundColor;
    colorBackground = _backgroundColor;
    colorBackgroundGray = Colors.black.withOpacity(0.01);
    colorDefaultText = _backgroundDarkColor;
    primarySwatch = white;

    // App Gestion
    AppBarTheme(
      color: Colors.white,
    );

    textHeader = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'TitilliumWeb Web');

    textHeaderH1 = TextStyle(
      color: Color(0xFF004C97),
      fontWeight: FontWeight.w700,
      fontSize: 24,
    );

    textHeaderH2 = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
    textFloatinglabelError = TextStyle(
      color: colorPrimaryRed,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );

    textHeaderH2SecondaryBlue = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 20, color: colorSecondaryBlue);

    textSubheader = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );

    textSubheaderWhite = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );

    textParagraph = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    textParagraphSecondaryBlue = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xFF009fdf),
    );

    textParagraphSecondaryOrange = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xFFff963a),
    );

    textButton = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

    textButtonlink = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

    textCTAButtonlink = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: colorSecondaryBlue,
    );

    textCTAlink = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: colorNeutralGrey,
      decoration: TextDecoration.underline,
    );

    textLink = TextStyle(
      color: Color(0xFF004C97),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    textNote = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
    );

    textNoteNeutralGrey = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Color(0xFF808080),
    );

    textNoteWhite = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 14,
    );
    textNoteWhite10 = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 10,
    );

    textNoteSecondaryBlue = TextStyle(
      color: colorSecondaryBlue,
      fontWeight: FontWeight.w300,
      fontSize: 14,
    );

    textLabel = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    textPlaceholder = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    textFloatinglabel = TextStyle(
      color: Color(0xFF004C97),
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );

    textPendiente = TextStyle(
      color: Color(0xFFFF963A),
      fontWeight: FontWeight.w300,
      fontSize: 10,
      fontFamily: 'Poppins',
    );

    textEnCurso = TextStyle(
      color: Color(0xFF009FDF),
      fontWeight: FontWeight.w300,
      fontSize: 10,
      fontFamily: 'Poppins',
    );

    textTerminada = TextStyle(
      color: Color(0xFF03C395),
      fontWeight: FontWeight.w300,
      fontSize: 10,
      fontFamily: 'Poppins',
    );

    textDisabled = TextStyle(
      color: Color(0xFF808080).withOpacity(0.50),
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    text10300 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w300,
        fontSize: 10,
        fontFamily: 'Poppins');
    text14boldBlack400 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: 'TitilliumWeb Web');
    text16400Gray = TextStyle(
      color: colorGray,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    text16400Black = TextStyle(
      color: colorBlack,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    text16400Blue = TextStyle(
      color: colorSecondaryBlue,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    text18boldBlack600 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        fontFamily: 'TitilliumWeb Web');
    text16boldBlack400 = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        fontFamily: 'TitilliumWeb Web');

    text20700Black = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'TitilliumWeb Web');
    text20boldBlack = TextStyle(
        color: colorBlack,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: 'TitilliumWeb Black');
    text14 = TextStyle(
        color: colorDefaultText, fontSize: 14, fontFamily: 'TitilliumWeb Web');
    text14Disabled = TextStyle(
        color: colorFooter, fontSize: 14, fontFamily: 'TitilliumWeb Web');
    text16400 = TextStyle(
      color: colorBlack,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    text12dWhite = TextStyle(
        color: colorWhite, fontSize: 12, fontFamily: 'Titillium Web Black');
    text12Red = TextStyle(
        color: colorPrimaryRed, fontSize: 12, fontFamily: 'Titillium Web Black');
    text12RedBold = TextStyle(
        color: colorPrimaryRed, fontSize: 12, fontFamily: 'Titillium Web Black', fontWeight: FontWeight.w800,);
    text14Black = TextStyle(
        color: colorBlack, fontSize: 14, fontFamily: 'Titillium Web Black');
  }
}

var _backgroundColor = Colors.white;
var _backgroundDarkColor = Colors.black;
const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

const MaterialColor black = const MaterialColor(
  0xFF000000,
  const <int, Color>{
    50: const Color(0xFF000000),
    100: const Color(0xFF000000),
    200: const Color(0xFF000000),
    300: const Color(0xFF000000),
    400: const Color(0xFF000000),
    500: const Color(0xFF000000),
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);
