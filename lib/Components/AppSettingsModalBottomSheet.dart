// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers.dart';

class AppSettingsModalBottomSheet extends StatefulWidget {
  const AppSettingsModalBottomSheet({ Key? key }) : super(key: key);

  @override
  _AppSettingsModalBottomSheetState createState() => _AppSettingsModalBottomSheetState();
}

class _AppSettingsModalBottomSheetState extends State<AppSettingsModalBottomSheet> {
  late bool isDarkMode;
  late String language;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ThemeModeChanger>(context, listen: false).getThemeMode == ThemeMode.dark;
    language = Provider.of<LanguageChanger>(context, listen: false).getLocale.toString();
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode: ", style: TextStyle(fontSize: 18,)),
              Switch(
                value: isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    isDarkMode = value;
                    Provider.of<ThemeModeChanger>(context, listen: false).setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  });
                }
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Language: ", style: TextStyle(fontSize: 18,)),
              DropdownButton<String>(
                value: language,
                onChanged: (value){
                  setState(() {
                    language = value!;
                    Provider.of<LanguageChanger>(context, listen: false).setLocale(Locale.fromSubtags(languageCode: value));
                  });
                },
                //elevation: 5,
                items: AppLocalizations.supportedLocales
                .map<DropdownMenuItem<String>>((Locale value) {
                  return DropdownMenuItem<String>(
                    value: value.languageCode,
                    child: Text(AppLocalizations.of(context)!.language(value.languageCode)),
                  );
                }).toList(),
                hint: const Text(
                  "Please choose a langauage",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showAppSettingsModalBottomSheet(context){
  showModalBottomSheet(context: context, builder: (BuildContext context){
    return const AppSettingsModalBottomSheet();
  });
}