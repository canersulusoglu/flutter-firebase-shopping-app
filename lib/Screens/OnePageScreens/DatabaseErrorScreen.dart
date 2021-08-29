// ignore_for_file: file_names
import 'package:flutter/material.dart';

class DatabaseErrorScreen extends StatefulWidget {
  const DatabaseErrorScreen({ Key? key }) : super(key: key);

  @override
  _DatabaseErrorScreenState createState() => _DatabaseErrorScreenState();
}

class _DatabaseErrorScreenState extends State<DatabaseErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.error_outline, size:120, color: Theme.of(context).colorScheme.error),
            const Text("Database Connection Error", style: TextStyle(fontSize: 24),)
          ],
        ),
      )
    );
  }
}