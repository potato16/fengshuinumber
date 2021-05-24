import 'dart:io';

import 'package:fengshuinumber/src/features/home/presentation/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fengshuinumber/src/core/navigation/route_information_parser.dart';
import 'package:fengshuinumber/src/features/home/presentation/pages/home_page.dart';
import 'package:fengshuinumber/src/features/splash/presentation/pages/splash_page.dart';

final seedRouterDelegateProvider = Provider((ref) => SeedRouterDelegate());
final backButtonDispatcherProvider = Provider.family(
    (ref, SeedRouterDelegate delegate) => AppBackButtonDispatcher(delegate));

class SeedRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  Page _createPage(PageConfiguration configuration) {
    final uri = Uri.parse(configuration.path);
    Widget? widget;
    if (uri.pathSegments.isEmpty) {
      widget = const SplashPage();
    } else {
      switch (uri.pathSegments.first) {
        case 'result':
          widget = const ResultPage();
          break;
        case 'home':
          widget = const HomePage();
          break;
        default:
          widget = const SplashPage();
      }
    }

    return MaterialPage(
      key: ValueKey(configuration.path + configuration.state.toString()),
      name: configuration.path,
      child: widget,
      arguments: configuration,
    );
  }

  void addPage(PageConfiguration configuration) {
    if (configuration == const PageConfiguration.home()) {
      _pages.clear();
    } else {
      _pages.removeWhere((element) => element.arguments == configuration);
      _pages.add(_createPage(configuration));
    }
    _buildPages();
  }

  void removePage(PageConfiguration configuration) {
    _pages.removeWhere((element) => element.arguments == configuration);
    _buildPages();
  }

  void _buildPages() {
    final homePageIndex = _pages
        .lastIndexWhere((p) => p.name == const PageConfiguration.home().path);
    if (homePageIndex != -1) {
      _pages = _pages.sublist(homePageIndex);
    }
    if (_pages.isEmpty) {
      _pages = [_createPage(const PageConfiguration.home())];
    }
    notifyListeners();
  }

  void removeLastPage() {
    _pages.removeLast();
    _buildPages();
  }

  List<Page> _pages = [];

  @override
  PageConfiguration? get currentConfiguration {
    if (_pages.isEmpty) {
      return null;
    }
    return _pages.last.arguments as PageConfiguration?;
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.isEmpty) {
      _pages.add(_createPage(const PageConfiguration.splash()));
    }
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Consumer(
        builder: (context, watch, child) {
          return Navigator(
            key: navigatorKey,
            pages: List.unmodifiable(_pages),
            onPopPage: (page, result) {
              if (!page.didPop(result)) {
                return false;
              }
              removeLastPage();
              return true;
            },
            // ),
          );
        },
      ),
    );
  }

  @override
  Future<bool> popRoute() {
    if (currentConfiguration != null) {
      if (_pages.length == 1) {
        exit(0);
      } else {
        removeLastPage();
      }
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    addPage(configuration);
  }

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  AppBackButtonDispatcher(this._delegate) : super();
  final SeedRouterDelegate _delegate;
  @override
  Future<bool> didPopRoute() {
    return _delegate.popRoute();
  }
}
