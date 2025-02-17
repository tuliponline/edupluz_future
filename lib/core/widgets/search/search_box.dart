import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class SearchBox extends StatelessWidget {
  FocusNode focusNode;
  TextEditingController textEditingController;
  Function(String)? onSearch;
  bool readOnly;
  bool hasFocus;
  bool autoFocus;
  SearchBox(
      {Key? key,
      required this.focusNode,
      required this.textEditingController,
      required this.onSearch,
      required this.readOnly,
      required this.hasFocus,
      this.autoFocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: ShapeDecoration(
                color: AppColors.primary.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              child: SizedBox(
                height: 48,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) => onSearch?.call(value),
                      controller: textEditingController,
                      focusNode: focusNode,
                      autofocus: autoFocus,
                      readOnly: readOnly,
                      enabled: !readOnly,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'ค้นหา',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600),
                          filled: false,
                          isDense: true),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 52,
            height: 48,
            child: Container(
              width: 52,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: InkWell(
                onTap: () => onSearch?.call(textEditingController.text),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Icon(
                    LucideIcons.search,
                    color: AppColors.primary,
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
