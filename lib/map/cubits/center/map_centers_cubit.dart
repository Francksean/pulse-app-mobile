import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:pulse_app_mobile/map/cubits/center/map_centers_state.dart';
import 'package:pulse_app_mobile/map/models/center_position.dart';
import 'package:pulse_app_mobile/map/services/map_service.dart';

class MapCentersCubit extends Cubit<MapCentersState> {
  MapService mapService = MapService();

  MapCentersCubit() : super(MapCentersInitialState());

  Future<void> loadCenters(List<LatLng> corners) async {
    emit(MapCentersLoadingState());
    try {
      List<CenterPosition> centersPositions =
          await mapService.fetchCentersInSquare(corners);
      emit(MapCentersLoadedState(centersPositions: centersPositions));
    } catch (e) {
      emit(MapCentersErrorState(error: e.toString()));
      print(e.toString());
    }
  }
}
