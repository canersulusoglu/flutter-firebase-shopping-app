// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../Services/auth_service.dart' show AuthService;
import '../Components/AppSettingsModalBottomSheet.dart' show showAppSettingsModalBottomSheet;
import '../../Services/service.dart' show ReturnData;
// Screens
import 'OnePageScreens/LoadingScreen.dart' show LoadingScreen;
import 'OnePageScreens/DatabaseErrorScreen.dart' show DatabaseErrorScreen;
import 'App/HomeScreen.dart' show AppHomeScreen;
import 'App/CategoriesScreen.dart' show AppCategoriesScreen;
import 'App/ShoppingCartScreen.dart' show AppShoppingCartScreen;
import 'App/OrdersScreen.dart' show AppOrdersScreen;


class AppScreen extends StatefulWidget {
  const AppScreen({ Key? key }) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  TextEditingController searchInputController = TextEditingController();
  int bottomNavigationBarSelectedIndex = 0;
  late Widget bodyWidget;
  Future<ReturnData>? beforeLoadFetchDataFuture;
  Future<ReturnData>? beforeLoadFetchData() async {
    ReturnData result = await AuthService.instance.fetchLoggedUserData();
    //await Future.delayed(Duration(seconds: 60));
    return result;
  }

  @override
  void initState() {
    super.initState();
    beforeLoadFetchDataFuture = beforeLoadFetchData();
    bodyWidget = const AppHomeScreen();
  }

  void bottomNavigationBarItemTapped(int index){
    setState(() {
      if(bottomNavigationBarSelectedIndex != index){
        bottomNavigationBarSelectedIndex = index;
        switch (index) {
          case 0:
            bodyWidget = const AppHomeScreen();
            break;
          case 1:
            bodyWidget = const AppCategoriesScreen();
            break;
          case 2:
            bodyWidget = const AppShoppingCartScreen();
            break;
          case 3:
            bodyWidget = const AppOrdersScreen();
            break;
          default:
            bodyWidget = const AppHomeScreen();
            break;
        }
      }
    });
  }

  Future<void> logOut() async{
    bool result = await AuthService.instance.logOut();
    if(result){
      Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
    }
  }

  PreferredSizeWidget appBar(){
    return PreferredSize(
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
                          Navigator.pushNamed(context, "account/");
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
    );
  }

  BottomNavigationBar bottomNavigationBar(){
    return BottomNavigationBar(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: beforeLoadFetchDataFuture,
      builder: (BuildContext context, AsyncSnapshot<ReturnData> snap){
        if(snap.data == null){
          return const LoadingScreen();
        }else if(!snap.data!.isSuccessful){
          return const DatabaseErrorScreen();
        }else{
          return Scaffold(
            appBar: appBar(),
            bottomNavigationBar: bottomNavigationBar(), 
            body: bodyWidget
          );
        }
      }
    );
  }
}