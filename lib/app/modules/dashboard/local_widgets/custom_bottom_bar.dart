import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/modules/dashboard/dashboard_controller.dart';
import 'package:pokemon_heb/app/modules/pokemon/supervisor_controller.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatefulWidget {
  final String group;
  final GetxController controller;
  const CustomBottomBar({required this.group, required this.controller});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _indexPage = 0;

  @override
  void initState() {
    super.initState();
    setIndexPage();
  }

  setIndexPage() {
    if (widget.group == Constant.PROFILE_SUP) {
      _indexPage = (widget.controller as SupervisorController).indexPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
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
                size: 35,
              ),
              activeIcon: ImageIcon(
                AssetImage(Constant.ICON_STORE_ACTIVE_PNG),
                size: 35,
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
      if (widget.group == Constant.PROFILE_SUP) {
        (widget.controller as SupervisorController).setIndexPage(index);
        (widget.controller as SupervisorController).onReady();
      }
    });
  }
}
