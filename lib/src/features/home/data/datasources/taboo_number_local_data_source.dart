import 'dart:convert';

import 'package:fengshuinumber/src/features/splash/presentation/notifiers/splash_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabooNumbersLocalDataSourceProvider =
    Provider<TabooNumberLocalDataSource>((ref) {
  final appContext = ref.watch(appContextProvider);
  return TabooNumberLocalDataSourceImpl(appContext!);
});

abstract class TabooNumberLocalDataSource {
  Future<List<String>> getNumbers();
}

class TabooNumberLocalDataSourceImpl extends TabooNumberLocalDataSource {
  TabooNumberLocalDataSourceImpl(this.context);
  final BuildContext context;
  @override
  Future<List<String>> getNumbers() async {
    final String content = await DefaultAssetBundle.of(context)
        .loadString("assets/taboo_numbers.json");
    return List.castFrom<dynamic, String>(jsonDecode(content));
  }
}
