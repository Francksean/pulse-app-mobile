import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/map/models/center_position.dart';

abstract class MapCentersState extends Equatable {
  const MapCentersState();
  @override
  List<Object?> get props => [];
}

class MapCentersInitialState extends MapCentersState {}

class MapCentersLoadingState extends MapCentersState {}

class MapCentersErrorState extends MapCentersState {
  final String error;
  const MapCentersErrorState({required this.error});
}

class MapCentersLoadedState extends MapCentersState {
  final List<CenterPosition> centersPositions;
  const MapCentersLoadedState({required this.centersPositions});
}
