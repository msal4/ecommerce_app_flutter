import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:jewelry_flutter/exceptions.dart';
import 'package:jewelry_flutter/models/category.dart';
import 'package:jewelry_flutter/models/sub_category.dart';
import 'package:jewelry_flutter/service.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());


  final _service = Service();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is FetchCategories) {
      try {
        yield CategoryLoading();
        final categories = await _service.getCategories();
        yield CategoriesLoaded(categories: categories);
      } on SocketException {
        yield CategoryError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield CategoryError(error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield CategoryError(
          error: InvalidFormatException('Invalid Response Format'),
        );
      } catch (e) {
        yield CategoryError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
