import 'package:flutter/material.dart';
import 'package:pulse_app_mobile/feed/components/feed_article_card.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';
import 'package:pulse_app_mobile/feed/models/author.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: FeedArticleCard(
          article: Article(
              id: "2",
              title: "Introduction à Flutter",
              author: Author(id: "FCSYTSZT", username: "Franck Sean"),
              content:
                  "Flutter est un framework open-source développé par Google pour créer des applications multiplateformes.",
              postedOn: DateTime(2023 - 09 - 25),
              coverUrl: "https://example.com/flutter.jpg",
              images: [
            "https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg?auto=compress&cs=tinysrgb&w=600",
            "https://images.pexels.com/photos/1387037/pexels-photo-1387037.jpeg?auto=compress&cs=tinysrgb&w=600"
          ])),
    );
  }
}
