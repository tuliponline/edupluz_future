import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  Widget? prefix;
  Widget? suffix;
  AppBarWidget({
    super.key,
    required this.title,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: prefix,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: AppTextStyles.h4,
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                height: 48,
                child: suffix,
              ),
            ],
          )
        ],
      ),
    );
  }
}
