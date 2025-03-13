import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/common/models/user.dart';
import 'package:pulse_app_mobile/map/cubits/center_details/center_details_state.dart';
import 'package:pulse_app_mobile/map/models/alert.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_brief.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';

class CenterDetailsCubit extends Cubit<CenterDetailsState> {
  CenterDetailsCubit() : super(CenterDetailsInitialState());

  // Méthode pour charger les détails du centre
  Future<void> loadCenterDetails(String centerId) async {
    emit(CenterDetailsLoadingState());

    try {
      // Simuler une requête asynchrone (remplacez par votre logique réelle)
      // await Future.delayed(const Duration(seconds: 2));

      // Exemple de données simulées
      final centerDetails = CenterDetails(
        centerId: centerId,
        centerName: 'Centre Principal',
        bannerUrl: 'https://example.com/banner.jpg',
        logoUrl: 'https://example.com/logo.png',
        phone: "675321836",
        isOpen: true,
        activeAlert: Alert(
          launchDate: DateTime.now(),
          deadLine: DateTime.now().add(const Duration(days: 7)),
          bloodType: BloodType.oPos,
        ),
        activeCampaign: CampaignBrief(
          launchDate: DateTime.now(),
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 30)),
          title: 'Campagne de don de sang',
          description: 'Participez à notre campagne de don de sang !',
        ),
      );

      emit(CenterDetailsLoadedState(centerDetails));
    } catch (e) {
      emit(const CenterDetailsErrorState(
          'Erreur lors du chargement des détails du centre'));
    }
  }
}
