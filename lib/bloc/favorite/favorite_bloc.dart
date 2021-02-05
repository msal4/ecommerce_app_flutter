import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:jewelry_flutter/exceptions.dart';
import 'package:jewelry_flutter/models/favorite.dart';
import 'package:jewelry_flutter/service.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial());

  final _service = Service();

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is FetchFavorites) {
      try {
        yield FavoriteLoading();
        final favorites = await _service.getFavorites();
        yield FavoritesLoaded(favorites: favorites);
      } on SocketException {
        yield FavoriteError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield FavoriteError(error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield FavoriteError(
          error: InvalidFormatException('Invalid Response Format'),
        );
      } catch (e) {
        print(e);
        yield FavoriteError(error: UnknownException('Unknown Error'));
      }
    }

    if (event is AddFavorite) {
      try {
        yield FavoriteLoading();
        await _service.addFavorite(
            itemId: event.itemId, itemLikes: event.likes);
        yield FavoriteAdded();
      } on SocketException {
        yield FavoriteError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield FavoriteError(error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield FavoriteError(
          error: InvalidFormatException('Invalid Response Format'),
        );
      } catch (e) {
        yield FavoriteError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
