import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/campaign/cubit/campaign_details/campaign_details_cubit.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/feed/components/feed_app_bar.dart';
import 'package:pulse_app_mobile/feed/screens/feed_screen.dart';
import 'package:pulse_app_mobile/home/components/home_app_bar.dart';
import 'package:pulse_app_mobile/home/cubits/home_article/home_article_cubit.dart';
import 'package:pulse_app_mobile/home/screens/home_screen.dart';
import 'package:pulse_app_mobile/map/components/map_app_bar.dart';
import 'package:pulse_app_mobile/map/cubits/center/map_centers_cubit.dart';
import 'package:pulse_app_mobile/map/cubits/center_details/center_details_cubit.dart';
import 'package:pulse_app_mobile/map/screens/map_screen.dart';

class CommonScaffold extends StatefulWidget {
  const CommonScaffold({super.key});

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  var _selectedIndex = 0;

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<PreferredSizeWidget> appBars = [
    const HomeAppBar(),
    const MapAppBar(),
    const FeedAppBar()
  ];
  final List<Widget> pages = [
    const HomeScreen(),
    const MapScreen(),
    const FeedScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: appBars[_selectedIndex],
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeArticleCubit(),
          ),
          BlocProvider(
            create: (context) => MapCentersCubit(),
          ),
          BlocProvider(
            create: (context) => CenterDetailsCubit(),
          ),
        ],
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        elevation: 2,
        onDestinationSelected: _updateSelectedIndex,
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(
                Icons.home_filled,
                color: AppColors.red,
              ),
              icon: Icon(
                Icons.home_outlined,
                color: AppColors.black,
              ),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.map,
                color: AppColors.red,
              ),
              icon: Icon(
                Icons.map_outlined,
                color: AppColors.black,
              ),
              label: "Map"),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.view_agenda,
                color: AppColors.red,
              ),
              icon: Icon(
                Icons.view_agenda,
                color: AppColors.black,
              ),
              label: "Feed"),
        ],
      ),
    );
  }
}
