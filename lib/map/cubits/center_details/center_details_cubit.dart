import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/common/models/user.dart';
import 'package:pulse_app_mobile/map/cubits/center_details/center_details_state.dart';
import 'package:pulse_app_mobile/map/models/alert.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_brief.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';
import 'package:pulse_app_mobile/map/services/map_service.dart';

class CenterDetailsCubit extends Cubit<CenterDetailsState> {
  final mapService = MapService();
  CenterDetailsCubit() : super(CenterDetailsInitialState());

  // Méthode pour charger les détails du centre
  Future<void> loadCenterDetails(int centerId) async {
    print("center ID : $centerId");
    emit(CenterDetailsLoadingState());

    try {
      CenterDetails centerDetails =
          await mapService.fetchCenterDetails(centerId.toString());

      emit(CenterDetailsLoadedState(centerDetails));
    } catch (e) {
      emit(const CenterDetailsErrorState(
          'Erreur lors du chargement des détails du centre'));
    }
  }
}
