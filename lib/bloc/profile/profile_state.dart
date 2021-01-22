part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  ProfileError({@required this.error});

  final AppException error;
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded({@required this.profile});

  final Profile profile;
}
