import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/dialogs/promition_dialog.dart';
import 'package:edupluz_future/features/discover/data/fetch_image_promotion.dart';
import 'package:edupluz_future/features/discover/data/fetch_promotion.dart';
import 'package:edupluz_future/features/discover/domain/promotion_model.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardPromotion extends StatefulWidget {
  const CardPromotion({super.key});

  @override
  State<CardPromotion> createState() => _CardPromotionState();
}

class _CardPromotionState extends State<CardPromotion> {
  PromotionModel? promotion;
  String image = '';

  _fetchPromotion() async {
    promotion = await fetchPromotion();
    Logger().d("promotion $promotion");
    image = await fetchImagePromotion(promotion?.data.image ?? "");
    setState(() {});
  }

  @override
  initState() {
    _fetchPromotion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (promotion == null)
        ? _loading()
        : promotion?.data.status == "published"
            ? InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => PromotionDialog(
                      title: promotion!.data.popUpTitle,
                      description: promotion!.data.popUpDescription,
                    ),
                  );
                },
                child: Container(
                  height: 116,
                  padding: const EdgeInsets.only(
                      top: 8, left: 24, right: 8, bottom: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: AppColors.buttonSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: AppColors.cardShadow,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                promotion!.data.title,
                                style: AppTextStyles.h2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              child: Text(
                                promotion!.data.descriptionn,
                                style: AppTextStyles.bodySmall,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) => Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              color: AppColors.background,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
  }

  Widget _loading() {
    return Skeletonizer(
      child: Container(
        height: 116,
        padding: const EdgeInsets.only(top: 8, left: 24, right: 8, bottom: 8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.buttonSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: Offset(4, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      'ส่วนลดสูงสุด 40%',
                      style: AppTextStyles.h2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    child: Text(
                      'รับเลยส่วนลดสูงสุด 40% เมื่อสมัครแพ็กเกจรายปีครั้งแรก',
                      style: AppTextStyles.bodySmall,
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(5),
                width: 100,
                height: 100,
                decoration: const BoxDecoration(),
                child: Container(
                  width: 80,
                  height: 80,
                  color: AppColors.iconSecondary,
                )),
          ],
        ),
      ),
    );
  }
}
