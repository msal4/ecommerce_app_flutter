part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationError extends LocationState {
  LocationError({@required this.error});

  final AppException error;
}

class LocationsLoaded extends LocationState {
  LocationsLoaded({@required this.locations});

  final List<Location> locations;
}
