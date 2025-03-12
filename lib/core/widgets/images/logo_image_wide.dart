import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget logoImageWide() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: AppColors.cardBackground,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Image.asset(
              'assets/logo/logo_brand.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
  );
}
