import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:pulse_app_mobile/map/cubits/center/map_centers_state.dart';
import 'package:pulse_app_mobile/map/models/center_position.dart';
import 'package:pulse_app_mobile/map/services/map_service.dart';

class MapCentersCubit extends Cubit<MapCentersState> {
  MapService mapService = MapService();
  final Map<String, CenterPosition> _existingCentersMap = {};
  bool _isFirstLoad = true;

  MapCentersCubit() : super(MapCentersInitialState());

  Future<void> loadCenters(List<LatLng> corners) async {
    // Only emit loading state on first load to prevent UI flickering
    if (_isFirstLoad) {
      emit(MapCentersLoadingState());
      _isFirstLoad = false;
    }

    try {
      List<CenterPosition> newCenters =
          await mapService.fetchCentersInSquare(corners);

      // Add new centers to the map without duplicates
      for (var center in newCenters) {
        if (center.id != null) {
          _existingCentersMap[center.id!.toString()] = center;
        }
      }

      // Convert map values to list for the state
      List<CenterPosition> allCenters = _existingCentersMap.values.toList();

      emit(MapCentersLoadedState(centersPositions: allCenters));
    } catch (e) {
      emit(MapCentersErrorState(error: e.toString()));
      print(e.toString());
    }
  }

  void resetCenters() {
    _existingCentersMap.clear();
    _isFirstLoad = true;
    emit(MapCentersInitialState());
  }
}
