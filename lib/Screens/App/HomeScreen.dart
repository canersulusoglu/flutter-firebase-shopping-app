// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({ Key? key }) : super(key: key);

  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
        children: [
          const Text("Home Screen"),
          Text(AppLocalizations.of(context)!.helloWorld),
        ],
      )),
    );
  }
}
