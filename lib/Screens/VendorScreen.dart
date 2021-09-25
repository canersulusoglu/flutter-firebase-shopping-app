// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../DataTypes/Arguments.dart' show VendorScreenArgs;
import 'Vendor/HomeScreen.dart' show VendorHomeScreen;
import 'Vendor/ProductsScreen.dart' show VendorProductsScreen;
import 'Vendor/AssessmentsScreen.dart' show VendorAssessmentsScreen;

const routeVendorHomePage = "/";
const routeVendorProductsPage = "/vendor_products";
const routeVendorAssessmentsPage = "/vendor_assessments";

class AppVendorScreen extends StatefulWidget {
  final String subRouteName;
  final VendorScreenArgs args;
  const AppVendorScreen({ Key? key, required this.subRouteName, required this.args }) : super(key: key);

  @override
  _AppVendorScreenState createState() => _AppVendorScreenState();
}

class _AppVendorScreenState extends State<AppVendorScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  String currentScreen = routeVendorHomePage;

  void _exitVendorScreen(){
    Navigator.of(context).pop(true);
  }

  void _goToVendorHomeScreen(){
    _navigatorKey.currentState!.popAndPushNamed(routeVendorHomePage);
    currentScreen = routeVendorHomePage;
  }

  void _goToVendorProductsScreen(){
    _navigatorKey.currentState!.popAndPushNamed(routeVendorProductsPage);
    currentScreen = routeVendorProductsPage;
  }

  void _goToVendorAssessmentsScreen(){
    _navigatorKey.currentState!.popAndPushNamed(routeVendorAssessmentsPage);
    currentScreen = routeVendorAssessmentsPage;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(currentScreen != routeVendorHomePage){
          _goToVendorHomeScreen();
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.subRouteName,
          onGenerateRoute: (RouteSettings settings){
            late Widget page;
            String? routeName = settings.name;

            switch (routeName) {
              case routeVendorHomePage:
                page = VendorHomeScreen(
                  args: widget.args,
                  exitVendorScreen: _exitVendorScreen,
                  goToVendorProductsScreen: _goToVendorProductsScreen,
                  goToVendorAssessmentsScreen: _goToVendorAssessmentsScreen
                );
                break;
              case routeVendorProductsPage:
                page = VendorProductsScreen(
                  args: widget.args, 
                  goToVendorHomeScreen: _goToVendorHomeScreen
                );
                break;
              case routeVendorAssessmentsPage:
                page = VendorAssessmentsScreen(
                  args: widget.args, 
                  goToVendorHomeScreen: _goToVendorHomeScreen
                );
                break;
              default:
                page = VendorHomeScreen(
                  args: widget.args, 
                  exitVendorScreen: _exitVendorScreen,
                  goToVendorProductsScreen: _goToVendorProductsScreen,
                  goToVendorAssessmentsScreen: _goToVendorAssessmentsScreen
                );
                break;
            }
            
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
              settings: settings,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        ),
      )
    );
  }
}