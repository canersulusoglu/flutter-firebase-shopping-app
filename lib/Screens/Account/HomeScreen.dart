// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../AccountScreen.dart' show accountPages, Screen;

typedef GoToScreenCallback = Function(int routeIndex);

class AccountHomeScreen extends StatefulWidget {
  final GoToScreenCallback goToScreen;
  const AccountHomeScreen({ Key? key, required this.goToScreen }) : super(key: key);

  @override
  _AccountHomeScreenState createState() => _AccountHomeScreenState();
}

class _AccountHomeScreenState extends State<AccountHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(20),
      child: ListView.separated(
        itemCount: accountPages.length,
        itemBuilder: (BuildContext context, int index){
          Screen screen = accountPages[index];
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
              onTap: () => widget.goToScreen(index)
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}