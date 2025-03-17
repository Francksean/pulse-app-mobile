import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_cubit.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_state.dart';
import 'package:shimmer/shimmer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: const Text(
        "Hello !",
        style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.extra,
            fontWeight: FontWeight.bold),
      ),
      leadingWidth: 100,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Franck Sean"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.my_location_outlined,
                      color: AppColors.orange,
                      size: 11,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoadedState) {
                          return Text(
                            "${state.location.city}, ${state.location.conuntry}",
                            style: const TextStyle(
                                fontSize: FontSizes.medium,
                                color: AppColors.orange),
                          );
                        } else if (state is LocationLoadingState) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 11,
                              color: AppColors.white,
                            ),
                          );
                        }
                        return const Text(
                          "Paris, France",
                          style: TextStyle(
                              fontSize: FontSizes.medium,
                              color: AppColors.orange),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            const CircleAvatar(
              backgroundColor: AppColors.orange,
              child: Icon(
                Icons.person_outline_rounded,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
