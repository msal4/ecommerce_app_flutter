import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:jewelry_flutter/exceptions.dart';
import 'package:jewelry_flutter/models/slider.dart';
import 'package:jewelry_flutter/service.dart';
import 'package:meta/meta.dart';

part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  SliderBloc() : super(SliderInitial());

  final _service = Service();

  @override
  Stream<SliderState> mapEventToState(
    SliderEvent event,
  ) async* {
    if (event is FetchSliders) {
      yield SliderLoading();
      try {
        final products = await _service.getSliders();
        yield SlidersLoaded(sliders: products);
      } on SocketException {
        yield SliderError(error: NoInternetException('No Internet'));
      } on HttpException {
        yield SliderError(error: NoServiceFoundException('No Service Found'));
      } on FormatException {
        yield SliderError(
            error: InvalidFormatException('Invalid Response Format'));
      } catch (e) {
        print(e);
        yield SliderError(error: UnknownException('Unknown Error'));
      }
    }
  }
}
