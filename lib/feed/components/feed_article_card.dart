import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';
import 'package:pulse_app_mobile/common/utils/custom_utils.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';

class FeedArticleCard extends StatefulWidget {
  final Article article;
  final bool showFullContent;

  const FeedArticleCard({
    super.key,
    required this.article,
    this.showFullContent = false,
  });

  @override
  State<FeedArticleCard> createState() => _FeedArticleCardState();
}

class _FeedArticleCardState extends State<FeedArticleCard> {
  final TextEditingController _commentController = TextEditingController();
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  int _currentIndex = 0;

  bool _isLiked = false;
  String _currentReaction = '';
  final List<String> _reactions = ['👍', '❤️', '👏', '🎉', '🤔', '😢'];
  final bool _showReactions = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildContent(),
            if (widget.article.images != null &&
                widget.article.images!.isNotEmpty)
              _buildImageGallery(),
            _buildInteractionStats(),
            // const Divider(height: 1, thickness: 0.5, color: Colors.grey),
            _buildActionButtons(),
            // _buildCommentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.title ?? 'Untitled',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                // Text(
                //   widget.article.author!.username!,
                //   style: TextStyle(
                //     color: Colors.grey[500],
                //     fontSize: 14,
                //   ),
                // ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      CustomUtils.formatDateDifference(
                          widget.article.publishedDate!, DateTime.now()),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "•",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.public,
                      size: 14,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.article.content!,
            style: const TextStyle(fontSize: 16),
            maxLines: widget.showFullContent ? null : 4,
            overflow: widget.showFullContent
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (!widget.showFullContent &&
              (widget.article.content?.length ?? 0) > 200)
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: const Text('See more'),
            ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    final List<String> images = widget.article.images!
        .map((image) => "http://192.168.1.114:9000/files/$image")
        .toList();
    if (images.isEmpty) return const SizedBox.shrink();
    final length = images.length;

    if (images.length == 1) {
      return Image.network(
        images.first,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250, // Hauteur fixe
      );
    }

    return SizedBox(
      height: 250, // Hauteur fixe
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController, // Utilisez le contrôleur
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                // Mettez à jour l'indice actuel
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: images.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(78, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                "${_currentIndex + 1} / $length", // Affichez l'indice actuel
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 20,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.thumb_up,
                              color: Colors.white, size: 12),
                        ),
                      ),
                      Positioned(
                        left: 12, // 12px = taille icône (12) + padding
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.celebration,
                              color: Colors.white, size: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  // Ajoutez un Expanded pour le texte
                  child: Text(
                    "44",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis, // Gestion du débordement
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8), // Espacement avant le texte de droite
          Text(
            "11 commentaires",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
            label: "J'aime",
            isActive: _isLiked,
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
                if (_isLiked) {
                  _currentReaction = '👍';
                }
              });
            },
          ),
          _buildActionButton(
            icon: Icons.comment_outlined,
            label: "Commenter",
            onPressed: () {
              // Focus on comment field
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
          _buildActionButton(
            icon: Icons.repeat,
            label: "Republier",
            onPressed: () {
              // Repost functionality
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.fillColored,
                title: const Text("Republication !"),
                description: Text(
                    "Vous avez partagé le post de ${widget.article.author!.username}"),
                alignment: Alignment.topCenter,
                autoCloseDuration:
                    const Duration(seconds: 1, milliseconds: 500),
                primaryColor: const Color(0xFFFF1493),
                borderRadius: BorderRadius.circular(12.0),
                showProgressBar: true,
                closeButton:
                    const ToastCloseButton(showType: CloseButtonShowType.none),
                dragToClose: true,
                applyBlurEffect: true,
              );
            },
          ),
          _buildActionButton(
            icon: Icons.send,
            label: "Envoyer",
            onPressed: () async {
              final result = await Share.share(
                  "jette un coup d'oeil à cet article partagé sur pulse https://example.com");

              if (result.status == ShareResultStatus.success) {
                toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.fillColored,
                  title: const Text("Partage !"),
                  description: Text(
                      "Vous avez partagé le post de ${widget.article.author!.username}"),
                  alignment: Alignment.topCenter,
                  autoCloseDuration:
                      const Duration(seconds: 1, milliseconds: 500),
                  primaryColor: const Color(0xFFFF7F50),
                  borderRadius: BorderRadius.circular(12.0),
                  showProgressBar: true,
                  closeButton: const ToastCloseButton(
                      showType: CloseButtonShowType.none),
                  dragToClose: true,
                  applyBlurEffect: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: isActive ? AppColors.red : Colors.grey[600],
        size: 20,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.red : Colors.grey[600],
          fontSize: 12,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      ),
    );
  }
}
