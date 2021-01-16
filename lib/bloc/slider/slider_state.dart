part of 'slider_bloc.dart';

@immutable
abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderError extends SliderState {
  SliderError({@required this.error});

  final AppException error;
}

class SlidersLoaded extends SliderState {
  SlidersLoaded({@required this.sliders});

  final List<Slide> sliders;
}
