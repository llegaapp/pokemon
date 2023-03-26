import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global_widgets/app/card_store.dart';
import '../../supervisor_controller.dart';

class ShowDetailTeamsAnaquelero extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      builder: (_) => Scrollbar(
        thickness: 8,
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _.teamCurrent.details!.length + 1,
            itemBuilder: (BuildContext ctxt, int index) {
              return index < _.teamCurrent.details!.length
                  ? GestureDetector(
                      onTap: () {
                        _.showDetailStoreTeamsAnaquelero(index);
                      },
                      child: CardStore(
                        index: index,
                        idStatus: _.teamCurrent.details![index].status_id,
                        nameStatus: _.teamCurrent.details![index].status_desc,
                        comment: '',
                        name: _.teamCurrent.details![index].client_name,
                        timeShow: _.teamCurrent.details![index].time! +
                            ' ' +
                            _.teamCurrent.details![index].hours!,
                        onPressed: () {
                          _.showDetailStoreTeamsAnaquelero(index);
                        },
                      ),
                    )
                  : SizedBox(
                      height: 15,
                    );
            }),
      ),
    );
  }
}
