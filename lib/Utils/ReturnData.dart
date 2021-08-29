// ignore_for_file: file_names
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum MessageCode{
  registeredSuccessfully,
  loginSuccessfully
}

class ReturnData{
  bool isSuccessful;
  String? firebaseMessageCode;
  MessageCode? messageCode;

  ReturnData({required this.isSuccessful});
  ReturnData.withMessage({required this.isSuccessful, required this.messageCode});
  ReturnData.withFirebaseMessage({required this.isSuccessful, required this.firebaseMessageCode});

  String getMessage(context){
    // Firebase Message Codes
    if(firebaseMessageCode != null){
      switch (firebaseMessageCode) {
        case "email-already-in-use":
          return AppLocalizations.of(context)!.emailAlreadyInUse;
        case "invalid-email":
          return AppLocalizations.of(context)!.invalidEmail;
        case "operation-not-allowed":
          return AppLocalizations.of(context)!.operationNotAllowed;
        case "weak-password":
          return AppLocalizations.of(context)!.weakPassword;
        case "user-disabled":
          return AppLocalizations.of(context)!.userDisabled;
        case "user-not-found":
          return AppLocalizations.of(context)!.userNotFound;
        case "wrong-password":
          return AppLocalizations.of(context)!.wrongPassword;
        case "requires-recent-login":
          return AppLocalizations.of(context)!.requiresRecentLogin;
        case "user-mismatch":
          return AppLocalizations.of(context)!.userMismatch;
        case "invalid-credential":
          return AppLocalizations.of(context)!.invalidCredential;
        case "invalid-verification-code":
          return AppLocalizations.of(context)!.invalidVerificationCode;
        case "invalid-verification-id":
          return AppLocalizations.of(context)!.invalidVerificationId;
        case "too-many-requests":
          return AppLocalizations.of(context)!.tooManyRequests;
        default:
          return "no-firebase-return-message";
      }
    }
    // Custom Message Codes
    else if(messageCode != null){
      switch (messageCode) {
        case MessageCode.registeredSuccessfully:
          return AppLocalizations.of(context)!.registeredSuccessfully;
        case MessageCode.loginSuccessfully:
          return AppLocalizations.of(context)!.loginSuccessfully;
        default:
          return "no-return-message";
      }
    }
    else{
      return "no-message";
    }
  }
}