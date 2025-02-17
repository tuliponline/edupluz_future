import 'package:edupluz_future/core/enums/courses_enum.dart';
import 'package:edupluz_future/core/enums/enum_language.dart';
import 'package:edupluz_future/core/providers/language_provider.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_bar/appbar_widget.dart';
import 'package:edupluz_future/features/profile/data/fetch_orders.dart';
import 'package:edupluz_future/features/profile/domain/orders_model.dart';
import 'package:edupluz_future/features/profile/presentation/widget/card_order_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagePage extends ConsumerStatefulWidget {
  const LanguagePage({super.key});

  @override
  ConsumerState<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguagePage> {
  OrdersModel? ordersData;
  String selectedLanguage = 'th';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedLanguage = ref.watch(languageProvider).name;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              prefix: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  LucideIcons.arrow_left,
                  color: AppColors.textPrimary,
                ),
              ),
              title:
                  "${ref.watch(languageProvider) == LanguageEnum.th ? "เปลี่ยนภาษา" : "Change Language"}",
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildLanguageOption('ไทย', 'th'),
                  const SizedBox(height: 8),
                  _buildLanguageOption('English', 'en'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String label, String value) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedLanguage = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        child: Row(
          children: [
            const Icon(Icons.language, color: AppColors.textPrimary),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.bodyLarge,
            ),
            const Spacer(),
            Radio<String>(
              value: value,
              groupValue: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  ref.read(languageProvider.notifier).state =
                      newValue == "th" ? LanguageEnum.th : LanguageEnum.en;
                  selectedLanguage = newValue!;
                });
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
