import 'package:flutter/widgets.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';

class ArticleCardGhost extends StatelessWidget {
  const ArticleCardGhost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 170,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 15,
                width: 147,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(999))),
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
            height: 12,
            width: 80,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ],
      ),
    );
  }
}
