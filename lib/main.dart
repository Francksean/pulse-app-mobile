import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_app_mobile/appointment/cubit/appointment_creation_cubit.dart';
import 'package:pulse_app_mobile/appointment/screens/create_appointment_screen.dart';
import 'package:pulse_app_mobile/auth/screens/auth_screen.dart';
import 'package:pulse_app_mobile/campaign/cubit/campaign_details/campaign_details_cubit.dart';
import 'package:pulse_app_mobile/campaign/screens/campaign_details_screen.dart';
import 'package:pulse_app_mobile/common/common_scaffold.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/cubits/location/location_cubit.dart';
import 'package:pulse_app_mobile/common/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // GoRouter configuration
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          // builder: (context, state) => const WelcomeScreen(),
          builder: (context, state) => const CommonScaffold(),
        ),
        GoRoute(
          path: "/auth",
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: "/app",
          builder: (context, state) => const CommonScaffold(),
        ),
        GoRoute(
          path: "/campaign/:campaignId",
          builder: (context, state) => CampaignDetailsScreen(
            campaignId: state.pathParameters['campaignId'],
          ),
        ),
        GoRoute(
          path: "/appointment-creation",
          name: "appointment-creation",
          builder: (context, state) => const CreateAppointmentScreen(),
        ),
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationCubit()..fetchLocation(),
        ),
        BlocProvider(
          create: (context) => CampaignDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => AppointmentCreationCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.red, primary: AppColors.lateRed),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
