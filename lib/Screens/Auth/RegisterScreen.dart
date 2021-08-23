// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../../Utils/validator_extensions.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Image.asset("assets/images/registerScreenImage.png",
                width: 280),
          ),
          Container(
            margin: const EdgeInsets.all(40),
            child: const SizedBox(
              child: RegisterForm(),
              height: 500,
            ),
          )
        ],
      )),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController surnameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordConfirmInputController =
      TextEditingController();

  bool passwordIsHidden = true;
  bool passwordConfirmIsHidden = true;

  void togglePasswordVisibility() {
    setState(() {
      passwordIsHidden = !passwordIsHidden;
    });
  }

  void togglePasswordConfirmVisibility() {
    setState(() {
      passwordConfirmIsHidden = !passwordConfirmIsHidden;
    });
  }

  Future<void> showMyDialog(String title, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> onFormSubmit() async {
    if(registerFormKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailInputController.text,
                password: passwordInputController.text)
            .then((createdUser) => {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(emailInputController.text)
                      .set({
                    "name": nameInputController.text,
                    "surname": surnameInputController.text,
                    "email": emailInputController.text,
                    "phoneNumber": phoneNumberInputController.text
                  }),
                  showMyDialog("Success", 'Registered successfully!')
                });
      } on FirebaseAuthException catch (err) {
        showMyDialog("Error Code: " + err.code, err.message.toString());
        /*
          if (err.code == 'weak-password') {
            showMyDialog("Error",'The password provided is too weak.');//Password should be at least 6 characters
          } else if (err.code == 'emaıl-already-ın-use') {
            showMyDialog("Error", 'The account already exists for that email.'); // The email address is already in use by another account
          }
          */
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Register",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                Text("Sign up and start shopping..",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 20, right: 5),
                child: TextFormField(
                  autofocus: false,
                  controller: nameInputController,
                  decoration: const InputDecoration(
                      labelText: "Name", prefixIcon: Icon(Icons.badge)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "This area can not be empty.";
                    }
                    return null;
                  }
                ),
              )),
              Flexible(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 5),
                child: TextFormField(
                  autofocus: false,
                  controller: surnameInputController,
                  decoration: const InputDecoration(
                      labelText: "Surname", prefixIcon: Icon(Icons.badge)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "This area can not be empty.";
                    }
                    return null;
                  }
                ),
              )),
            ],
          ),
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              autofocus: false,
              controller: emailInputController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "Email", prefixIcon: Icon(Icons.email)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value){
                if(value!.isEmpty){
                  return "This area can not be empty.";
                }
                else if(!value.isEmail()) {
                  return "This is not an e-mail.";
                }
                return null;
              }
            ),
          )),
          Flexible(
            child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              autofocus: false,
              controller: phoneNumberInputController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                //PhoneInputFormatter(),
                MaskedInputFormatter('(###) ###-####', anyCharMatcher: RegExp(r"[0-9.]")),
              ],
              decoration: const InputDecoration(
                  labelText: "Phone Number", prefixIcon: Icon(Icons.phone)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value){
                if(value!.isEmpty){
                  return "This area can not be empty.";
                }
                return null;
              }
            ),
          )),
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
                obscureText: passwordIsHidden,
                autofocus: false,
                controller: passwordInputController,
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.vpn_key),
                    suffix: InkWell(
                      onTap: togglePasswordVisibility,
                      child: Icon(
                        passwordIsHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    )),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value){
                  if(value!.isEmpty){
                    return "This area can not be empty.";
                  }
                  return null;
                }
            ),
                
          )),
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
                obscureText: passwordConfirmIsHidden,
                autofocus: false,
                controller: passwordConfirmInputController,
                decoration: InputDecoration(
                    labelText: "Password Confirm",
                    prefixIcon: const Icon(Icons.vpn_key),
                    suffix: InkWell(
                      onTap: togglePasswordConfirmVisibility,
                      child: Icon(
                        passwordConfirmIsHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    )),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value){
                  if(value!.isEmpty){
                    return "This area can not be empty.";
                  }else if(value != passwordInputController.text){
                    return "Passwords don't match.";
                  }
                  return null;
                }
              ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Already have account? ",
                    style: DefaultTextStyle.of(context).style),
                TextSpan(
                    text: "Login!",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pop();
                      }),
              ])),
              ElevatedButton(
                  onPressed: onFormSubmit, child: const Text("Register"))
            ],
          )
        ],
      ),
    );
  }
}
