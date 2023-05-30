part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapStateInitial extends MapState {
  const MapStateInitial();
}

class MapStateLoading extends MapState {
  const MapStateLoading();
}

class MapStateError extends MapState {
  const MapStateError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

class MapStateLoaded extends MapState {
  const MapStateLoaded(this.markers);

  final Set<Marker> markers;

  @override
  List<Object> get props => [markers];
}