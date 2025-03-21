import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/feed/components/feed_article_card.dart';
import 'package:pulse_app_mobile/feed/cubit/article_cubit.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    // Charger les articles au démarrage de l'écran
    final articleCubit = context.read<ArticleCubit>();
    articleCubit.loadArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Utiliser BlocBuilder pour écouter les changements d'état du ArticleCubit
          BlocBuilder<ArticleCubit, ArticleState>(
            builder: (context, state) {
              if (state is ArticleLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ArticleLoadedState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      return FeedArticleCard(article: state.articles[index]);
                    },
                  ),
                );
              } else if (state is ArticleErrorState) {
                return Center(child: Text("Erreur : ${state.errorMessage}"));
              } else {
                // État initial ou non géré
                return const Center(child: Text("Aucune donnée disponible"));
              }
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(30.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {
                  context.push("/create/article");
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
