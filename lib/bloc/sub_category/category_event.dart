part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class FetchCategories extends CategoryEvent {}

class FetchSubCategories extends CategoryEvent {
  FetchSubCategories({@required this.id});

  final int id;
}
