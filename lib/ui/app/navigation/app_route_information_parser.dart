import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'app_route.dart';

@singleton
class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  AppRouteInformationParser(this._logger);

  final Logger _logger;
  final Map<AppRoute, String> _appRouteLocations = {
    AppRoute.converter: "converter",
    AppRoute.exchangeRates: "exchangeRates"
  };

  @override
  Future<AppRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final String location = routeInformation.location!;
    AppRoute route;
    if (_appRouteLocations.containsValue(location)) {
      route = _appRouteLocations.entries
          .firstWhere((element) => element.value == location)
          .key;
    } else {
      route = AppRoute.converter;
    }
    _logger.d("Route for location: '$location:' $route");
    return route;
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    final locationForRoute = _appRouteLocations[configuration] ?? "/";
    _logger.d("Location for route $configuration: '$locationForRoute'");
    return RouteInformation(location: locationForRoute);
  }
}
