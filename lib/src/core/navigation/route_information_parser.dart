import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routeInformationParserProvider =
    Provider((ref) => SeedRouteInformationParser());

class SeedRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return const PageConfiguration.splash();
    }

    switch (uri.pathSegments.first) {
      case '/result':
        return const PageConfiguration.result();
      default:
        return const PageConfiguration.home();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    return RouteInformation(
      location: configuration.path,
      state: configuration.state,
    );
  }
}

class PageConfiguration extends Equatable {
  const PageConfiguration({required this.path, this.state});

  const PageConfiguration.splash({this.state}) : path = '/';
  const PageConfiguration.home({this.state}) : path = '/home';
  const PageConfiguration.result({this.state}) : path = '/result';

  final String path;
  final Object? state;

  @override
  List<Object?> get props => [path, state];
}
