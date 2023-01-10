import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/previousDraw/previous_draw_response.dart';
import '../services/api_service.dart';

final drawDataProvider =
    StateNotifierProvider<DrawDataNotifier, AsyncValue<DrawData>>(
  (ref) => DrawDataNotifier(ref.read(apiProvider)),
);

class DrawDataNotifier extends StateNotifier<AsyncValue<DrawData>> {
  DrawDataNotifier(this.service) : super(const AsyncLoading()) {
    init();
  }

  final ApiService service;

  void init() async {
    final drawList = await service.getDrawList();
    final previousDrawResponse = await service.getDrawItemList(drawList[0]);
    state = AsyncData(DrawData(drawList, previousDrawResponse));
  }
}

class DrawData {
  final List<String> drawList;
  final PreviousDrawResponse previousDrawResponse;
  DrawData(this.drawList, this.previousDrawResponse);
}
