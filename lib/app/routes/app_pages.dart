import 'package:get/get.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/dashboard_page.dart';
import '../modules/pokemon/pokemon_binding.dart';
import '../modules/pokemon/pokemon_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [

    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.SUPERVISOR,
      page: () => PokemonPage(),
      binding: PokemonBinding(),
    ),
  ];
}
