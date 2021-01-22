part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryError extends CategoryState {
  CategoryError({@required this.error});

  final AppException error;
}

class CategoriesLoaded extends CategoryState {
  CategoriesLoaded({@required this.categories});

  final List<Category> categories;
}
