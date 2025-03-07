import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ProfileAvatar extends StatelessWidget {
  String? imageUrl;
  File? imageFile;
  bool editEnable;
  Function()? onTap;
  ProfileAvatar(
      {super.key,
      this.imageUrl,
      this.onTap,
      this.editEnable = false,
      this.imageFile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: editEnable
                    ? AppColors.background
                    : Colors
                        .transparent, // Change this to your desired border color
                width: 3.0, // Change this to your desired border width
              ),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.background,
              radius: 50.0,
              backgroundImage: imageFile == null
                  ? imageUrl == null
                      ? null
                      : CachedNetworkImageProvider(
                          imageUrl!,
                        )
                  : FileImage(imageFile!) as ImageProvider,
              child: imageUrl == null
                  ? const Icon(
                      LucideIcons.user,
                      size: 50.0,
                      color: AppColors.primary,
                    )
                  : null,
            ),
          ),
          if (editEnable)
            Positioned(
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: onTap,
                  child: const CircleAvatar(
                      backgroundColor: AppColors.background,
                      radius: 12,
                      child: Icon(
                        LucideIcons.camera,
                        size: 20,
                        color: AppColors.primary,
                      )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
