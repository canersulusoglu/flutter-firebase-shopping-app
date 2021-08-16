import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//Screens
import 'Screens/Auth/LoginScreen.dart' show LoginScreen;
import 'Screens/Auth/RegisterScreen.dart' show RegisterScreen;
import 'Screens/MainScreen.dart' show MainScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Shopping App",
        initialRoute: "/login",
        routes: <String, WidgetBuilder>{
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/main': (context) => const MainScreen(),
        }
      );
  }
}
