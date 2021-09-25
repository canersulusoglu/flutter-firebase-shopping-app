import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service.dart' show Service, ReturnData, MessageCode;
import '../DataTypes/UserData.dart' show UserData;

class AuthService extends Service{
  static final AuthService _instance = AuthService._internal();
  factory AuthService() {
    return _instance;
  }
  AuthService._internal();
  static AuthService get instance => _instance;

  UserData _loggedUserData = UserData();

  bool get isUserLoggedIn => (firebaseAuth.currentUser != null); 
  UserData get getLoggedUserData => _loggedUserData;
  
  Future<ReturnData> register(String email, String password, String name, String surname, String phoneNumber) async{
    try {
      if(!isUserLoggedIn){
        UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
        await FirebaseFirestore.instance.collection("Users").doc(authResult.user!.uid).set({
          "name": name,
          "surname": surname,
          "email": email,
          "phoneNumber": phoneNumber
        });
        authResult.user?.sendEmailVerification();
        return ReturnData.withMessage(isSuccessful: true, messageCode: MessageCode.registeredSuccessfully);
      }
      return ReturnData(isSuccessful: false);
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }

  Future<ReturnData> loginWithEmailAndPassword(String email, String password) async{
    try {
      if(!isUserLoggedIn){
        UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
        return ReturnData.withMessage(isSuccessful: true, messageCode: MessageCode.loginSuccessfully);
      }
      return ReturnData(isSuccessful: false);
    } on FirebaseException catch (err) {

      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }

  Future<bool> logOut() async{
    try {
      if(isUserLoggedIn){
        await firebaseAuth.signOut();
        return true;
      }
      return false;
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return false;
    }
  }

  Future<ReturnData> fetchLoggedUserData() async{
    if(isUserLoggedIn){
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection("Users").doc(firebaseAuth.currentUser!.uid).get();
      _loggedUserData = UserData(
        name: userData.data()!['name'],
        surname: userData.data()!['surname'],
        email: userData.data()!['email'],
        phoneNumber: userData.data()!['phoneNumber']
      );
      return ReturnData(isSuccessful: true);
    }
    logOut();
    return ReturnData(isSuccessful: false);
  }

  Future<bool> changeUserNameAndSurname(String newName, String newSurname) async{
    try {
      if(isUserLoggedIn){
        await firebaseFirestore.collection("Users").doc(firebaseAuth.currentUser?.uid).update({
          'name': newName,
          'surname': newSurname
        });
        _loggedUserData.name = newName;
        _loggedUserData.surname = newSurname;
        return true;
      }
      return false;
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return false;
    }
  }

  Future<bool> changeEmail(String newEmail) async {
    try {
      if(isUserLoggedIn){
        await firebaseAuth.currentUser?.updateEmail(newEmail);
        await firebaseFirestore.collection("Users").doc(firebaseAuth.currentUser?.uid).update({
          'email': newEmail
        });
        _loggedUserData.email = newEmail;
        return true;
      }
      return false;
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return false;
    }
  }

  Future<bool> changePhoneNumber(String newPhoneNumber) async {
    try {
      if(isUserLoggedIn){
        //await _auth.currentUser?.updatePhoneNumber();
        await firebaseFirestore.collection("Users").doc(firebaseAuth.currentUser?.uid).update({
          'phoneNumber': newPhoneNumber
        });
        _loggedUserData.phoneNumber = newPhoneNumber;
        return true;
      }
      return false;
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return false;
    }
  }

  Future<ReturnData> changePassword(String oldPassword, String newPassword) async {
    try {
      if(isUserLoggedIn){
        AuthCredential credential = EmailAuthProvider.credential(email: firebaseAuth.currentUser!.email.toString(), password: oldPassword);
        await firebaseAuth.currentUser!.reauthenticateWithCredential(credential)
        .then((UserCredential userCredential) => {
          firebaseAuth.currentUser?.updatePassword(newPassword),
        });
      }
      return ReturnData(isSuccessful: true);
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }
  
}