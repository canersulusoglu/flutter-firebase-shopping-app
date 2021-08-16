// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child:
                Image.asset("assets/images/loginScreenImage.png", width: 250),
          ),
          Container(
            margin: const EdgeInsets.all(40),
            child: const SizedBox(
              child: LoginForm(),
              height: 250,
            ),
          )
        ],
      )),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  bool passwordIsHidden = true;

  void togglePasswordVisibility() {
    setState(() {
      passwordIsHidden = !passwordIsHidden;
    });
  }

  Future<void> onFormSubmit() async {
    if(loginFormKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailInputController.text,
              password: passwordInputController.text)
          .then((signedUser) => {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/main", (route) => false)
              });
      } on FirebaseAuthException catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${err.message}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
        child: Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Login",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text("Sign in to your account.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
            ],
          ),
        ),
        Flexible(
            child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            autofocus: false,
            controller: emailInputController,
            decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email),),
            validator: (String? value) {
              if(value!.isEmpty) {
                return "This area can not be empty";
              }
              return null;
            },
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
                  ))),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: "Don't have an account yet? ",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              TextSpan(
                  text: "Register!",
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, "/register");
                    }),
            ])),
            ElevatedButton(onPressed: onFormSubmit, child: const Text("Login"))
          ],
        )
      ],
    ));
  }
}
