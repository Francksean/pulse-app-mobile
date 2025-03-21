import 'package:flutter/material.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';

class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FeedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      scrolledUnderElevation: 0.0,
      title: const Text(
        "Fil d'actualités",
        style: TextStyle(
            fontSize: FontSizes.extra,
            color: AppColors.black,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.white,
              Color.fromARGB(169, 255, 255, 255),
              Color.fromARGB(103, 255, 255, 255),
              Color.fromARGB(0, 255, 255, 255)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
