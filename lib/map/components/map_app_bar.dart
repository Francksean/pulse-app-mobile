import 'package:flutter/material.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Carte",
        style: TextStyle(
            fontSize: FontSizes.extra,
            color: AppColors.black,
            fontWeight: FontWeight.bold),
      ),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
