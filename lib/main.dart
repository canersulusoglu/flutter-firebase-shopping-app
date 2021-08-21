import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//Screens
import 'Utils/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shopping App",
        initialRoute: "login",
        onGenerateRoute: onGenerateRoutes,
      );
  }
}
