import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/previousDraw/previous_draw_response.dart';
import '../services/api_service.dart';

final changeDrawItemListProvider = StateNotifierProvider /*.family*/ <
        ChangeDrawItemListNotifier,
        AsyncValue<PreviousDrawResponse> /*, String*/ >(
    (ref /*, initialValue*/) =>
        ChangeDrawItemListNotifier(ref.read(apiProvider) /*, initialValue*/));

class ChangeDrawItemListNotifier
    extends StateNotifier<AsyncValue<PreviousDrawResponse>> {
  ChangeDrawItemListNotifier(this.service /*, this.initialValue*/)
      : super(const AsyncLoading()) {
    // callChangeValueAPI(null);
    state = AsyncData(PreviousDrawResponse());
  }

  final ApiService service;
  // final String initialValue;

  void getUpdatedDrawItemList(String? newValue) async {
    // debugPrint('callChangeValueAPI initialValue: $initialValue');
    debugPrint('getUpdatedDrawItemList of: $newValue');
    state = const AsyncLoading();
    state = AsyncData(await service.getDrawItemList(/*initialValue*/ newValue));
  }
}
