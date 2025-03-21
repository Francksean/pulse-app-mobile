import 'package:flutter/material.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 170, // Définir la largeur du container parent
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 170,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
              child: Image.network(
                fit: BoxFit.cover,
                "http://192.168.1.114:9000/files/${article.images!.first}",
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 170, // Forcer la Row à prendre toute la largeur disponible
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  // Permet au texte de prendre tout l'espace disponible
                  child: Text(
                    article.title!,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontSize: FontSizes.upperMedium),
                    overflow:
                        TextOverflow.ellipsis, // Gère le débordement du texte
                  ),
                ),
                const SizedBox(
                    width: 5), // Un peu d'espace entre le texte et l'avatar
                const CircleAvatar(
                  radius: 10,
                  child: Text(
                    "👨",
                    style: TextStyle(fontSize: FontSizes.small),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text.rich(TextSpan(
              text: "Publié le : ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: FontSizes.upperMedium),
              children: [
                TextSpan(
                  text: DateFormat('dd/MM/yyyy').format(article.publishedDate!),
                )
              ]))
        ],
      ),
    );
  }
}
