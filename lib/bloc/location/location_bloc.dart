import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:jewelry_flutter/exceptions.dart';
import 'package:jewelry_flutter/models/Location.dart';
import 'package:jewelry_flutter/service.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());

  final _service = Service();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchLocations) {
      yield LocationLoading();
      try {
        final locations = await _service.getLocations();
        yield LocationsLoaded(locations: locations);
      } on SocketException {
        yield LocationError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield LocationError(error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield LocationError(
            error: InvalidFormatException('Invalid Response Format'));
      } catch (e) {
        print(e);
        yield LocationError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
