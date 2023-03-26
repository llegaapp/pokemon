class Cnstds {
  static const String API_URL =
      'https://pokeapi.co/api/v2/pokemon';
  static const String IMG_URL_SOURCE =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/';
  static const String DEV_HOST_API_URL =
      'https://k8s-env-dev.southcentralus.cloudapp.azure.com/gepp/gestion/dev/api/graphql';
  static const String STG_HOST_API_URL =
      'https://stg.tiendaperfectagepp.com/api/graphql';
  static const String DEV_HOST_AUTH_URL =
      'https://k8s-env-dev.southcentralus.cloudapp.azure.com/gepp/gestion/dev/auth/graphql';
  static const String STG_HOST_AUTH_URL =
      'https://stg.tiendaperfectagepp.com/auth/graphql';
  static const String DEV_HEADER_APP_CODE =
      'df896f37-b673-11ec-9648-6045bd7ee38b';
  static const String STG_HEADER_APP_CODE = '3O6rVKXp0zAlcDK6QJAUakoTwtotyi';

  static const String KEY_API_URL =
      String.fromEnvironment('API_URL', defaultValue: STG_HOST_API_URL);
  static const String KEY_AUTH_URL =
      String.fromEnvironment('AUTH_URL', defaultValue: STG_HOST_AUTH_URL);
  static const String KEY_HEADER_APP_CODE = String.fromEnvironment(
      'HEADER_APP_CODE',
      defaultValue: STG_HEADER_APP_CODE);

  static const String KEY_ENDPOINT_LOGIN = 'graphql';
  static const String KEY_GST00000 = 'GST00000';
  static const String KEY_GST00001 = 'GST00001';
  static const String KEY_RESPONSCODE = 'responseCode';
  static const String KEY_RESPONSE = 'response';
  static const String KEY_VALIDATIONS = 'validations';
  static const String KEY_V_GST00005 = 'V_GST00005';
  static const String TXT_V_GST00005 = 'El número del empleado no existe';
  static const String KEY_V_GST00006 = 'V_GST00006';
  static const String TXT_V_GST00006 = 'Usuario y/o contraseña inválidos';
  static const String KEY_V_GST00007 = 'V_GST00007';
  static const String TXT_V_GST00007 = 'El usuario está inactivo';
  static const String KEY_V_GST00008 = 'V_GST00008';
  static const String TXT_V_GST00008 = 'El usuario está bloqueado';
  static const String KEY_V_GST00012 = 'V_GST00012';
  static const String TXT_V_GST00012 = 'Hoy es un día no laborable';
  static const String KEY_GST00003 = 'GST00003';
  static const String TXT_GST00003 =
      'Se ha producido una excepción en el proceso.';
  static const String KEY_GST00004 = 'GST00004';
  static const String TXT_GST00004 =
      'Usted no tiene permisos de acceso a la app';
  static const String TXT_ERROR_INSERT_EVENT =
      'Hubo un error al registrar el evento';
  static const String KEY_GST00005 = 'GST00005';
  static const String TXT_GST00005 =
      'El perfil con el que el usuario ha iniciado sesion no puede acceder a la aplicacion o al servicio';
  static const String KEY_GST00006 = 'GST00006';
  static const String TXT_GST00006 =
      'El codigo de la aplicacion esta vacio o no existe en la bd de codigos permitidos para recibir peticiones';
  static const String KEY_GST00007 = 'GST00007';
  static const String TXT_GST00007 =
      'El codigo de aplicacion no corresponde al servicio que se intenta acceder';
  static const String KEY_GST00008 = 'GST00008';
  static const String TXT_GST00008 =
      'El usuario no se ha logueado, no se reconoce la informacion del token que se recibe';
  static const String TXT_UKNOW_ERROR = 'Error desconocido';

  static const String KEY_DATA = 'data';
  static const String dataHomeInfo = 'dataHomeInfo';
  static const String dataClient = 'dataClient';
  static const String dataEventClient = 'dataEventClient';
  static const String dataEvent = 'dataEvent';
  static const String dataRouteSup = 'dataRouteSup';
  static const String dataRouteSupTotal =
      'dataRouteSupTotal';
  static const String todayShow = 'todayShow';
  static const String startEvent = 'appStartEvent';
  static const String endEvent = 'appEndEvent';
  static const String checkIn = 'appCheckIn';
  static const String checkOut = 'appCheckOut';
  static const String dataClientDetailSup = 'dataClientDetailSup';
  static const String dataClientDetailOtherRoute = 'dataClientDetailOtherRoute';
  static const String dataClientsListByRouteSupervisor =
      'dataClientsListByRouteSupervisor';
  static const String dataClientsListByRouteSupervisorToday =
      'dataClientsListByRouteSupervisorToday';
  static const String dataAppCatRouteBySupervisor =
      'dataAppCatRouteBySupervisor';
  static const String dataAnaqueleros = 'dataAnaqueleros';
  static const String dataAnaquelerosToManageClient =
      'dataAnaquelerosToManageClient';
  static const String dataCatRoutesBySupervisor = 'dataCatRoutesBySupervisor';
  static const String dataTeamListBySupervisor = 'dataTeamListBySupervisor';
  static const String dataProfileUser = 'dataProfileUser';
  static const String dataCountClientsStates = 'dataCountClientsStates';
  static const String dataPokemonList = 'dataPokemonList';
  static const String dataPokemonDetailList = 'dataPokemonDetailList';
}
