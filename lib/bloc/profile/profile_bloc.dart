import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:jewelry_flutter/exceptions.dart';
import 'package:jewelry_flutter/models/profile.dart';
import 'package:jewelry_flutter/service.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  final _service = Service();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      yield ProfileLoading();
      try {
        final profile = await _service.getProfile();
        yield ProfileLoaded(profile: profile);
      } on SocketException {
        yield ProfileError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield ProfileError(error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield ProfileError(
            error: InvalidFormatException('Invalid Response Format'));
      } catch (e) {
        yield ProfileError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
