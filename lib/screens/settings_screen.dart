import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/constants/language_names.dart';
import 'package:weather/core/extensions/l10n_extensions.dart';
import 'package:weather/core/providers/locale_provider.dart';
import 'package:weather/services/prefs_service.dart';
import 'package:weather/utils/alerts.dart';
import 'package:weather/widgets/bottom_navigation_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      bottomNavigationBar: MainNavigationBar(currentIndex: 2),
      body: ListView(
        children: [
          ListTile(
            title: Text(context.l10n.clearFavorites),
            subtitle: Text(context.l10n.clearFavoritesDesc),
            textColor: Colors.red,
            onTap: () {
              showConfirmation(
                context,
                context.l10n.clearFavoritesConfirm,
                () {
                  PrefsService.saveFavorites([]);
                },
              );
            },
          ),
          ListTile(
            title: Text(context.l10n.language),
            subtitle: Text(_languageTileDesc(context, PrefsService.getLocale(), Provider.of<LocaleProvider>(context).locale.toString())),
            onTap: () {showModalBottomSheet(context: context,
            builder: (context) {
              return ListView(children: [
                ListTile(title: Text(context.l10n.systemLang), onTap: () {changeLang('system', context);}),
                ListTile(title: Text(languageNames['ru']!), onTap: () {changeLang('ru', context);}),
                ListTile(title: Text(languageNames['en']!), onTap: () {changeLang('en', context);})
              ],);
            }
            );
            }
          ),
        ],
      ),
    );
  }
}

String _languageTileDesc(
  BuildContext context,
  String settingValue,
  String userLang,
) {
  if (settingValue == 'system') {
    return context.l10n.systemLang;
  } else {
    return languageNames[userLang] ?? '';
  }
}

void changeLang(String lang, BuildContext context) {
  context.read<LocaleProvider>().setLocale(Locale(lang));
  PrefsService.saveLocale(lang);
  Navigator.pop(context);
}