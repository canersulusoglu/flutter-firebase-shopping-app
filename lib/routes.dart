import 'package:flutter/material.dart';
import '../Services/auth_service.dart' show AuthService;
import 'Utils/ReturnData.dart' show ReturnData;
//Screens
import '../Screens/Auth/LoginScreen.dart' show LoginScreen;
import '../Screens/Auth/RegisterScreen.dart' show RegisterScreen;
import '../Screens/AppHomeScreen.dart' show AppHomeScreen;
import '../Screens/AppCategoriesScreen.dart' show AppCategoriesScreen;
import '../Screens/AppShoppingCartScreen.dart' show AppShoppingCartScreen;
import '../Screens/AppOrdersScreen.dart' show AppOrdersScreen;
import '../Screens/AppAccountScreen.dart' show AppAccountScreen;
// One Page Screens
import 'Screens/OnePageScreens/LoadingScreen.dart' show LoadingScreen;
import 'Screens/OnePageScreens/DatabaseErrorScreen.dart' show DatabaseErrorScreen;
//Components
import 'Components/AppSettingsModalBottomSheet.dart' show showAppSettingsModalBottomSheet;

const routeAuthLoginPage = 'login';
const routeAuthRegisterPage = 'register';
const routeAppHomePage = "app";
const routeAppAccountPage = "account";

class AppMainRoutes extends StatefulWidget {
  const AppMainRoutes({ Key? key }) : super(key: key);

  @override
  _AppMainRoutesState createState() => _AppMainRoutesState();
}

class _AppMainRoutesState extends State<AppMainRoutes> {
  TextEditingController searchInputController = TextEditingController();
  int bottomNavigationBarSelectedIndex = 0;
  Future<ReturnData>? beforeLoadFetchDataFuture;
  Future<ReturnData>? beforeLoadFetchData() async {
    ReturnData result = await AuthService.instance.fetchLoggedUserData();
    await Future.delayed(Duration(seconds: 5));
    return result;
  }

  @override
  void initState() {
    super.initState();
    beforeLoadFetchDataFuture = beforeLoadFetchData();
  }
 

  final List<Widget> appPages = <Widget>[
    const AppHomeScreen(),
    const AppCategoriesScreen(),
    const AppShoppingCartScreen(),
    const AppOrdersScreen()
  ];

  void bottomNavigationBarItemTapped(int index){
    setState(() {
      bottomNavigationBarSelectedIndex = index;
    });
  }

  Future<void> logOut() async{
    bool result = await AuthService.instance.logOut();
    print("Logout result: $result");
    if(result){
      Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder(
      future: beforeLoadFetchDataFuture,
      builder: (BuildContext context, AsyncSnapshot<ReturnData> snap){
        if(snap.data == null){
          return const LoadingScreen();
        }
        else if(!snap.data!.isSuccessful){
          return const DatabaseErrorScreen();
        }
        else{
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(140.0),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(image: AssetImage("assets/images/app_logo.png"),width: 200),
                        Row(
                          children: [
                            Tooltip(
                              message: "App Settings",
                              child: IconButton(
                                icon: const Icon(Icons.settings),
                                onPressed: (){
                                  showAppSettingsModalBottomSheet(context);
                                }
                              ),
                            ),
                            Tooltip(
                              message: "Account",
                              child: IconButton(
                                icon: const Icon(Icons.account_circle),
                                onPressed: () {
                                  Navigator.pushNamed(context, "account");
                                },
                              ),
                            ),
                            Tooltip(
                              message: "Exit",
                              child: IconButton(
                                icon: const Icon(Icons.exit_to_app),
                                onPressed: logOut,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5,left: 5),
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0, style: BorderStyle.solid)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: searchInputController,
                              autofocus: false,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                hintText: "Search",
                                contentPadding: EdgeInsets.only(top: 14),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.qr_code),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera),
                            onPressed: () {},
                          ),
                          
                        ],
                      ),
                    ),
                    const Divider(thickness: 3)
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavigationBarSelectedIndex,
              onTap: bottomNavigationBarItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2),
                  label: 'Orders',
                ),
              ],
            ),
            body: appPages.elementAt(bottomNavigationBarSelectedIndex),
          );
        }
      }
    );
  }
}


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
    if(routeName == routeAppHomePage){
      page = const AppMainRoutes();
    }
    else if(routeName == routeAppAccountPage){
      page = const AppAccountScreen();
    }
    else{
      page = const AppMainRoutes();
    }
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}