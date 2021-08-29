import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Utils/ReturnData.dart';

class UserData{
  String? name;
  String? surname;
  String? email;
  String? phoneNumber;
  UserData({this.name, this.surname, this.email, this.phoneNumber});
}

class AuthService{
  static final AuthService _instance = AuthService._internal();
  factory AuthService() {
    return _instance;
  }
  AuthService._internal();
  static AuthService get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  UserData _loggedUserData = UserData();

  bool get isUserLoggedIn => (_auth.currentUser != null); 
  UserData get getLoggedUserData => _loggedUserData;
  
  Future<ReturnData> register(String email, String password, String name, String surname, String phoneNumber) async{
    try {
      if(!isUserLoggedIn){
        UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email,password: password);
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
        UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email,password: password);
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
        await _auth.signOut();
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
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser!.uid).get();
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
        await _store.collection("Users").doc(_auth.currentUser?.uid).update({
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
        await _auth.currentUser?.updateEmail(newEmail);
        await _store.collection("Users").doc(_auth.currentUser?.uid).update({
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
        await _store.collection("Users").doc(_auth.currentUser?.uid).update({
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
        AuthCredential credential = EmailAuthProvider.credential(email: _auth.currentUser!.email.toString(), password: oldPassword);
        await _auth.currentUser!.reauthenticateWithCredential(credential)
        .then((UserCredential userCredential) => {
          _auth.currentUser?.updatePassword(newPassword),
        });
      }
      return ReturnData(isSuccessful: true);
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }
  
}