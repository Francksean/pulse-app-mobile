import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/common/models/user_location.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object?> get props => [];
}

class LocationInitialState extends LocationState {}

class LocationErrorState extends LocationState {
  final String message;
  const LocationErrorState({required this.message});
}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final UserLocation location;
  const LocationLoadedState({required this.location});
}
