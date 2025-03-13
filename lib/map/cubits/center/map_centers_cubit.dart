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
      // List<CenterPosition> centersPositions =
      //     await mapService.fetchCentersInSquare(corners);
      emit(MapCentersLoadedState(centersPositions: [
        CenterPosition(
          centerId: 'C001',
          centerName: 'Centre 1',
          latitude: 4.034652,
          longitude: 9.771823,
        ),
        CenterPosition(
          centerId: 'C002',
          centerName: 'Centre 2',
          latitude: 4.029378,
          longitude: 9.768943,
        ),
        CenterPosition(
          centerId: 'C003',
          centerName: 'Centre 3',
          latitude: 4.040127,
          longitude: 9.775618,
        ),
        CenterPosition(
          centerId: 'C004',
          centerName: 'Centre 4',
          latitude: 4.027361,
          longitude: 9.773290,
        ),
        CenterPosition(
          centerId: 'C005',
          centerName: 'Centre 5',
          latitude: 4.031957,
          longitude: 9.767021,
        ),
        CenterPosition(
          centerId: 'C006',
          centerName: 'Centre 6',
          latitude: 4.042814,
          longitude: 9.778654,
        ),
        CenterPosition(
          centerId: 'C007',
          centerName: 'Centre 7',
          latitude: 4.036789,
          longitude: 9.772567,
        ),
        CenterPosition(
          centerId: 'C008',
          centerName: 'Centre 8',
          latitude: 4.026453,
          longitude: 9.769872,
        ),
        CenterPosition(
          centerId: 'C009',
          centerName: 'Centre 9',
          latitude: 4.038426,
          longitude: 9.776431,
        ),
        CenterPosition(
          centerId: 'C010',
          centerName: 'Centre 10',
          latitude: 4.033145,
          longitude: 9.774296,
        ),
      ]));
    } catch (e) {
      emit(MapCentersErrorState(error: e.toString()));
      print(e.toString());
    }
  }
}
