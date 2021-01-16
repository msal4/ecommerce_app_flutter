part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {
  ProductError({@required this.error});

  final AppException error;
}

class ProductsLoaded extends ProductState {
  ProductsLoaded({@required this.products});

  final List<Product> products;
}
