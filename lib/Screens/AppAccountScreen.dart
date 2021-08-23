// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screen
import 'Account/SettingsScreen.dart' show SettingsScreen;
import 'Account/AssessmentsScreen.dart' show AssessmentsScreen;
import 'Account/FavoritesScreen.dart' show FavoritesScreen;
import 'Account/ListsScreen.dart' show ListsScreen;
import 'Account/AddressesScreen.dart' show AddressesScreen;
import 'Account/CustomerServiceScreen.dart' show CustomerServiceScreen;


// Account Page Screen Changer
class Screens {
  final String title;
  final String subTitle;
  final Icon icon;
  final Widget widget;
  const Screens({ required this.title, required this.subTitle, required this.icon, required this.widget});
}

class AccountScreenChanger extends ChangeNotifier {
  int _selectedIndex = -1;
  final List<Screens> appAccountPages = [
    const Screens(icon: Icon(Icons.tune_outlined), title: "Settings", subTitle: "Settings subTitle", widget: SettingsScreen()),
    const Screens(icon: Icon(Icons.reviews_outlined), title: "My Assessments", subTitle: "My Assessments subTitle", widget: AssessmentsScreen()),
    const Screens(icon: Icon(Icons.favorite_border_outlined), title: "My Favorites", subTitle: "My Favorites subTitle", widget: FavoritesScreen()),
    const Screens(icon: Icon(Icons.bookmark_border_outlined), title: "My Lists", subTitle: "My Lists subTitle", widget: ListsScreen()),
    const Screens(icon: Icon(Icons.place_outlined), title: "My Addresses", subTitle: "My Addresses subTitle", widget: AddressesScreen()),
    const Screens(icon: Icon(Icons.support_agent_outlined), title: "Customer Service", subTitle: "Customer Service subTitle", widget: CustomerServiceScreen()),
  ];
  AccountScreenChanger();

  bool get isHomeScreen => _selectedIndex == -1;
  Widget getSelectedScreen (){
    if(isHomeScreen){
      return homeScreen();
    }else{
      return appAccountPages.elementAt(_selectedIndex).widget;
    }
  }
  String get getSelectedScreenTitle => appAccountPages.elementAt(_selectedIndex).title;
  String get getSelectedScreenSubTitle => appAccountPages.elementAt(_selectedIndex).subTitle;
  Icon get getSelectedScreenIcon => appAccountPages.elementAt(_selectedIndex).icon;

  void goToHomeScreen(){
    _selectedIndex = -1;
    notifyListeners();
  }

  void goToSelectedIndexScreen(int index){
    _selectedIndex = index;
    notifyListeners();
  }

  Widget homeScreen(){
    return Flexible(
      child: ListView.separated(
        itemCount: appAccountPages.length,
        itemBuilder: (BuildContext context, int index){
          Screens screen = appAccountPages[index];
          return Ink(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.only(left:20, top: 10, bottom: 10),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(padding: const EdgeInsets.only(right: 15), child: screen.icon),
                            Text(screen.title, style: const TextStyle(fontSize: 20,)),
                          ],
                        ),
                        Text(screen.subTitle, style: const TextStyle(fontSize: 12),)
                      ],
                    ),
                    const Icon(Icons.arrow_right,size: 40,)
                  ],
                ),
              ),
              onTap: () => goToSelectedIndexScreen(index)
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    );
  }
}

class AppAccountScreen extends StatefulWidget {
  const AppAccountScreen({ Key? key }) : super(key: key);

  @override
  _AppAccountScreenState createState() => _AppAccountScreenState();
}

class _AppAccountScreenState extends State<AppAccountScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AccountScreenChanger())
        ],
        builder: (context, _) {
          return Column(
            children: [
              if (!Provider.of<AccountScreenChanger>(context).isHomeScreen) ...[
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
                                    onPressed: (){
                                      Provider.of<AccountScreenChanger>(context, listen: false).goToHomeScreen();
                                    }
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
                                        Provider.of<AccountScreenChanger>(context).getSelectedScreenTitle, 
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Provider.of<AccountScreenChanger>(context).getSelectedScreenSubTitle, 
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )
                                ),
                                Provider.of<AccountScreenChanger>(context).getSelectedScreenIcon
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1,)
                    ],
                  )
                ),
              ],
              Provider.of<AccountScreenChanger>(context).getSelectedScreen()
            ],
          );
        }
      )
    );
  }
}