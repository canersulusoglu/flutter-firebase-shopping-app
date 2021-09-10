import 'package:flutter/material.dart';
import 'package:flutter_firebase_shopping_app/constants.dart';
import '../Services/auth_service.dart' show AuthService;
//Screens
import 'Screens/Auth/LoginScreen.dart' show LoginScreen;
import 'Screens/Auth/RegisterScreen.dart' show RegisterScreen;
import 'Screens/AppScreen.dart' show AppScreen;
import 'Screens/AccountScreen.dart' show AppAccountScreen;
import 'Screens/ProductListScreen.dart' show AppProductListScreen;
import 'Screens/ProductScreen.dart' show AppProductScreen;
// Args
import 'Types/Product.dart' show ProductScreenArgs;

const routeAuthLoginPage = 'login';
const routeAuthRegisterPage = 'register';
const routeAppPage = "app";
const routeAccountPage = "account";
const routeProductListPage = "product_list";
const routeProductPage = "product";


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
    else if(routeName == routeProductListPage){
      final args = settings.arguments as Category;
      page = AppProductListScreen(category: args);
    }
    else if(routeName.startsWith(routeProductPage)){
      final subRoute = routeName.substring(routeProductPage.length);
      final args = settings.arguments as ProductScreenArgs;
      page = AppProductScreen(subRouteName: subRoute, args: args);
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