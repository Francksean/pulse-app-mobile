import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:pulse_app_mobile/map/components/alert_section.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_brief.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CenterDetailsWidget extends StatelessWidget {
  final CenterDetails centerDetails;

  const CenterDetailsWidget({
    super.key,
    required this.centerDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Banner image with logo overlay
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Banner
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://static.vecteezy.com/ti/vecteur-libre/t1/3623626-coucher-de-soleil-lac-paysage-illustration-gratuit-vectoriel.jpg"),
                  // image: NetworkImage(centerDetails.bannerUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Logo
            Positioned(
              bottom: -30,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.add_circle_outlined,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ),
            // Status indicator
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Ouvert',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Spacing for logo overflow
        const SizedBox(height: 35),

        // Center name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            centerDetails.centerSubDetails!.name!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Active Alert Section
        if (centerDetails.activeAlert != null)
          AlertSection(alert: centerDetails.activeAlert!),

        const SizedBox(height: 16),

        // Active Campaign Section
        if (centerDetails.activeCampaign != null)
          _buildCampaignSection(context, centerDetails.activeCampaign!,
              centerDetails.centerSubDetails!.name!),

        const SizedBox(height: 20),

        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                        "/appointment-creation/${centerDetails.centerSubDetails!.id}/${centerDetails.centerSubDetails!.name}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Prendre RDV'),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () async {
                  await launchUrlString(
                      "tel:${centerDetails.centerSubDetails!.phone}");
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.orange,
                  side: const BorderSide(color: AppColors.orange),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.phone),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  // Action pour l'itinéraire
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.orange,
                  side: const BorderSide(color: AppColors.orange),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.directions),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignSection(
      BuildContext context, CampaignBrief campaign, String centername) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.campaign_rounded, color: AppColors.orange),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  campaign.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            campaign.description!,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                'Du ${dateFormat.format(campaign.startDate!)} au ${dateFormat.format(campaign.endDate!)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              context.push('/campaign/${campaign.id}/$centername');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.orange,
              side: const BorderSide(color: AppColors.orange),
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Voir les détails'),
          ),
        ],
      ),
    );
  }
}
