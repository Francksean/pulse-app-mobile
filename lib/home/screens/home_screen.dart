import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/feed/cubit/article_cubit.dart';
import 'package:pulse_app_mobile/home/components/article_card.dart';
import 'package:pulse_app_mobile/home/components/article_card_ghost.dart';
import 'package:pulse_app_mobile/home/cubits/home_article/home_article_cubit.dart';
import 'package:pulse_app_mobile/home/cubits/home_article/home_article_state.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final hommeArticleCubit = context.read<ArticleCubit>();
    hommeArticleCubit.loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 120,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 14),
          child: Text(
            "Articles qui pourrait vous interesser",
            style: TextStyle(
                color: AppColors.black,
                fontSize: FontSizes.lowerBig,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 200,
          child: BlocBuilder<ArticleCubit, ArticleState>(
            builder: (context, state) {
              if (state is ArticleLoadingState ||
                  state is ArticleInitialState) {
                return SizedBox(
                  height: 40,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 14),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Align(
                            alignment: Alignment.topLeft,
                            child: ArticleCardGhost());
                      },
                    ),
                  ),
                );
              } else if (state is ArticleErrorState) {
              } else if (state is ArticleLoadedState) {
                final articles = state.articles;
                return ListView.builder(
                    padding: const EdgeInsets.only(left: 14),
                    scrollDirection: Axis.horizontal,
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final article = articles[index];
                      return Align(
                          alignment: Alignment.topLeft,
                          child: ArticleCard(
                            article: article,
                          ));
                    });
              }
              return const Text("data");
            },
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 14),
          child: Text(
            "Les alertes prêt de votre position",
            style: TextStyle(
                color: AppColors.black,
                fontSize: FontSizes.lowerBig,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "./assets/images/noalert.png",
                height: 300,
                width: 300,
              ),
              const Text("Aucune alerte retrouvée"),
            ],
          ),
        )
      ],
    );
  }
}
