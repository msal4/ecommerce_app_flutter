part of 'product_bloc.dart';

@immutable
abstract class SubCategoryProductEvent {}

class FetchSubCategoryProducts extends SubCategoryProductEvent {
  FetchSubCategoryProducts({this.id});

  final int id;
}
