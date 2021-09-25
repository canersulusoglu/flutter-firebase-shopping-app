// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../DataTypes/Arguments.dart' show ProductScreenArgs, VendorScreenArgs;
// Screens
import 'Product/HomeScreen.dart' show ProductHomeScreen;
import 'Product/DetailScreen.dart' show ProductDetailScreen;


const routeProductHomePage = "/";
const routeProductDetailPage = "/product_detail";

class AppProductScreen extends StatefulWidget {
  final String subRouteName;
  final ProductScreenArgs args;
  const AppProductScreen({ Key? key, required this.subRouteName, required this.args}) : super(key: key);

  @override
  _AppProductScreenState createState() => _AppProductScreenState();
}

class _AppProductScreenState extends State<AppProductScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  String currentScreen = routeProductHomePage;

  void _exitProductScreen() {
    Navigator.of(context).pop(true);
  }

  void _goToProductHomeScreen(){
    _navigatorKey.currentState!.popAndPushNamed(routeProductHomePage);
    currentScreen = routeProductHomePage;
  }

  void _goToProductDetailScreen(){
    _navigatorKey.currentState!.popAndPushNamed(routeProductDetailPage);
    currentScreen = routeProductDetailPage;
  }

  void _goToVendorScreen(String vendorId){
    Navigator.of(context).pushNamed("vendor", arguments: VendorScreenArgs(vendorId: vendorId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(currentScreen == routeProductDetailPage){
          _goToProductHomeScreen();
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
              case routeProductHomePage:
                page = ProductHomeScreen(
                  args: widget.args,
                  exitProductScreen: _exitProductScreen,
                  goToProductDetailScreen: _goToProductDetailScreen,
                  goToVendorScreen: _goToVendorScreen
                );
                break;
              case routeProductDetailPage:
                page = ProductDetailScreen(
                  args: widget.args,
                  goToProductHomeScreen: _goToProductHomeScreen
                );
                break;
              default:
                page = ProductHomeScreen(
                  args: widget.args,
                  exitProductScreen: _exitProductScreen,
                  goToProductDetailScreen: _goToProductDetailScreen,
                  goToVendorScreen: _goToVendorScreen
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
        )
      )
    );
  }
}