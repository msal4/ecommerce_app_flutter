import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:jewelry_flutter/exceptions.dart';
import 'package:jewelry_flutter/models/product.dart';
import 'package:jewelry_flutter/service.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());

  final _service = Service();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is FetchProducts) {
      yield ProductLoading();
      try {
        final products = await _service.getProducts();
        yield ProductsLoaded(products: products);
      } on SocketException {
        yield ProductError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield ProductError(error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield ProductError(
            error: InvalidFormatException('Invalid Response Format'));
      } catch (e) {
        print(e);
        yield ProductError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
