import 'package:flutter/material.dart';
import '../Services/auth_service.dart' show AuthService;
//Screens
import 'Screens/Auth/LoginScreen.dart' show LoginScreen;
import 'Screens/Auth/RegisterScreen.dart' show RegisterScreen;
import 'Screens/AppScreen.dart' show AppScreen;
import 'Screens/AccountScreen.dart' show AppAccountScreen;

const routeAuthLoginPage = 'login';
const routeAuthRegisterPage = 'register';
const routeAppPage = "app";
const routeAccountPage = "account";


MaterialPageRoute<dynamic> onGenerateRoutes (RouteSettings settings){
  late Widget page;
  String routeName = settings.name!;
  
  if(!AuthService.instance.isUserLoggedIn){
    if(routeName == routeAuthLoginPage){
      page = const LoginScreen();
    }
    else if(routeName == routeAuthRegisterPage){
      page = const RegisterScreen();
    }
    else{
      page = const LoginScreen();
    }
  }else{
    if(routeName == routeAppPage){
      page = const AppScreen();
    }
    else if(routeName.startsWith(routeAccountPage)){
      final subRoute = routeName.substring(routeAccountPage.length);
      page = AppAccountScreen(subRouteName: subRoute);
    }
    else{
      page = const AppScreen();
    }
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}