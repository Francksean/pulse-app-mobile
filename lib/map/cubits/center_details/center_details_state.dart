import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';

abstract class CenterDetailsState extends Equatable {
  const CenterDetailsState();

  @override
  List<Object?> get props => [];
}

class CenterDetailsInitialState extends CenterDetailsState {}

class CenterDetailsLoadingState extends CenterDetailsState {}

class CenterDetailsLoadedState extends CenterDetailsState {
  final CenterDetails centerDetails;

  const CenterDetailsLoadedState(this.centerDetails);
}

class CenterDetailsErrorState extends CenterDetailsState {
  final String message;

  const CenterDetailsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
