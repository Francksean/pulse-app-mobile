import 'package:flutter/material.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/map/models/alert.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class AlertSection extends StatefulWidget {
  final Alert alert;

  const AlertSection({super.key, required this.alert});

  @override
  _AlertSectionState createState() => _AlertSectionState();
}

class _AlertSectionState extends State<AlertSection> {
  bool hasResponded = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final daysRemaining =
        widget.alert.deadLine!.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.red),
              const SizedBox(width: 8),
              const Text(
                'Alerte Besoin Urgent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.alert.bloodType.toString().split('.').last,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Date limite: ${dateFormat.format(widget.alert.deadLine!)}',
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Il reste $daysRemaining jours',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (!hasResponded) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: AppColors.red,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Concernant l'alerte",
                                  style: TextStyle(
                                    fontSize: FontSizes.large,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text.rich(
                              TextSpan(
                                text:
                                    "En répondant à cette alerte, vous recevrez des informations par mail ou des notifications. ",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: FontSizes.upperMedium,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "Vous recevrez votre ordre de rendez-vous dans les plus brefs délais.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.success,
                                    style: ToastificationStyle.fillColored,
                                    title: const Text(
                                        "Réponse à l'alerte envoyée"),
                                    description: const Text(
                                        "Merci pour votre engagement à sauver des vies ! "),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration:
                                        const Duration(seconds: 4),
                                    primaryColor: AppColors.orange,
                                    borderRadius: BorderRadius.circular(12.0),
                                    showProgressBar: true,
                                    closeButton: const ToastCloseButton(
                                        showType: CloseButtonShowType.none),
                                    dragToClose: true,
                                    applyBlurEffect: true,
                                  );
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Accepter",
                                  style: TextStyle(
                                    fontSize: FontSizes.medium,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                setState(() {
                  hasResponded = true;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: hasResponded ? Colors.grey : Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(hasResponded
                ? "Merci pour votre geste"
                : 'Répondre à l\'alerte'),
          ),
        ],
      ),
    );
  }
}
