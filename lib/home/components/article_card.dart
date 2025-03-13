import 'package:flutter/material.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 250,
        color: AppColors.orange,
        margin: const EdgeInsets.only(right: 10));
  }
}
