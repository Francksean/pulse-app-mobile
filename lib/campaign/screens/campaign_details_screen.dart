import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/campaign/cubit/campaign_details/campaign_details_cubit.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/campaign/enums/campaign_status.dart';

class CampaignDetailsScreen extends StatefulWidget {
  final String? campaignId;
  final String? centerName;
  const CampaignDetailsScreen(
      {super.key, required this.campaignId, required this.centerName});
  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final campaignDetailsCubit = context.read<CampaignDetailsCubit>();
    campaignDetailsCubit.fetchCampaignDetails(widget.campaignId!);
  }

  String getStatusText(CampaignStatus status) {
    switch (status) {
      case CampaignStatus.ACTIVE:
        return 'Active';
      case CampaignStatus.UPCOMING:
        return 'À venir';
      case CampaignStatus.COMPLETED:
        return 'Terminée';
      case CampaignStatus.CANCELLED:
        return 'Annulée';
    }
  }

  Color getStatusColor(CampaignStatus status) {
    switch (status) {
      case CampaignStatus.ACTIVE:
        return Colors.teal.shade400;
      case CampaignStatus.UPCOMING:
        return Colors.blue.shade400;
      case CampaignStatus.COMPLETED:
        return Colors.grey.shade600;
      case CampaignStatus.CANCELLED:
        return Colors.red.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Détails de la campagne",
          style: TextStyle(color: AppColors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
      ),
      body: BlocBuilder<CampaignDetailsCubit, CampaignDetailsState>(
        builder: (context, state) {
          if (state is CampaignDetailsLoadingState) {
            // return _buildShimmerLoading();
            return const Center(child: CircularProgressIndicator());
          } else if (state is CampaignDetailsLoadedState) {
            final campaign = state.campaignDetails;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    "https://images.ctfassets.net/h8qzhh7m9m8u/2DqO6wap1WDkhNyCs8Pb94/b6cd52230589861dca85927d04eef945/2100x1200_blood-donor.jpg?fm=webp&w=2100&h=1200&fit=fill&bg=rgb:FFFFFF&q=80",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              AppColors.black,
                                              Color.fromARGB(133, 76, 76, 76),
                                              Colors.transparent,
                                            ])),
                                  )),
                              Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          overflow: TextOverflow.ellipsis,
                                          campaign.title!,
                                          style: const TextStyle(
                                              fontSize: FontSizes.upperExtra,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const CircleAvatar(
                                            maxRadius: 10,
                                            backgroundImage: NetworkImage(
                                                "https://static.vecteezy.com/ti/vecteur-libre/t1/4493181-hopital-batiment-pour-soins-de-sante-fond-vector-illustration-avec-ambulance-voiture-medecin-patient-infirmieres-et-clinique-medicale-exterieur-gratuit-vectoriel.jpg"),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(widget.centerName!,
                                              style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontSize:
                                                      FontSizes.upperLarge,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Descriptif de cette campagne",
                                style: TextStyle(
                                    fontSize: FontSizes.big,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black),
                              ),
                              const Divider(
                                thickness: 1,
                                color: AppColors.borderGrey,
                              ),
                              Text(
                                  maxLines: 8,
                                  style: const TextStyle(
                                      fontSize: FontSizes.lowerBig,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w300),
                                  campaign.description!)
                            ],
                          ),
                          // Ajouter un espace supplémentaire pour éviter que le contenu ne soit caché par le bouton
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
                // Bouton en bas de l'écran avec largeur complète
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // showDialog(
                      //     context: context, builder: (context) {
                      //       return
                      //     });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity,
                          50), // Pour assurer une hauteur minimale
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.ads_click_sharp),
                        SizedBox(
                          width: 5,
                        ),
                        Text("S'enrôler pour la campagne")
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CampaignDetailsErrorState) {
            // return _buildErrorState(state.error);
            return Center(
              child: Text(
                "Une erreur s'est produite",
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 16,
                ),
              ),
            );
          }
          return Center(
            child: Text(
              "État inconnu",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
