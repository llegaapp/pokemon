import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../global_widgets/data_table/src/data_table_2.dart';
import '../../../models/stores/anaqueleros_to_manage_client.dart';

class DiaryAnaquelerosLoadData extends DataTableSource {
  DiaryAnaquelerosLoadData.empty(this.context, this.updateUniqueSelectedTmp) {
    itemsAnaqueleros = [];
  }
  final BuildContext context;
  late String idUniqueSelected;
  late String nameUniqueSelected;
  late List<AnaquelerosToManage> itemsAnaqueleros = [];
  late Function(String, String) updateUniqueSelectedTmp;

  late bool hasRowHeightOverrides;
  List<Map<String, dynamic>> data = [];

  DiaryAnaquelerosLoadData(
      {required this.context,
      required this.idUniqueSelected,
      required this.nameUniqueSelected,
      required this.itemsAnaqueleros,
      required this.updateUniqueSelectedTmp}) {
    updateUniqueSelectedTmp(this.idUniqueSelected, this.nameUniqueSelected);
  }

  void sorts<T>(
      Comparable<T> Function(AnaquelerosToManage p) getField, bool ascending) {
    itemsAnaqueleros.sort((a, b) {
      final aValue = getField(a).toString().toLowerCase();
      final bValue = getField(b).toString().toLowerCase();
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    _selectedCount =
        itemsAnaqueleros.where((c) => c.selected == true).toList().length;

    assert(index >= 0);
    if (index >= itemsAnaqueleros.length) throw 'index > perfilesTable.length';
    final data = itemsAnaqueleros[index];
    return DataRow2.byIndex(
      index: index,
      selected: data.selected,
      color:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return themeApp.colorWhite;
      }),
      cells: [
        DataCell(
          Radio(
            value: data.id.toString(),
            groupValue: idUniqueSelected,
            onChanged: (value) {
              idUniqueSelected = value.toString();
              nameUniqueSelected = data.name.toString();
              updateUniqueSelectedTmp(
                  idUniqueSelected.toString(), nameUniqueSelected);
              notifyListeners();
            },
            activeColor: themeApp.colorPrimaryBlue,
          ),
        ),
        DataCell(Text(
          data.id.toString(),
          style: themeApp.text16400Black,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(
          data.name.toString(),
          style: themeApp.text16400Black,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }

  @override
  int get rowCount => itemsAnaqueleros.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
