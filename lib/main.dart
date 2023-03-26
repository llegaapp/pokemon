import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'app/config/string_app.dart';
import 'app/config/theme_app.dart';
import 'app/data_source/api_clients.dart';
import 'app/data_source/graphql_config.dart';
import 'app/data_source/rest_data_source.dart';
import 'app/modules/pokemon/supervisor_binding.dart';
import 'app/modules/pokemon/supervisor_page.dart';
import 'app/repository/main_repository.dart';
import 'app/routes/app_pages.dart';

ThemeApp themeApp = ThemeApp();

void main() async {
  themeApp.init();
  WidgetsFlutterBinding.ensureInitialized();



  final apiClients = ApiClients();
  final apiRest = RestDataSource();
  final mainRepository = MainRepository(apiClients, apiRest);
  Get.put(mainRepository);
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(AppGestion());
}

class AppGestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = GraphQLConfig.graphInit();

    var _theme = ThemeData(
      fontFamily: 'TitilliumWeb',
      primarySwatch: themeApp.primarySwatch,
    );

    return GetMaterialApp(
      title: titleAppStr,
      debugShowCheckedModeBanner: false,
      theme: _theme,
      home: SupervisorPage(),
      initialBinding: SupervisorBinding(),
      getPages: AppPages.pages,
    );
  }
}

dprint(String str) {
  if (!kReleaseMode) print(str);
}
