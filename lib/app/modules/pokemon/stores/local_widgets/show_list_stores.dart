import 'package:pokemon_heb/app/modules/pokemon/supervisor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view_stores_info.dart';

class ShowListStores extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
        builder: (_) => Scrollbar(
              thickness: 8,
              thumbVisibility: true,
              controller: _scrollController,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _.itemsStores.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ViewStoresInfo(_.itemsStores[index], index, _.currentStoreList);
                  }),
            ));
  }
}
