import 'package:fengshuinumber/src/core/navigation/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appContextProvider = Provider<BuildContext?>((ref) {
  final routeDelegate = ref.watch(seedRouterDelegateProvider);
  return routeDelegate.navigatorKey!.currentContext;
});

final spashNotifyProvider = FutureProvider<bool>((ref) async {
  final provider = ref.watch(initProvider);
  await provider.init();
  return true;
});

final initProvider = Provider((ref) => InitializeProgress());

class InitializeProgress {
  Future<void> init() async {}
}
