import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

 abstract class Service{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;
  FirebaseStorage get firebaseStorage => _firebaseStorage;
}


enum MessageCode{
  registeredSuccessfully,
  loginSuccessfully
}

class ReturnData{
  bool isSuccessful;
  String? firebaseMessageCode;
  MessageCode? messageCode;
  var data;

  ReturnData({required this.isSuccessful});
  ReturnData.withMessage({required this.isSuccessful, required this.messageCode});
  ReturnData.withFirebaseMessage({required this.isSuccessful, required this.firebaseMessageCode});
  ReturnData.withOnlyData({required this.isSuccessful, required this.data});
  ReturnData.withMessageAndData({required this.isSuccessful, required this.messageCode, required this.data});
  ReturnData.withFirebaseMessageAndData({required this.isSuccessful, required this.firebaseMessageCode, required this.data});

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