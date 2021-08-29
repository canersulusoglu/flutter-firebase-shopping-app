// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../Utils/ThemeData.dart';

void showErrorMessageSnackBar(BuildContext context, String errorMessage){
  SnackBar snackbar = SnackBar(
    duration: const Duration(seconds: 4),
    backgroundColor: Theme.of(context).colorScheme.error,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(errorMessage, style: TextStyle(color: Theme.of(context).colorScheme.onError, fontSize: 18),),
          ),
        )
      ],
    ),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showSuccessMessageSnackBar(BuildContext context, String successMessage){
  SnackBar snackbar = SnackBar(
    duration: const Duration(seconds: 4),
    backgroundColor: Theme.of(context).additionalColorScheme.success,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(successMessage, style: TextStyle(color: Theme.of(context).additionalColorScheme.onSuccess, fontSize: 18),),
          ),
        )
      ],
    ),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}