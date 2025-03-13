import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/constants/app_font_sizes.dart';
import 'package:pulse_app_mobile/home/components/article_card.dart';
import 'package:pulse_app_mobile/home/components/article_card_ghost.dart';
import 'package:pulse_app_mobile/home/cubits/home_article/home_article_cubit.dart';
import 'package:pulse_app_mobile/home/cubits/home_article/home_article_state.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // @override
  void initState(BuildContext context) {
    final hommeArticleCubit = context.read<HomeArticleCubit>();
    hommeArticleCubit.fetchArticles();
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
          child: BlocBuilder<HomeArticleCubit, HomeArticleState>(
            builder: (context, state) {
              if (state is LoadingState || state is InitialHomeArticleState) {
                return SizedBox(
                  height: 40,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
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
              } else if (state is ErrorState) {
              } else if (state is HomeArticleLoadedState) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return const Align(
                          alignment: Alignment.topLeft, child: ArticleCard());
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
      ],
    );
  }
}
