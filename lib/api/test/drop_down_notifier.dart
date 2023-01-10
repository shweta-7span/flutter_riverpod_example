import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';

final dropDownValueProvider =
    StateNotifierProvider<DropDownValueNotifier, AsyncValue<DropDownData>>(
        (ref) => DropDownValueNotifier(ref.read(apiProvider)));

class DropDownValueNotifier extends StateNotifier<AsyncValue<DropDownData>> {
  DropDownValueNotifier(this.service) : super(const AsyncLoading()) {
    getDropDownList();
  }

  final ApiService service;

  void getDropDownList() async {
    state = const AsyncLoading();
    // state = await service.getDrawListNew();
  }

  void updateSelectedValue(String? newValue, List<String> list) {
    state = AsyncData(DropDownData.fromJson(newValue, list));
    // state = AsyncData(DropDownData().setValue(newValue ?? ''));
    // state = AsyncData(DropDownData.setValue(newValue ?? ''));
  }
}

class DropDownData {
  String? value;
  List<String>? dropDownList;

  DropDownData({
    this.value,
    this.dropDownList,
  });

  /*setValue(String newValue , List<String> list) {
    value = newValue;
    debugPrint('DropDownData List: ${dropDownList?.length}');
    dropDownList?.addAll(list);
  }*/

  /*set setDropDownList(List<String> list) {
    dropDownList = list;
  }*/

  factory DropDownData.fromJson(String? newValue, List<dynamic>? json) {
    return DropDownData(
        value: newValue ?? json?.cast<String>()[0],
        dropDownList: json?.cast<String>());
  }
}
