import 'package:edupluz_future/app.dart';
import 'package:flutter/material.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String languageCode) {
        final newLocale = Locale(languageCode);
        App.setLocale(context, newLocale);
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        const PopupMenuItem(
          value: 'th',
          child: Text('ไทย'),
        ),
      ],
    );
  }
}
