import 'package:flutter/material.dart';
import '../../../models/stores/anaqueleros_to_manage_client.dart';
import '../../../../main.dart';
import '../../../global_widgets/data_table/src/data_table_2.dart';

class StoresAnaquelerosLoadData extends DataTableSource {
  StoresAnaquelerosLoadData.empty(
      this.context , this.selectAnaqueleros) {
    itemsAnaqueleros = [];

  }
  final BuildContext context;
  late String idUniqueSelected;
  late List<AnaquelerosToManage> itemsAnaqueleros = [];
  final Function(AnaquelerosToManage) selectAnaqueleros;

  late bool hasRowHeightOverrides;
  List<Map<String, dynamic>> data = [];

  StoresAnaquelerosLoadData({
    required this.context,
    required this.idUniqueSelected,
    required this.itemsAnaqueleros,
    required this.selectAnaqueleros,
  });

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
              selectAnaqueleros(data);
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
