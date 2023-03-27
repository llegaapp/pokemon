import 'package:flutter/material.dart';

class Constant {
  static const String TXT_VERSION = 'Compilacion: (' +
      String.fromEnvironment('BUILD_BUILDNUMBER', defaultValue: '0') +
      ')';
  static const double iconSize = 35.0;
  static const String PATH_IMG = 'assets/img/';
  static const String LOGO_GTP = PATH_IMG + 'logotipo_gtp.svg';
  static const String LOGO_ALONE = PATH_IMG + 'logo_splash_1152.png';
  static const String ICON_USER = PATH_IMG + 'user.svg';
  static const String ICON_SCHEDULE = PATH_IMG + 'schedule.svg';
  static const String ICON_LOCK = PATH_IMG + 'lock.svg';
  static const String ICON_WARNING = PATH_IMG + 'warning.svg';
  static const String ICON_BLOCK = PATH_IMG + 'block.svg';
  static const String ICON_CHECK = PATH_IMG + 'check.svg';
  static const String ICON_VECTOR = PATH_IMG + 'vector.svg';
  static const String ICON_PROGRESS = PATH_IMG + 'progress.svg';
  static const String ICON_STORE = PATH_IMG + 'store.svg';
  static const String ICON_MAP = PATH_IMG + 'map.svg';
  static const String IMG_CONSTRUCTION = PATH_IMG + 'construction.svg';
  static const String ICON_COMMENT = PATH_IMG + 'comment.svg';
  static const String ICON_NOTWORKING = PATH_IMG + 'notworking.svg';
  static const String ICON_CLOCK = PATH_IMG + 'clock.svg';
  static const String ICON_ALERTS = PATH_IMG + 'alerts.svg';
  static const String ICON_PROFILE = PATH_IMG + 'profile.svg';
  static const String ICON_ROUTE = PATH_IMG + 'route.svg';
  static const String ICON_CHEVRON_UP = PATH_IMG + 'chevron-up.svg';
  static const String ICON_CHEVRON_DOWN = PATH_IMG + 'chevron-down.svg';
  static const String ICON_HAPPY_FACE = PATH_IMG + 'happy-face.svg';
  static const String ICON_ITEM = PATH_IMG + 'item.svg';
  static const String ICON_ITEM2 = PATH_IMG + 'item2.svg';
  static const String ICON_TRANSFER = PATH_IMG + 'transfer.svg';
  static const String ICON_RELOAD = PATH_IMG + 'reload.svg';
  static const String ICON_RELOAD_PNG = PATH_IMG + 'reload.png';
  static const String ICON_TASKTS = PATH_IMG + 'taskts.svg';
  static const String ICON_USER_GROUP = PATH_IMG + 'user-group.svg';
  static const String ICON_STORE_NAVBAR = PATH_IMG + 'store_navbar.svg';
  static const String ICON_CHECK_PNG = PATH_IMG + 'check.png';
  static const String ICON_ALERTS_PNG = PATH_IMG + 'alerts.png';
  static const String ICON_SEACH = PATH_IMG + 'search.svg';
  static const String ICON_EDIT = PATH_IMG + 'edit.svg';
  static const String ICON_BACK = PATH_IMG + 'back.svg';
  static const String ICON_BACK_PNG = PATH_IMG + 'back.png';
  static const String ICON_CLOCK_GREEN = PATH_IMG + 'clock_green.svg';
  static const String ICON_STORE_ACTIVE_PNG = PATH_IMG + 'store1.png';
  static const String ICON_LIST_ACTIVE_PNG = PATH_IMG + 'list1.png';
  static const String ICON_GROUP_ACTIVE_PNG = PATH_IMG + 'group1.png';
  static const String ICON_STORE_DESACTIVE_PNG = PATH_IMG + 'store0.png';
  static const String ICON_LIST_DESACTIVE_PNG = PATH_IMG + 'list0.png';
  static const String ICON_GROUP_DESACTIVE_PNG = PATH_IMG + 'group0.png';
  static const String ICON_GROUP_GROUPS = PATH_IMG + 'Group.svg';
  static const String ICON_CAMERA_BLUE = PATH_IMG + 'camera_blue.svg';
  static const String ICON_DOTS = PATH_IMG + 'dots.svg';
  static const String ICON_TRASH = PATH_IMG + 'trash.svg';
  static const String ICON_TRASH_BLUE = PATH_IMG + 'trash_blue.svg';
  static const String ICON_GROUP_GROUPS219 = PATH_IMG + 'Group219.svg';
  static const String ICON_GROUP_GROUPS186 = PATH_IMG + 'Group186.svg';
  static const String ICON_CALENDAR_BLUE = PATH_IMG + 'calendar_blue.svg';
  static const String ICON_POKE_BALL = PATH_IMG + 'poke_ball.png';
  static const String ICON_PC = PATH_IMG + 'pc.png';

  static const String LOGO_DETALLISTA = PATH_IMG + 'detallista.png';
  static const String LOGO_CONSUMIDOR = PATH_IMG + 'consumidor.png';
  static const String LOGO_FACEBOOK = PATH_IMG + 'facebook-icon@3x.png';
  static const String LOGO_PEDIDOS = PATH_IMG + 'pedidos-icon=blue@3x.png';
  static const String LOGO_YOUTUBE = PATH_IMG + 'youtube.png';
  static const String FACEBOOK_NEWS = 'Facebook';
  static const String YOUTUBE_NEWS = 'YouTube';
  static const String LOGO_IMAGE_PROFILE_DEFAULT =
      PATH_IMG + 'img_profile_default.png';

  static const String PROFILE_ANAQ = 'ANAQUELERO';
  static const String PROFILE_SUP = 'SUPERVISOR';
  static const String PROFILE_AUD = 'AUDITOR';

  static const String ID_STATUS_PENDIENTE = '1';
  static const String NAME_STATUS_PENDIENTE = 'Pendiente';
  static const String NAME_STATUS_PENDIENTES = 'Pendientes';
  static const String COLOR_STATUS_PENDIENTE = 'FF963A';

  static const String ID_STATUS_ENCURSO = '2';
  static const String NAME_STATUS_ENCURSO = 'En curso';
  static const String COLOR_STATUS_ENCURSO = '009FDF';

  static const String ID_STATUS_TERMINADA = '3';
  static const String NAME_STATUS_TERMINADA = 'Terminada';
  static const String NAME_STATUS_TERMINADAS = 'Terminadas';
  static const String COLOR_STATUS_TERMINADA = '03C395';

  static const String ID_TEAM_TYPE_REEMPLAZO = '4';

  static const String ID_STATUS_ALL = '99';
  static const String NAME__ALL = 'Todas';
  static const String STR_BUTTON_CHECKOUT = 'Terminar tareas';
  static const String STR_TITLE_CHECKOUT =
      'Estas a punto de finalizar las tareas asignadas para esta tienda';
  static const String STR_SUBTITLE_CHECKOUT =
      '¿Deseas agregar una observación con relación a tus tareas?';
  static const String STR_OPC_CHECKOUT = 'Opcional';
  static const String STR_CHECKIN = 'Checkin';
  static const String STR_TITLE_EVENT = 'Solicitar tiempo';
  static const String STR_SUBTITLE_EVENT =
      'Selecciona el evento que deseas realizar.';
  static const String ALL_STORES = 'Todas las tiendas';
  static const String AGENDS_TODAY = 'Agendadas para hoy';
  static const String ALL_STORES_VALUE = 'Todaslastiendas';
  static const String AGENDS_TODAY_VALUE = 'Agendadasparahoy';
  static const String ALL_TEAMS = 'Todos';
  static const String TEAMS_TODAY = 'Para hoy';
  static const String ALL_TEAMS_VALUE = 'TodosEquipos';
  static const String TEAMS_TODAY_VALUE = 'EquposHoy';

  static const String FORMAT_JPG = 'jpg';
  static const String FORMAT_JPEG = 'jpeg';
  static const String FORMAT_PNG = 'png';
  static const String FORMAT_GIF = 'gif';
  static const String FORMAT_BMP = 'bmp';
  static const String FORMAT_RAW = 'raw';

  static const String FORMAT_IMAGE_JPG = 'data:image/jpg;base64,';
  static const String FORMAT_IMAGE_JPEG = 'data:image/jpeg;base64,';
  static const String FORMAT_IMAGE_PNG = 'data:image/png;base64,';
  static const String FORMAT_IMAGE_GIF = 'data:image/gif;base64,';
  static const String FORMAT_IMAGE_BMP = 'data:image/bmp;base64,';
  static const String FORMAT_IMAGE_RAW = 'data:image/raw;base64,';

  static const String STR_TRUE = 'true';
  static const String STR_FALSE = 'false';
}
