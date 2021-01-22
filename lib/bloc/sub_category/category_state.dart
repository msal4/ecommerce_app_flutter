part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class SubCategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryError extends CategoryState {
  CategoryError({@required this.error});

  final AppException error;
}

class SubCategoryLoading extends CategoryState {}

class SubCategoryError extends CategoryState {
  SubCategoryError({@required this.error});

  final AppException error;
}

class CategoriesLoaded extends CategoryState {
  CategoriesLoaded({@required this.categories});

  final List<Category> categories;
}

class SubCategoriesLoaded extends CategoryState {
  SubCategoriesLoaded({@required this.categories});

  final List<SubCategory> categories;
}
