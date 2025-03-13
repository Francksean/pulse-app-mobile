import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_state.dart';
import 'package:pulse_app_mobile/common/services/user_location_service.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitialState());

  final UserLocationRepository _userLocationRepository =
      UserLocationRepository();

  Future<void> fetchLocation() async {
    emit(LocationLoadingState());
    try {
      final userPosition = await _userLocationRepository.getLocationInfos();
      emit(LocationLoadedState(location: userPosition));
    } catch (e) {
      emit(LocationErrorState(message: e.toString()));
    }
  }
}
