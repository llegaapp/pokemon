import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/modules/pokemon/supervisor_controller.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _indexPage = 1;
  SupervisorController controller = Get.put(SupervisorController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      builder: (_) => Container(
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: themeApp.colorPrimaryBlue,
          currentIndex: _indexPage,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Constant.ICON_STORE_DESACTIVE_PNG),
                size: 43,
              ),
              activeIcon: ImageIcon(
                AssetImage(Constant.ICON_STORE_ACTIVE_PNG),
                size: 43,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Constant.ICON_LIST_DESACTIVE_PNG),
                size: 35,
              ),
              activeIcon: ImageIcon(
                AssetImage(Constant.ICON_LIST_ACTIVE_PNG),
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(Constant.ICON_GROUP_DESACTIVE_PNG),
                size: 35,
              ),
              activeIcon: ImageIcon(
                AssetImage(Constant.ICON_GROUP_ACTIVE_PNG),
                size: 35,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _indexPage = index;
    });
    controller.setIndexPage(index);
  }
}
