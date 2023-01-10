import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'drop_down_notifier.dart';

class DropdownScreen extends StatelessWidget {
  const DropdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> globalDataList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DropDown'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final drawListData = ref.watch(dropDownValueProvider);

            return drawListData.when(
              data: (dropDownData) {
                globalDataList = dropDownData.dropDownList ?? [];
                var dataList = dropDownData.dropDownList ?? [];
                debugPrint(
                    "dropDown getDrawList data: ${dropDownData.dropDownList}");

                String newValue = dropDownData.value ?? '';
                debugPrint("dropDown change value: $newValue");

                return DropdownButton<String>(
                  value: newValue,
                  items: dataList
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black87)),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    ref
                        .read(dropDownValueProvider.notifier)
                        .updateSelectedValue(newValue, globalDataList);
                  },
                );
              },
              error: (err, stack) => Text("Error: ${err.toString()}"),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
