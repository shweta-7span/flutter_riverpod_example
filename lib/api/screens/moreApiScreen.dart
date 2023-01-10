import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/previousDraw/previous_draws_data.dart';
import '../notifier/change_draw_item_list_notifier.dart';
import '../notifier/draw_data_notifier.dart';
import '../services/api_service.dart';

//For APIs
final nextDrawProvider =
    FutureProvider<String>((ref) => ref.read(apiProvider).getNextDraw());
final drawListProvider =
    FutureProvider<List<String>>((ref) => ref.read(apiProvider).getDrawList());

//To set the new value in Dropdown
final newDropDownValueProvider = StateProvider<String>((ref) => '');

class MoreApiScreen extends StatelessWidget {
  const MoreApiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('build:');
    return Scaffold(
      appBar: AppBar(
        title: const Text('More API'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Consumer(
              builder: (context, ref, child) {
                final nextDrawData = ref.watch(nextDrawProvider);

                return nextDrawData.when(
                  data: (data) {
                    return Text(data);
                  },
                  error: (err, stack) => Text(err.toString()),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Consumer(
              builder: (context, ref, child) {
                final drawData = ref.watch(drawDataProvider);

                return drawData.when(
                  data: (data) {
                    List<PreviousDataModel> firstDrawList =
                        data.previousDrawResponse.data ?? [];
                    debugPrint(
                        "firstDrawItemList data: ${firstDrawList.length}");

                    return Expanded(
                      child: Column(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              String newValue = ref
                                  .watch(newDropDownValueProvider)
                                  .toString();
                              if (newValue.isEmpty) {
                                newValue = data.drawList[0];
                              }
                              debugPrint("DropDown's change value: $newValue");

                              return DropdownButton<String>(
                                value: newValue,
                                items: data.drawList
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87)),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (String? newValue) {
                                  debugPrint('onChanged');
                                  ref
                                      .read(newDropDownValueProvider.notifier)
                                      .state = newValue ?? data.drawList[0];
                                  ref
                                      .read(changeDrawItemListProvider.notifier)
                                      .getUpdatedDrawItemList(newValue);

                                  //-------For Family modifier-------
                                  /* debugPrint('read Family: $newValue');
                                  ref
                                      .read(
                                          changeDrawListProvider(newValue ?? '')
                                              .notifier)
                                      .callChangeValueAPI();*/
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final responseData =
                                  ref.watch(changeDrawItemListProvider);

                              //-------For Family modifier-------
                              /* String selectedValue = ref
                                  .watch(newDropDownValueProvider)
                                  .toString();

                              debugPrint('watch Family: $selectedValue');

                              final responseData = ref
                                  .watch(changeDrawListProvider(selectedValue));*/

                              return responseData.when(
                                data: (response) {
                                  List<PreviousDataModel> previousDrawList =
                                      response.data ?? firstDrawList;
                                  debugPrint(
                                      "changedDrawItemList data: ${response.data?.length}");

                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: previousDrawList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(
                                            "Draw Number: ${previousDrawList.elementAt(index).drawNumber}",
                                          ),
                                          subtitle: Text(
                                            "Program: ${previousDrawList.elementAt(index).immigrationProgram}",
                                          ),
                                          trailing: Text(previousDrawList
                                              .elementAt(index)
                                              .crsScore
                                              .toString()),
                                        );
                                      },
                                    ),
                                  );
                                },
                                error: (err, stack) =>
                                    Text("Error: ${err.toString()}"),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  error: (err, stack) => Text("Error: ${err.toString()}"),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
