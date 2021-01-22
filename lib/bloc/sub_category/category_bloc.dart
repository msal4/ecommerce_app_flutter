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

class SubCategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  SubCategoryBloc() : super(CategoryInitial());

  final _service = Service();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is FetchSubCategories) {
      try {
        yield CategoryLoading();
        final categories = await _service.getSubCategories(event.id);
        yield SubCategoriesLoaded(categories: categories);
      } on SocketException {
        yield SubCategoryError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield SubCategoryError(
            error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield SubCategoryError(
          error: InvalidFormatException('Invalid Response Format'),
        );
      } catch (e) {
        yield SubCategoryError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
