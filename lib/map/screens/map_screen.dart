import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pulse_app_mobile/common/components/custom_bottom_sheet.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_cubit.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_state.dart';
import 'package:pulse_app_mobile/map/components/center_details_widget.dart';
import 'package:pulse_app_mobile/map/cubits/center/map_centers_cubit.dart';
import 'package:pulse_app_mobile/map/cubits/center/map_centers_state.dart';
import 'package:pulse_app_mobile/map/cubits/center_details/center_details_cubit.dart';
import 'package:pulse_app_mobile/map/cubits/center_details/center_details_state.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';
import 'package:pulse_app_mobile/map/utils/map_utils.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    // Move your initialization code here
    final mapCenterCubit = context.read<MapCentersCubit>();
    final locationState = context.read<LocationCubit>().state;
    if (locationState is LocationLoadedState) {
      final center = LatLng(
          locationState.location.latitude!, locationState.location.longitude!);
      List<LatLng> corners = MapUtils.getSquareCorners(center, 1);
      print(corners);
      mapCenterCubit.loadCenters(corners);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoadedState) {
          final initialLongitude = state.location.longitude!;
          final initialLatitude = state.location.latitude!;
          return FlutterMap(
            options: MapOptions(
                initialZoom: 15,
                minZoom: 3,
                initialCenter: LatLng(initialLatitude, initialLongitude)),
            children: [
              openStreetMapTileLayer,
              BlocBuilder<MapCentersCubit, MapCentersState>(
                builder: (context, state) {
                  // Initial marker
                  final initialMarker = Marker(
                    point: LatLng(initialLatitude, initialLongitude),
                    // height: 50,
                    // width: 50,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.orange,
                      size: 36,
                    ),
                  );

                  List<Marker> markers = [initialMarker];

                  if (state is MapCentersLoadedState) {
                    markers.addAll(
                      state.centersPositions.map(
                        (element) => Marker(
                          point: LatLng(element.latitude!, element.longitude!),
                          rotate: false,
                          child: GestureDetector(
                            onTap: () {
                              final centerDetailsCubit =
                                  context.read<CenterDetailsCubit>();
                              centerDetailsCubit.loadCenterDetails("");
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocProvider(
                                    create: (context) => CenterDetailsCubit()
                                      ..loadCenterDetails(""),
                                    child: CustomBottomSheet(
                                      child: BlocBuilder<CenterDetailsCubit,
                                          CenterDetailsState>(
                                        builder: (context, state) {
                                          if (state
                                              is CenterDetailsLoadingState) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (state
                                              is CenterDetailsLoadedState) {
                                            return CenterDetailsWidget(
                                                centerDetails:
                                                    state.centerDetails);
                                          }
                                          return const Center(
                                              child: Text(
                                                  "Aucune donnée disponible"));
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              // width: 100,
                              // height: 100,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.add_circle_rounded,
                                color: AppColors.red,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return MarkerLayer(markers: markers);
                },
              )
            ],
          );
        }
        return FlutterMap(
          options: const MapOptions(
              // initialCenter: LatLng(initalLatitude, initalLongititude)
              ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
          ],
        );
      },
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
