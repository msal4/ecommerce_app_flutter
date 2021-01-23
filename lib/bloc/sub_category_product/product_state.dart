part of 'product_bloc.dart';

@immutable
abstract class SubCategoryProductState {}

class SubCategoryProductInitial extends SubCategoryProductState {}

class SubCategoryProductLoading extends SubCategoryProductState {}

class SubCategoryProductError extends SubCategoryProductState {
  SubCategoryProductError({@required this.error});

  final AppException error;
}

class SubCategoryProductsLoaded extends SubCategoryProductState {
  SubCategoryProductsLoaded({@required this.products});

  final List<SubCategoryProduct> products;
}
