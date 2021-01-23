import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:jewelry_flutter/exceptions.dart';
import 'package:jewelry_flutter/models/product.dart';
import 'package:jewelry_flutter/service.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class SubCategoryProductBloc
    extends Bloc<SubCategoryProductEvent, SubCategoryProductState> {
  SubCategoryProductBloc() : super(SubCategoryProductInitial());

  final _service = Service();

  @override
  Stream<SubCategoryProductState> mapEventToState(
    SubCategoryProductEvent event,
  ) async* {
    print(event);
    if (event is FetchSubCategoryProducts) {
      yield SubCategoryProductLoading();
      try {
        final subCategoryProducts =
            await _service.getSubCategoryProducts(subId: event.id);
        yield SubCategoryProductsLoaded(products: subCategoryProducts);
      } on SocketException {
        yield SubCategoryProductError(
            error: NoInternetException('No Internet'));
      } on HttpException {
        yield SubCategoryProductError(
            error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield SubCategoryProductError(
            error: InvalidFormatException('Invalid Response Format'));
      } catch (e) {
        yield SubCategoryProductError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
