part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteError extends FavoriteState {
  FavoriteError({@required this.error});

  final AppException error;
}

class FavoriteAdded extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  FavoritesLoaded({@required this.favorites});

  final List<Favorite> favorites;
}
