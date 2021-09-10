import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers.dart';
import 'routes.dart' show onGenerateRoutes;
import 'Utils/ThemeData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Application());
}


class Application extends StatefulWidget {
  const Application({ Key? key }) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModeChanger(ThemeMode.light)), // Default theme mode -> light
        ChangeNotifierProvider(create: (_) => LanguageChanger(const Locale('en', ''))) // Default language -> en
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shopping App",
          initialRoute: "login",
          onGenerateRoute: onGenerateRoutes,
          themeMode: Provider.of<ThemeModeChanger>(context).getThemeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          locale: Provider.of<LanguageChanger>(context).getLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales
        );
      }
    );
  }
}