import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
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
import 'package:pulse_app_mobile/map/utils/map_utils.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(seconds: 1, milliseconds: 500),
    curve: Curves.easeInOut,
    cancelPreviousAnimations: true,
  );

  late LatLngBounds _visibleBounds;

  final double _defaultZoom = 12.0;
  final double _markerZoom = 15.0;

  @override
  void initState() {
    super.initState();
    // Initialisation des centres à proximité
    final mapCenterCubit = context.read<MapCentersCubit>();
    final locationState = context.read<LocationCubit>().state;
    if (locationState is LocationLoadedState) {
      final center = LatLng(
          locationState.location.latitude!, locationState.location.longitude!);
      List<LatLng> corners = MapUtils.getSquareCorners(center, 10);
      mapCenterCubit.loadCenters(corners);
    }

    _visibleBounds = LatLngBounds(
      const LatLng(-90, -180), // Coin sud-ouest
      const LatLng(90, 180), // Coin nord-est
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoadedState) {
          final initialLongitude = state.location.longitude!;
          final initialLatitude = state.location.latitude!;

          return FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              initialZoom: _defaultZoom,
              minZoom: 3,
              initialCenter: LatLng(initialLatitude, initialLongitude),
              // Surveiller les mouvements de la carte
              onMapEvent: (MapEvent event) {
                if (event is MapEventMoveEnd) {
                  _updateVisibleBounds();
                }
              },
            ),
            children: [
              openStreetMapTileLayer,
              BlocBuilder<MapCentersCubit, MapCentersState>(
                builder: (context, state) {
                  // Marqueur initial
                  final initialMarker = Marker(
                    point: LatLng(initialLatitude, initialLongitude),
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
                              _animateToMarker(LatLng(
                                  element.latitude!, element.longitude!));

                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocProvider(
                                    create: (context) => CenterDetailsCubit()
                                      ..loadCenterDetails(element.id!),
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
                            child: Image.asset(
                              "./assets/images/pincenter.png", // URL de l'icône
                              width: 100, // Largeur de l'image
                              height: 100, // Hauteur de l'image
                              fit: BoxFit.cover, // Ajuster l'image
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
          options: const MapOptions(),
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

  void _animateToMarker(LatLng markerPosition) {
    _animatedMapController.centerOnPoint(
      markerPosition,
      zoom: _markerZoom,
      customId: 'marker_animation',
    );
  }

  void _updateVisibleBounds() {
    _visibleBounds = _animatedMapController.mapController.camera.visibleBounds;

    final minLat = _visibleBounds.south;
    final minLng = _visibleBounds.west;
    final maxLat = _visibleBounds.north;
    final maxLng = _visibleBounds.east;

    print(
        'Limites visibles de la carte: minLat: $minLat, minLng: $minLng, maxLat: $maxLat, maxLng: $maxLng');

    _loadCentersInVisibleArea(minLat, minLng, maxLat, maxLng);
  }

  void _loadCentersInVisibleArea(
      double minLat, double minLng, double maxLat, double maxLng) {
    List<LatLng> corners = [
      LatLng(minLat, minLng), // Coin sud-ouest
      LatLng(maxLat, maxLng), // Coin nord-est
    ];

    final mapCenterCubit = context.read<MapCentersCubit>();
    mapCenterCubit.loadCenters(corners);
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
