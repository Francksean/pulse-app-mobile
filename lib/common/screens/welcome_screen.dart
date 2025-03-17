import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_app_mobile/common/components/gradient_text.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_cubit.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_state.dart';
import 'package:pulse_app_mobile/common/database/hive_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          // await HiveService.ensureInitialized();
          // final hiveService = HiveService();
          // if (state is LocationLoadedState) {
          //   if (hiveService.getUsername() != null &&
          //       hiveService.getToken() != null) {
          context.go("/app");
          // }
          // context.push("/auth");
          // }
        },
        child: Container(
          decoration: const BoxDecoration(color: AppColors.white),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/welcome-screen-up.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/images/pulse-app-logo.svg",
                          width: 128,
                          height: 128,
                        ),
                        const GradientText(
                          style: TextStyle(
                              fontSize: FontSizes.upperBig,
                              fontWeight: FontWeight.bold),
                          "PULSE",
                          gradient: LinearGradient(
                              colors: [AppColors.red, AppColors.orange]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/welcome-screen-down.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Copyright 2025  - Franck DJISSOU",
                  style: TextStyle(
                      color: AppColors.white, fontSize: FontSizes.medium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
