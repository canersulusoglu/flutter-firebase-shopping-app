// ignore_for_file: file_names
import 'package:flutter/material.dart';
// Screen
import 'Account/HomeScreen.dart' show AccountHomeScreen;
import 'Account/SettingsScreen.dart' show AccountSettingsScreen;
import 'Account/AssessmentsScreen.dart' show AccountAssessmentsScreen;
import 'Account/FavoritesScreen.dart' show AccountFavoritesScreen;
import 'Account/ListsScreen.dart' show AccountListsScreen;
import 'Account/AddressesScreen.dart' show AccountAddressesScreen;
import 'Account/CustomerServiceScreen.dart' show AccountCustomerServiceScreen;

const routeAccountHomePage = "/";
const routeAccountSettingsPage = "/settings";
const routeAccountAssessmentsPage = "/assessments";
const routeAccountFavoritesPage = "/favorites";
const routeAccountListsPage = "/lists";
const routeAccountAddressesPage = "/addresses";
const routeAccountCustomerServicePage = "/customer_service";

class Screen {
  final String title;
  final String subTitle;
  final Icon icon;
  final String routeName;
  const Screen({ required this.title, required this.subTitle, required this.icon, required this.routeName});
}

final List<Screen> accountPages = [
  const Screen(icon: Icon(Icons.tune_outlined), title: "Settings", subTitle: "Settings subTitle", routeName: routeAccountSettingsPage),
  const Screen(icon: Icon(Icons.reviews_outlined), title: "My Assessments", subTitle: "My Assessments subTitle", routeName: routeAccountAssessmentsPage),
  const Screen(icon: Icon(Icons.favorite_border_outlined), title: "My Favorites", subTitle: "My Favorites subTitle", routeName: routeAccountFavoritesPage),
  const Screen(icon: Icon(Icons.bookmark_border_outlined), title: "My Lists", subTitle: "My Lists subTitle", routeName: routeAccountListsPage),
  const Screen(icon: Icon(Icons.place_outlined), title: "My Addresses", subTitle: "My Addresses subTitle", routeName: routeAccountAddressesPage),
  const Screen(icon: Icon(Icons.support_agent_outlined), title: "Customer Service", subTitle: "Customer Service subTitle", routeName: routeAccountCustomerServicePage),
];

class AppAccountScreen extends StatefulWidget {
  final String subRouteName;
  const AppAccountScreen({ Key? key, required this.subRouteName }) : super(key: key);

  @override
  _AppAccountScreenState createState() => _AppAccountScreenState();
}

class _AppAccountScreenState extends State<AppAccountScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int selectedScreenIndex = -1;

  void _goBack() {
    setState(() {
      selectedScreenIndex = -1;
    });
    _navigatorKey.currentState!.popAndPushNamed(routeAccountHomePage);
  }

  void _goToScreen(int screenIndex) {
    setState(() {
      selectedScreenIndex = screenIndex;
    });
    _navigatorKey.currentState!.popAndPushNamed(accountPages[screenIndex].routeName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(selectedScreenIndex != -1){
          _goBack();
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tooltip(
                      message: "Go Back",
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20), 
                      child:  Text("Account Settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    )
                  ],
                ),
                const Divider(thickness: 3)
              ],
            ),
          ),
        ),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.subRouteName,
          onGenerateRoute: (RouteSettings settings){
            late Widget page;
            String? routeName = settings.name;

            switch (routeName) {
              case routeAccountHomePage:
                page = AccountHomeScreen(goToScreen: _goToScreen);
                break;
              case routeAccountSettingsPage:
                page = const AccountSettingsScreen();
                break;
              case routeAccountAssessmentsPage:
                page = const AccountAssessmentsScreen();
                break;
              case routeAccountFavoritesPage:
                page = const AccountFavoritesScreen();
                break;
              case routeAccountListsPage:
                page = const AccountListsScreen();
                break;
              case routeAccountAddressesPage:
                page = const AccountAddressesScreen();
                break;
              case routeAccountCustomerServicePage:
                page = const AccountCustomerServiceScreen();
                break;
              default:
                page = AccountHomeScreen(goToScreen: _goToScreen);
                break;
            }

            if(selectedScreenIndex != -1){
              page = Column(
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Tooltip(
                                    message: "Go Back To Account Settings List",
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back_rounded, size: 18,),
                                      onPressed: _goBack
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20), 
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          accountPages[selectedScreenIndex].title, 
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          accountPages[selectedScreenIndex].subTitle, 
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )
                                  ),
                                  accountPages[selectedScreenIndex].icon, 
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 1,)
                      ],
                    )
                  ),
                  Expanded(child: page)
                ],
              );
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