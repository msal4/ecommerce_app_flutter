part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FetchFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  AddFavorite({@required this.itemId, @required this.likes});
  final int itemId;
  final int likes;
}
